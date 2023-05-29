trigger AccountCndeletedifassocitedContact on Account (before Delete) 
{
    List<Account> accList = [select id, (select id from Contacts)from account where id in : trigger.old];
    
    for(Account a : Trigger.old){
        
        for(Account a1:accList){
            
            if(a1.Contacts.size()>=1){
                
                a.addError('not allowed!');
            }
            
        }
    }
}