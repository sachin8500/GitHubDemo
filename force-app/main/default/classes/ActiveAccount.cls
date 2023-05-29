public class ActiveAccount {
    
    Public static void activeAccountNotAllowedToDelete(List<account> accList){
        
            for (account acc : accList){
            
            if(acc.Active__c =='Yes'){
                
                acc.addError('not allowed');
    }
    
        }

}
}