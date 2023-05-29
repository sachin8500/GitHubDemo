public class RollupSummuryContact 
{
    
    public static void CountofContactOnAccount(List<Contact> newList, List<Contact> oldList)
    {
        set<id> accIds = new set<id>();
        if(newList!=null){
            for (Contact con:newList)
            {
                if(con.accountId!=null){
                  accIds.add(con.accountId);  
                }
                
            }
        }
         if(newList!=null){
            for (Contact con:newList)
            {
                if(con.accountId!=null){
                  accIds.add(con.accountId);  
                }
                
            }
        }
        
        List<Account> accList =[select id, No_Of_Contact__c,(select id from Contacts) from Account where id in:accIds];
        
        for(Account acc:accList)
        {
            acc.No_Of_Contact__c = acc.Contacts.size();
        }
        
        if(!accList.isEmpty())
        {
            database.update(accList,false);
        }
        
    }
}