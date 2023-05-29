trigger CreateContsFromAccount on Account (after insert) {
    
    if (trigger.isInsert && trigger.isafter){
        
        CreateContsbyAccountHandler.contactCreateByAccHandler(trigger.new);
    }
}