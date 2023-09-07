/*
********************************************************************************************************************************************************
Class Name     :  ar_NotificationController 
Purpose        :  Class responsible for constructing the data in the 90 day renewal notification.
                  Invoked from the Email Template's (Template Name : Auto Renewal Template New, Folder : UnifiedPublicTemplates) visual force component.
History:                                                            
-------                                                            
VERSION  AUTHOR                 DATE            DETAIL                                                                              TICKET REFERENCE/ NO.
1.       Vijay Manchuri        12/13/2017      Original Version - AR Pricing calculated from opportunity Line Items.
2.       Karthik Gummala       04/04/2018      Redesigned the calculation of pricing - From Quote Line Items.
                                               Updated the template to roll up quantity and price for the renewal pricing.
3.       Karthik Gummala        05/25/2018     fixed an issue with pricing for Add-On Service products.                             EAT-2118
4.       Fang Wang              4/7/2021       Replace Zuora Subscription by CPQ Billing Subscription 
4.       Vikhyat Tandon         09/30/2021     Update query to extract Days_Remaining_for_Auto_Renewal__c field on the              Q2O-3619
                                               opportuntiy to set the renewal left days on the template component. Plus
                                               updated queries to fix the template wordings for 30/60/90 days renewal
                                               reminders
5.      Balakrishna M           2/23/2023      RTB-8918 Updating the net price logic for the support product
6.      Nagesh M                04/24/2023     Updated the logic to display Contracting Entity Change message dynamically.          ABR-18
7.      Nagesh M                05/16/2023     60 and 30 Day Template for auto renewal notification emails                          ABR-42
8.      Nagesh M                06/08/2023     Contract start and end for 30/60 day notifications for original and AR quote         ABR-69
9.      Nagesh M                07/26/2023     ABR-116. Display Total Seats and Envelops                                            ABR-116
10.     Nagesh M                08/26/2023     ABR-171. Net total price on AR 60 day notification email needs correction            ABR-171
*********************************************************************************************************************************************************
*/

public class ar_NotificationController {
    // getter setter variables.
    public Id renewalOppId { get; set; }
    public Id renewalOppAcctId { get; set; }
    public Opportunity oppObj { get; set; }
    public String billToContactName { get; set; }
    public String renewalStartDate { get; set; }
    public CPQ_Billing_Subscription__c subsObj { get; set; }
    public Apttus_Proposal__Proposal__c proposalObj { get; set; }
    public List<SubscriptionChargesWrapper> currentProdList { get; set; }
    public List<SubscriptionChargesWrapper> renewalProdList { get; set; }
    public String upliftPerc { get; set; }
    public String thirtyDaysBeforeRenewal { get; set; }
    public Boolean isContractEntityChanged { get; set; }
    public String notificationType { get; set; }
    //ABR-18 Changes
    public String emailContentMessage {get; set;}
    public Decimal renewalTotalNetPrice {get; set;}
    public Decimal existingQuoteTotalNetPrice {get; set;}
    // ABR-116 Changes
    public Integer totalSeats {get; set;}
    public Integer totalEnvelopes {get; set;}
    public Map<String, SubscriptionChargesWrapper> mapOfoverageProdList { get; set; }
    public List<SubscriptionChargesWrapper> overageProdList { get; set; }
    public Boolean displayOverAge {get; set;}
    //ABR-118 Changes
    public String upcomingPaymentMethod {get; set;}
    public String upcomingPaymentTerm {get; set;}

    private Set<String> zuoraExternalIdSet = new Set<String>();
    private Map<Id, Product2> productMap = new Map<Id, Product2>();
    private Map<Id, Decimal> renewalProductIdPriceMap = new Map<Id, Decimal>();
    private Map<Id, Decimal> currentProductIdPriceMap = new Map<Id, Decimal>();
    private Map<String, Product2> sfdcZuoraProdMap = new Map<String, Product2>();
    private Map<String, String> supportProductCheckMap = new Map<String, String>();
   
    public ar_NotificationController() {
        this.billToContactName = System.Label.Notification_Admin_Name;
    }

    //method to fetch the current and renewal details
    public void getFetchRenewalQuoteDetails() {
        currentProdList = new List<SubscriptionChargesWrapper>();
        renewalProdList = new List<SubscriptionChargesWrapper>();
        overageProdList = new List<SubscriptionChargesWrapper>();  // ABR-116
        mapOfoverageProdList = new Map<String, SubscriptionChargesWrapper> (); // ABR-116
        displayOverAge = false; // ABR-116

        if (renewalOppId == null || renewalOppAcctId == null)
            return;

        oppObj = [
            SELECT Id, Name, Order_Start_Date__c, CPQ_OrderEndDate__c, AccountId, Account.Days_Remaining_for_Auto_Renewal__c, Renewal_Due_Date__c
            FROM Opportunity
            WHERE id = :renewalOppId
        ];

        // fetch billing subscription
        subsObj = [
            SELECT
                Id,
                Name,
                Account__c,
                Account__r.Uplift_Percentage__c,
                Start_Date__c,
                End_Date__c,
                Next_Renewal_Date__c,
                CurrencyIsoCode,
                Billing_Contact__c,
                Shipping_Contact__c,
                New_Renewal_Payment_Method__c,
                New_Renewal_Payment_Terms__c,              
                CPQ_Total_Final_Amount__c, // ABR-42 Changes
                (
                    SELECT
                        Id,
                        name,
                        CPQ_DocuSign_Admin__r.Name,
                        CPQ_BillTo__r.Name,
                        Apttus_Proposal__Proposal_Name__c,
                        Apttus_Proposal__Opportunity__c,
                        Apttus_QPConfig__BillToAccountId__c,
                        RecordTypeId,
                        Apttus_Proposal__Approval_Stage__c,
                        CPQ_Quote_Type__c,
                        CPQ_Quote_Sub_Type__c,
                        Is_Auto_Generated__c,                        
                        ownerId,
                        Apttus_Proposal__Payment_Term__c,
                        CPQ_Payment_Method__c
                    FROM Proposals__r
                    WHERE Apttus_Proposal__Approval_Stage__c IN ('Converted', 'Draft')
                    ORDER BY lastmodifieddate, Apttus_Proposal__Approval_Stage__c DESC
                    LIMIT 1
                )
            FROM CPQ_Billing_Subscription__c
            WHERE Account__c = :renewalOppAcctId AND Status__c = 'Active' AND Renewal_Term_Months__c != 0
            ORDER BY lastmodifiedDate DESC
            LIMIT 1
        ];

        //ABR-118- instance Notification on change Billing Contact, Shipping Contact, New Renewal Payment Terms , New Renewal Payment
           upcomingPaymentMethod = subsObj.New_Renewal_Payment_Method__c != null? subsObj.New_Renewal_Payment_Method__c : subsObj.CPQ_Payment_Method__c;
        // upcomingPaymentTerm = subsObj.New_Renewal_Payment_Terms__c != null? subsObj.New_Renewal_Payment_Terms__c : subsObj.Apttus_Proposal__Payment_Term__c;
        
        /*Date renewal30Days= (oppObj.Renewal_Due_Date__c).addDays(-30);
        Date renewal60Days= (oppObj.Renewal_Due_Date__c).addDays(-60);
        List<CPQ_Billing_Subscription__History> cpqBillingHistoryList;
       if(notificationType=='30Days'){
            cpqBillingHistoryList = [Select id,OldValue, NewValue, Parent.Name,Field, CreatedDate from CPQ_Billing_Subscription__History 
            where ParentId =: subsObj.Id and Field in ('Billing_Contact__c','Shipping_Contact__c','New_Renewal_Payment_Method__c','New_Renewal_Payment_Terms__c') and 
            (Createddate > : renewal60Days) and (Createddate < : renewal30Days)];
        }
        else if(notificationType=='60Days'){
            cpqBillingHistoryList = [Select id,OldValue, NewValue, Parent.Name,Field, CreatedDate from CPQ_Billing_Subscription__History 
            where ParentId =: subsObj.Id and Field in ('Billing_Contact__c','Shipping_Contact__c','New_Renewal_Payment_Method__c','New_Renewal_Payment_Terms__c') and 
            (Createddate < : renewal60Days)];
        }*/

        if (null != subsObj && oppObj != null) {
            renewalStartDate = oppObj.Renewal_Due_Date__c == null
                ? Datetime.newInstance(oppObj.Order_Start_Date__c.year(), oppObj.Order_Start_Date__c.month(), oppObj.Order_Start_Date__c.day())
                      .format('MMMMM dd, yyyy')
                : Datetime.newInstance(oppObj.Renewal_Due_Date__c.year(), oppObj.Renewal_Due_Date__c.month(), oppObj.Renewal_Due_Date__c.day())
                      .format('MMMMM dd, yyyy');
            Decimal upliftPercentage = subsObj.Account__r.Uplift_Percentage__c != null ? subsObj.Account__r.Uplift_Percentage__c : 5;
            upliftPerc = String.valueOf(upliftPercentage) + '%';
            Date renewalStartDate = oppObj.Order_Start_Date__c;
            Date renewalEndDate = oppObj.CPQ_OrderEndDate__c == null ? renewalStartDate.addMonths(12)-1 : oppObj.CPQ_OrderEndDate__c; // ABR-69 Changes.
            thirtyDaysBeforeRenewal = Datetime.newInstance(
                    oppObj.Order_Start_Date__c.year(),
                    oppObj.Order_Start_Date__c.month(),
                    oppObj.Order_Start_Date__c.day()
                )
                .addDays(-30)
                .format('MMMMM dd, yyyy');

            if (subsObj.Proposals__r != null && !subsObj.Proposals__r.isEmpty()) {
                proposalObj = subsObj.Proposals__r.get(0);
            } else {
                proposalObj = [
                    SELECT
                        id,
                        name,
                        CPQ_DocuSign_Admin__r.Name,
                        CPQ_BillTo__r.Name,
                        Apttus_Proposal__Proposal_Name__c,
                        Apttus_Proposal__Opportunity__c,
                        Apttus_QPConfig__BillToAccountId__c,
                        RecordTypeId,
                        Apttus_Proposal__Approval_Stage__c,
                        CPQ_Quote_Type__c,
                        CPQ_Quote_Sub_Type__c,
                        Apttus_Proposal__Payment_Term__c,
                        CPQ_Payment_Method__c,
                        Is_Auto_Generated__c,
                        ownerId
                    FROM Apttus_Proposal__Proposal__c
                    WHERE
                        Apttus_Proposal__Approval_Stage__c IN ('Converted')
                        AND CPQ_OpportunityOrderType__c IN ('New Customer', 'Renewal', 'Upgrade from Web', 'Expansion')
                        AND Apttus_QPConfig__BillToAccountId__c = :renewalOppAcctId
                    ORDER BY lastmodifieddate, Apttus_Proposal__Approval_Stage__c DESC
                    LIMIT 1
                ];
            }

            // Commenting because of using generic salutation as part of Q2O-5521
            // this.billToContactName = (null != proposalObj) ? proposalObj.CPQ_BillTo__r.Name : this.billToContactName;

            Apttus_Proposal__Proposal__c renewalQuoteObj = mockProposalObject(proposalObj);
            // ABR-18
            isContractEntityChanged = (renewalQuoteObj.Entity_Change__c == 'Yes');
            List<Object> params = new List<Object>{renewalQuoteObj.Previous_Entity__c, renewalQuoteObj.Contracting_Entity__c};
            List<Custom_Config__mdt> customAutoConfigs = [Select Id, ValueLong__c From Custom_Config__mdt Where DeveloperName='AutoRenewal_30Day_Notification_Language'];
            String thirtyDayLanguage = 'Your DocuSign subscription shall be governed by the terms of the Master Services Agreement originally entered into by you and {0} (“MSA”) and that for purposes of this renewal Order Form: (i) '+
            'you and {1} will be bound by the MSA and each party will be fully responsible for its liabilities and obligations under this Order Form and the MSA; and (ii) all references to “Customer” and “DocuSign” in '+
            'the MSA will be deemed references to you and {1} for purposes of defining the rights and obligations of the Parties thereunder.';
            emailContentMessage = !customAutoConfigs.isEmpty() && String.isNotBlank(customAutoConfigs[0].ValueLong__c)?String.valueOf(customAutoConfigs[0].ValueLong__c):thirtyDayLanguage;
            emailContentMessage = String.format(emailContentMessage, params);


            // fetch proposal lines for base order and add-ons and form a map that returns current and renewal price for each product line.
            Set<Id> resultOppSet = getOppIdsWithAddOns(oppObj);
            existingQuoteTotalNetPrice = 0;
            // ABR-116
            Set<String> overageProducts = new Set<String> {
                CPQ_OrderCreationConstants.CPQ_CHARGE_TYPE_OVERAGE_FEE, CPQ_OrderCreationConstants.CPQ_CHARGE_TYPE_OVERAGE_FEE_PER_UNIT
            };
            if (!resultOppSet.isEmpty()) {
                Map<Id, List<Apttus_Proposal__Proposal_Line_Item__c>> qliMap = getQuoteLineItems(resultOppSet);
                if (qliMap != null && !qliMap.isEmpty()) {
                    List<Apttus_Proposal__Proposal_Line_Item__c> lineItems = qliMap.get(oppObj.AccountId);

                    for (Apttus_Proposal__Proposal_Line_Item__c lineItem : lineItems) {
                        Decimal saleUnitPrice = lineItem.Apttus_QPConfig__NetPrice__c / lineItem.CPQ_Quantity_Truncated__c;
                        String productName = lineItem.Apttus_Proposal__Product__r.Name;
                        Date fromDate = lineItem.Apttus_Proposal__Proposal__r.CPQ_Start_Date__c;
                        Date toDate = subsObj.End_Date__c;
                        Decimal quantity = lineItem.CPQ_Quantity_Truncated__c;
                        Decimal price = saleUnitPrice != null ? saleUnitPrice : 0.00;
                        Decimal netPrice = lineItem.Apttus_QPConfig__NetPrice__c!=null?lineItem.Apttus_QPConfig__NetPrice__c:0.00; // ABR-171
                        SubscriptionChargesWrapper currentProd = new SubscriptionChargesWrapper(productName, fromDate, toDate, quantity, netPrice, 0); // ABR-171
                        // ABR-116 changes
                        if(lineItem.Apttus_QPConfig__ChargeType__c!=null && overageProducts.contains(lineItem.Apttus_QPConfig__ChargeType__c)){
                           currentProd.chargeType = lineItem.Apttus_QPConfig__ChargeType__c;
                           mapOfoverageProdList.put(productName, currentProd);
                        } else {
                           currentProdList.add(currentProd);
                        }  
                        if(lineItem.Apttus_QPConfig__PriceType__c != null &&  lineItem.Apttus_QPConfig__PriceType__c != 'Usage' ){
                           existingQuoteTotalNetPrice += currentProd.totalNetPrice;
                        }
                        currentProdList.sort();
                    }
                    // calculates the annualized renewal price by rolling up base and add-ons.
                    rollUpRenewalProducts(lineItems, renewalStartDate, renewalEndDate, upliftPercentage);
                    // ABR-116
                    if(!mapOfoverageProdList.isEmpty()){
                        overageProdList.addAll(mapOfoverageProdList.values());
                        displayOverAge = true;
                    }
                }
            }
        }
    }

    private Apttus_Proposal__Proposal__c mockProposalObject(Apttus_Proposal__Proposal__c oldProposalObject) {
        // Build Proposal Object
        Apttus_Proposal__Proposal__c renewalQuoteObj = new Apttus_Proposal__Proposal__c();
        renewalQuoteObj.Apttus_Proposal__Proposal_Name__c = oldProposalObject.Apttus_Proposal__Proposal_Name__c;
        renewalQuoteObj.Apttus_Proposal__Opportunity__c = oldProposalObject.Apttus_Proposal__Opportunity__c;
        renewalQuoteObj.Apttus_QPConfig__BillToAccountId__c = oldProposalObject.Apttus_QPConfig__BillToAccountId__c;
        renewalQuoteObj.RecordTypeId = oldProposalObject.RecordTypeId;
        renewalQuoteObj.ownerId = oldProposalObject.ownerId;
        renewalQuoteObj.CPQ_Quote_Type__c = CPQConstants.RENEWAL_TYPE;
        renewalQuoteObj.CPQ_Quote_Sub_Type__c = CPQConstants.QUOTE_SUB_TYPE_ON_TIME;
        renewalQuoteObj.Is_Auto_Generated__c = true;
        renewalQuoteObj.Apttus_Proposal__Approval_Stage__c = CPQConstants.PROPOSAL_DRAFT;
        renewalQuoteObj.Apttus_Proposal__Primary__c = true;

        ((CPQMultiEntityService) ServiceManager.getInstance(ServiceManager.SVC_ID_MULTI_ENTITY_IMPL))
            .setQuoteContractingEntity(new List<Apttus_Proposal__Proposal__c>{ renewalQuoteObj });
        return renewalQuoteObj;
    }

    public List<SubscriptionChargesWrapper> getExistingProducts() {
        return this.currentProdList;
    }

    public List<SubscriptionChargesWrapper> retreiveRenewalProdList() {
        return this.renewalProdList;
    }

    // This method calculates the total quantity and netprice including base and add-on orders.
    private void rollUpRenewalProducts(
        List<Apttus_Proposal__Proposal_Line_Item__c> renewalProdsList,
        Date fromDate,
        Date toDate,
        Decimal upliftPercentage
    ) {
        Map<String, List<Apttus_Proposal__Proposal_Line_Item__c>> lineItemMap = new Map<String, List<Apttus_Proposal__Proposal_Line_Item__c>>();
        Map<String, Decimal> productQuantityMap = new Map<String, Decimal>();
        Map<String, Decimal> productPriceMap = new Map<String, Decimal>();
        this.renewalTotalNetPrice = 0.00; // ABR-42 Changes
        this.totalSeats = 0; // ABR-116 changes
        this.totalEnvelopes =0; // ABR-116 changes
        for (Apttus_Proposal__Proposal_Line_Item__c lineItem : renewalProdsList) {
            if (lineItem.Apttus_QPConfig__PriceType__c != null && lineItem.Apttus_QPConfig__PriceType__c.equalsIgnoreCase('Recurring')) {
                if (lineItemMap.get(lineItem.Apttus_Proposal__Product__r.Name) == null) {
                    lineItemMap.put(lineItem.Apttus_Proposal__Product__r.Name, new List<Apttus_Proposal__Proposal_Line_Item__c>());
                }
                lineItemMap.get(lineItem.Apttus_Proposal__Product__r.Name).add(lineItem);

                Boolean isBaseProduct =
                    'Base Products | Add On Services'.contains(lineItem.Apttus_Proposal__Product__r.CPQ_Category__c) &&
                    lineItem.Apttus_Proposal__Product__r.Product_Category__c != 'Support Services' &&
                    lineItem.Apttus_Proposal__Product__r.Family != 'Support';
                if (isBaseProduct) {
                    if (!productQuantityMap.containsKey(lineItem.Apttus_Proposal__Product__r.Name)) {
                        productQuantityMap.put(lineItem.Apttus_Proposal__Product__r.Name, 0);
                    }
                    productQuantityMap.put(
                        lineItem.Apttus_Proposal__Product__r.Name,
                        productQuantityMap.get(lineItem.Apttus_Proposal__Product__r.Name) + Integer.valueOf(lineItem.CPQ_Quantity_Truncated__c)
                    );
                } else {
                    productQuantityMap.put(lineItem.Apttus_Proposal__Product__r.Name, 1);
                }

                if (!productPriceMap.containsKey(lineItem.Apttus_Proposal__Product__r.Name)) {
                    productPriceMap.put(lineItem.Apttus_Proposal__Product__r.Name, 0);
                }
                productPriceMap.put(
                    lineItem.Apttus_Proposal__Product__r.Name,
                    isBaseProduct
                        ? (productPriceMap.get(lineItem.Apttus_Proposal__Product__r.Name) +
                          (lineItem.Annualized_Sales_Price__c * Integer.valueOf(lineItem.CPQ_Quantity_Truncated__c)))
                        : (productPriceMap.get(lineItem.Apttus_Proposal__Product__r.Name) +
                          (lineItem.AnnualizedExtendedPrice__c * Integer.valueOf(lineItem.CPQ_Quantity_Truncated__c)))
                );
                // ABR-116 Changes:
                if(lineItem.Apttus_Proposal__Product__r.CPQ_Usage_Type__c==CPQConstants.SEATS){
                    this.totalSeats+= Integer.valueOf(lineItem.CPQ_Quantity_Truncated__c);
                }
                if(lineItem.Apttus_Proposal__Product__r.CPQ_Usage_Type__c==CPQConstants.ENVELOPES){
                    this.totalEnvelopes+= Integer.valueOf(lineItem.CPQ_Quantity_Truncated__c);
                } 
            }
        }

        if (!lineItemMap.isEmpty()) {
            for (String prodName : lineItemMap.keySet()) {
                SubscriptionChargesWrapper renewalProductObj = new SubscriptionChargesWrapper(
                    prodName,
                    fromDate,
                    toDate,
                    productQuantityMap.get(prodName),
                    productPriceMap.get(prodName),
                    upliftPercentage
                );
                this.renewalTotalNetPrice += renewalProductObj.totalupliftedNetPrice; // ABR-42 Changes //ABR-171
                renewalProdList.add(renewalProductObj);
            }
            this.renewalTotalNetPrice.setScale(2);
        }
    }

    private Set<Id> getOppIdsWithAddOns(Opportunity renewalOppObj) {
        Set<Id> oppIdSetWithAddOns = new Set<Id>();
        //Get the account associated opportunities
        for (Account accountObj : [
            SELECT
                Id,
                Name,
                (
                    SELECT Id, Name, CPQ_OrderEndDate__c
                    FROM Opportunities
                    WHERE
                        Order_Type__c IN ('New Customer', 'Renewal', 'Add-on', 'Upgrade from Web', 'Expansion')
                        AND stageName IN ('Closed Won')
                        AND CPQ_OrderEndDate__c != NULL
                    ORDER BY CPQ_OrderEndDate__c DESC
                )
            FROM Account
            WHERE Id = :renewalOppObj.AccountId
        ]) {
            Boolean isValid = (null != accountObj.Opportunities && !accountObj.Opportunities.isEmpty());
            if (isValid) {
                List<Opportunity> oppList = accountObj.Opportunities;
                Date orderEndDate = oppList.get(0).CPQ_OrderEndDate__c;
                for (Opportunity oppObj : oppList) {
                    if (oppObj.CPQ_OrderEndDate__c == orderEndDate) {
                        oppIdSetWithAddOns.add(oppObj.Id);
                    }
                }
            }
        }
        System.debug('oppIdSetWithAddOns' + oppIdSetWithAddOns);
        return oppIdSetWithAddOns;
    }

    private Map<Id, List<Apttus_Proposal__Proposal_Line_Item__c>> getQuoteLineItems(Set<Id> renewalsWithAddOns) {
        Map<Id, List<Apttus_Proposal__Proposal_Line_Item__c>> quoteLineItemMap = new Map<Id, List<Apttus_Proposal__Proposal_Line_Item__c>>();
        for (Apttus_Proposal__Proposal__c existingQuoteObj : getExistingConvertedAddOns(renewalsWithAddOns)) {
            List<Apttus_Proposal__Proposal_Line_Item__c> quoteLineItems = existingQuoteObj.R00N70000001yUfBEAU__r;
            for (Apttus_Proposal__Proposal_Line_Item__c qli : quoteLineItems) {
                if (quoteLineItemMap.get(existingQuoteObj.Apttus_Proposal__Account__c) == null) {
                    quoteLineItemMap.put(existingQuoteObj.Apttus_Proposal__Account__c, new List<Apttus_Proposal__Proposal_Line_Item__c>());
                }
                quoteLineItemMap.get(existingQuoteObj.Apttus_Proposal__Account__c).add(qli);
            }
        }
        return quoteLineItemMap;
    }

    // quotes and line items with add-ons. these two methods needs to be consolidated later.
    private List<Apttus_Proposal__Proposal__c> getExistingConvertedAddOns(Set<Id> oppIdWithAddOns) {
        return [
            SELECT
                Id,
                name,
                Apttus_Proposal__Approval_Stage__c,
                Apttus_Proposal__Proposal_Name__c,
                OwnerId,
                Apttus_Proposal__Account__c,
                Apttus_Proposal__Opportunity__c,
                Apttus_QPConfig__PriceListId__c,
                CPQ_Quote_Sub_Type__c,
                CPQ_Quote_Type__c,
                RecordTypeId,
                CPQ_Start_Date__c,
                CPQ_Initial_Term_Months__c,
                Apttus_Proposal__Valid_Until_Date__c,
                CPQ_Billing_Frequency__c,
                CPQ_Payment_Method__c,
                Apttus_Proposal__Payment_Term__c,
                Auto_Renewable__c,
                Uplift_percentage__c,
                Auto_Renew__c,
                CPQ_Subscription_ID__c,
                Apttus_QPConfig__BillToAccountId__c,
                CPQ_BillTo__c,
                CPQ_Sold_To__c,
                Apttus_QPConfig__ShipToAccountId__c,
                CPQ_Ship_to_Contact__c,
                CPQ_DocuSign_Admin__c,
                CPQ_Customer_Signer__c,
                CPQ_Bill_to_Contact_Email__c,
                Apttus_Proposal__Account__r.Client_Services_Executive__r.Email,
                Apttus_Proposal__Account__r.Owner.Email,
                CPQ_BillTo__r.Email,
                CPQ_DocuSign_Admin__r.Email,
                (
                    SELECT
                        Id,
                        Name,
                        Apttus_Proposal__Proposal__c,
                        Apttus_QPConfig__PriceType__c,
                        Apttus_Proposal__Product__r.CPQ_Category__c,
                        Apttus_Proposal__Product__r.Product_Category__c,
                        Apttus_Proposal__Product__r.Family,
                        Apttus_Proposal__Product__r.Name,
                        Apttus_Proposal__Proposal__r.CPQ_Start_Date__c,
                        Apttus_QPConfig__NetPrice__c,
                        Annualized_Sales_Price__c,
                        AnnualizedExtendedPrice__c,
                        CPQ_Quantity_Truncated__c,
                        Apttus_Proposal__Product__c,
                        Apttus_Proposal__Product__r.CPQ_Zuora_Product_ID__c,
                        Apttus_QPConfig__AdjustmentType__c,
                        Apttus_QPConfig__NetAdjustmentPercent__c,
                        Apttus_Proposal__Product__r.CPQ_Usage_Type__c, // ABR-116 Changes
                        Apttus_QPConfig__ChargeType__c  // ABR-116 Changes
                    FROM R00N70000001yUfBEAU__r
                    WHERE
                        Subscription_Number__c != NULL
                        OR Apttus_Proposal__Product__r.Subscription_Group__c != 'Support'
                        OR (NOT Apttus_QPConfig__ChargeType__c LIKE '%-%')
                )
            FROM Apttus_Proposal__Proposal__c
            WHERE
                Apttus_Proposal__Opportunity__c IN :oppIdWithAddOns
                AND CPQ_OpportunityOrderType__c IN ('New Customer', 'Renewal', 'Add-on', 'Upgrade from Web', 'Expansion')
                AND Apttus_Proposal__Approval_Stage__c = 'Converted'
                AND CPQ_Primary__c = TRUE
        ];
    }

    //calculate renewal pricing based on the base order and add-on pricing with a % uplift.
    private Map<Id, Decimal> getRenewalPricing(List<Apttus_Proposal__Proposal_Line_Item__c> proposalLineItems) {
        Map<Id, Decimal> renewalproductAdjustmentMap = new Map<Id, Decimal>();
        for (Apttus_Proposal__Proposal_Line_Item__c lineItem : proposalLineItems) {
            if (!renewalproductAdjustmentMap.containsKey(lineItem.Apttus_Proposal__Product__c)) {
                renewalproductAdjustmentMap.put(lineItem.Apttus_Proposal__Product__c, 0.0);
            }
            renewalproductAdjustmentMap.put(
                lineItem.Apttus_Proposal__Product__c,
                renewalproductAdjustmentMap.get(lineItem.Apttus_Proposal__Product__c) + (lineItem.Annualized_Sales_Price__c)
            );
        }
        System.debug('renewalproductAdjustmentMap' + renewalproductAdjustmentMap);
        return renewalproductAdjustmentMap;
    }

    //calculate renewal pricing based on the base order and add-on pricing with a % uplift.
    private Map<Id, Decimal> getCurrentPricing(List<Apttus_Proposal__Proposal_Line_Item__c> proposalLineItems) {
        Map<Id, Decimal> productAdjustmentMap = new Map<Id, Decimal>();
        for (Apttus_Proposal__Proposal_Line_Item__c lineItem : proposalLineItems) {
            if (!productAdjustmentMap.containsKey(lineItem.Apttus_Proposal__Product__c)) {
                productAdjustmentMap.put(lineItem.Apttus_Proposal__Product__c, 0.0);
            }
            productAdjustmentMap.put(
                lineItem.Apttus_Proposal__Product__c,
                lineItem.Apttus_QPConfig__NetPrice__c / lineItem.CPQ_Quantity_Truncated__c
            );
        }
        System.debug('productAdjustmentMap' + productAdjustmentMap);
        return productAdjustmentMap;
    }

    //wrapper class
    public class SubscriptionChargesWrapper implements comparable {
        public String productName { get; set; }
        public String fromDate { get; set; }
        public String toDate { get; set; }
        public Decimal quantity { get; set; }
        public Decimal netPrice { get; set; }
        public Decimal upliftPercentage { get; set; }
        public Decimal totalNetPrice {get; set;}
        public String chargeType { get; set; } //ABR-116
        public Decimal totalupliftedNetPrice {get; set;} // ABR-171

        public SubscriptionChargesWrapper(
            String productName,
            Date fromDate,
            Date toDate,
            Decimal quantity,
            Decimal netPrice,
            Decimal upliftPercentage
        ) {
            this.productName = productName;
            this.fromDate = Datetime.newInstance(fromDate.year(), fromDate.month(), fromDate.day()).format('MMMMM dd, yyyy');
            this.toDate = Datetime.newInstance(toDate.year(), toDate.month(), toDate.day()).format('MMMMM dd, yyyy');
            this.quantity = quantity;
            this.upliftPercentage = upliftPercentage;
            this.netPrice = netPrice; // ABR-171
            this.totalupliftedNetPrice = this.upliftPercentage <= 0 ? this.netPrice : (this.netPrice + (this.netPrice * this.upliftPercentage / 100)); // ABR-171
            this.totalupliftedNetPrice = this.totalupliftedNetPrice!=null? this.totalupliftedNetPrice.setScale(2, RoundingMode.HALF_UP):0.00; // ABR-171
            this.totalNetPrice = this.netPrice!=null?this.netPrice.setScale(2, RoundingMode.HALF_UP):0.00; // ABR-171
        }

        public Integer compareTo(Object compareTo) {
            //SubscriptionChargesWrapper subsWrapObj = (SubscriptionChargesWrapper) compareTo;
            return fromDate.compareTo(((SubscriptionChargesWrapper) compareTo).fromDate);
        }
    }
}
