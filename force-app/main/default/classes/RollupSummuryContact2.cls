public class RollupSummuryContact2 {
  
    public static void countOfContact(List<Contact> newList){
        
        set<id> accIds = new set<id>();
        
        if (newList != null){
            
            for(Contact c : newList){
                
                if(c.AccountId !=null){
                    
                    accIds.add(c.AccountId);
                }
            }
     
       
        List<Account> acc = [select id, No_Of_Contact__c,(select id from Contacts) from account where id in : accIds];
        
        if(acc!= null){
            
            for(Account a: acc){
                
                a.No_Of_Contact__c = a.Contacts.size();
            }
        }
        if(!acc.isEmpty()){
            
            upsert acc;
        }
    }
    
    }
    public static void countOfContact2(List<Contact>oldList){
        
        set<id> accIds = new set<id>();
        
        if(oldList != null){
            
            for(Contact c : oldList){
                
                if(c.AccountId!=null)
                    accIds.add(c.AccountId);
            }
        }
       
        List<Account> acc = [select id, No_Of_Contact__c,(select id from Contacts) from account where id in : accIds];
        
        if(acc!= null){
            
            for(Account a: acc){
                
                a.No_Of_Contact__c = a.Contacts.size();
            }
        }
        if(!acc.isEmpty()){
            
            upsert acc;
        }
    }

}