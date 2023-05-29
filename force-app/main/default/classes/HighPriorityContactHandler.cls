public class HighPriorityContactHandler {
    
    public static void HighPriorityContact(List<Contact> conList){
        string highPriorityContactName='';
        string contactPriority='Low';
        //fetchin the accout ids
        
        set<id> accountIds = new set<id>();
        
        for(Contact c: conList){
            if(c.accountId !=null){
                
                accountIds.add(c.accountId);
            }
            
        }
        
        List<Contact> existingContacts = [Select id, accountId,lastName,Priority__c from Contact where accountId in : accountIds];
        Map<Id,String>  contactToAccountId= new Map<Id,String> ();
        for(Contact c:existingContacts)
        {
            
            if(c.Priority__c=='Medium'){
                
                // if(contactPriority=='Low')
                // {
                contactPriority=c.Priority__c;
                highPriorityContactName=c.LastName;
                contactToAccountId.put(c.AccountId,c.LastName);
                // }
            }if(c.Priority__c=='High'){
                
                contactPriority=c.Priority__c;
                highPriorityContactName=c.LastName;
                contactToAccountId.put(c.AccountId,c.LastName);
            }
            if(contactPriority=='Low'){
                if(contactPriority=='Low'){
                    highPriorityContactName=c.LastName;
                    contactToAccountId.put(c.AccountId,c.LastName);
                    
                }
            }
        }
        if(!contactToAccountId.isEmpty()){
            List<Account> accs= [select id, High_Priority_Contact_Name__c from account where id in : accountIds];
            
            for (Account a:accs){
                a.High_Priority_Contact_Name__c =contactToAccountId.get(a.id);
                
            } update accs;
            
        } 
        
    }
    
}