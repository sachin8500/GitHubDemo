public class BatchCreateAccountRelationship implements database.Batchable<sObject>{
    
    public Database.QueryLocator start (Database.BatchableContext contect){
        string query = 'select id, name from Account';
        return Database.getQueryLocator(query);      
        
    }
    
    public void execute (Database.BatchableContext context, List<Account>lstAccounts){
        
        List<Account> lstAccToUpdate = new List<Account>(); 
        
        for (Account objAcc :  lstAccounts){
            
            objAcc.Is_Relationship_needed__c = true;
            
            lstAccToUpdate.add(objAcc);
        }
        
        //Database.update(List<SObject> sobjects, allOrNothing)
        List<Database.SaveResult> lstDaveResults = Database.update(lstAccToUpdate, false);
        
        for(Database.SaveResult result :  lstDaveResults){
            
            if (result.isSuccess()){
                
                System.debug('Acc Id  :'+ result.getId());
                
            }else {
                
                for(Database.Error error : result.getErrors()){
                    
                    System.debug('Erros Message : ' + error.getmessage());
                    System.debug('Error fiedl : '+ error.getFields());
                }
            }
        }
        
    }
    
    public void finish (Database.BatchableContext context){
        
        Messaging.SingleEmailMessage mail= new Messaging.SingleEmailMessage();
        String[] arrToAddress = new String[]{'savitha.more19@gmail.com'};
        
        mail.setToAddresses(arrToAddress);
        mail.setReplyTo('savitha.more19@gmail.com');
        mail.setSenderDisplayName('Account Batch Job Result');
        mail.setSubject('Account Batch Job Result');
        //mail.setBccAddresses(false);
        //mail.plaintextbody('BatchCreateAccountRelationship has beed finished');
        mail.setHtmlBody('<h2 style="color: red;">BatchCreateAccountRelationshiphas beed finished');
        
        Messaging.SendEmail(new Messaging.SingleEmailMessage []{mail});
    }
}






//xyz  inteface
//test()
//test2()