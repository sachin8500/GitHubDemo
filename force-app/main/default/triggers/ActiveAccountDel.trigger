trigger ActiveAccountDel on Account (before delete) {
    
    if(trigger.isBefore && trigger.isDelete){
        
      ActiveAccount.activeAccountNotAllowedToDelete(trigger.old); 
        
    }
    
      
}