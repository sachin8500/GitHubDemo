trigger DuplicateRecordsTrigger on Account (before insert) {
    
    if(trigger.isBefore && trigger.isInsert){
        
        DuplicateRecords.DupRecordsNotallowed(trigger.new);
    }
    
    

}