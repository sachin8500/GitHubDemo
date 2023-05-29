trigger JobClassTrigger on Job__c (before insert, before update) {
    
    if(trigger.isBefore == true && trigger.isInsert == true){
        
        JobClassDemo.selectStatus(trigger.new);
        
    }
   
    if(trigger.isBefore == true && trigger.isUpdate == true){
        
        JobClassDemo.selectStatus(trigger.new);
    }

}