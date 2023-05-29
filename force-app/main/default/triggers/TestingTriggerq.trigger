trigger TestingTriggerq on Student__c (before insert,before update, before delete) {


if (trigger.isBefore && trigger.isInsert){
    
    system.debug('this is before insert trigger');
}

if(trigger.isBefore && trigger.isUpdate){
    
    system.debug('this is before update trigger');
}

if(trigger.isBefore && trigger.isDelete){
    
    system.debug('this is before Delete trigger');
}


}