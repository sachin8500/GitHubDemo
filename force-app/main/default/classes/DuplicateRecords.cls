public class DuplicateRecords {

    public static void DupRecordsNotallowed(List<Account> accList){
        
        for(Account acc : accList){
            
            for(Account acc1 :[select Id, Name from Account]){
                
                if(acc.name==acc1.name){
                    
                    acc.addError('not allowed!');
                }
            }
        }
    }
}