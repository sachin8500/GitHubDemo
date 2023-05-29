trigger Count_productaOnOPP on Product2 (After insert) 
{
	set<id> oppIds = new set<id> ();
    for(Product2 pro:Trigger.new)
    {
        oppIds.add(pro.Id);
        
    }
    
    List<Opportunity> oppList = [select id,No_of_Products__c,(select id from OpportunityLineItems) from 
                                 Opportunity where id in:oppIds];
    
    for(Opportunity opp:oppList){
        opp.No_of_Products__c = opp.OpportunityLineItems.size();
    }
    
    update oppList;
}