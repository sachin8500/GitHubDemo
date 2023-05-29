trigger MobilePriceTrigger on Mobile_Shope__c (before insert) {
    
    if(trigger.isbefore == true && trigger.isinsert==true){
        
        MobilePriceClass.MobileDiscount(trigger.new);      
        
       
    }

}