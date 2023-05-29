trigger ContactRecursionTrigger on Contact (before insert) {
    
    if(trigger.isBefore && trigger.isInsert){
        //RecursiveTriggerHandler.isFirst=false;
        RecursiveTriggerHandler.insertHandler(trigger.new);
    }

}