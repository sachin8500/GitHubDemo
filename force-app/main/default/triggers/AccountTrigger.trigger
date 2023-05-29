trigger AccountTrigger on Account (before insert, after insert) {

    if(Trigger.isInsert){
        if (Trigger.IsBefore){
    AccountTriggerHandler.beforeInsert(Trigger.new);
        }else if (Trigger.isAfter){
            AccountTriggerHandler.afterInsert(Trigger.new);
        }
        }
    }