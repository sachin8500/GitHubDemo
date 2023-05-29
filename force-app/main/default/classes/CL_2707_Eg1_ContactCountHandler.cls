public class CL_2707_Eg1_ContactCountHandler 

{
    public static void insertEvent(List<Contact> conlist){
        set<id> ids = New set<id>();
        
        for(Contact con:conlist)
        {
            ids.add(con.AccountId);
        }
        
    List<Account> accList = [select id, No_Of_Contact__c,(select id from Contacts) from Account where id in:ids];
        
        for(Account acc:accList){
            
            acc.No_Of_Contact__c = acc.contacts.size();
        } update accList;
        
    } 
         
    public static void updateEvent(List<Contact> conlist, Map<id,Contact> contactMap)
    {
        set<id> ids = new set<id> ();
        for(Contact con:conlist){
            ids.add(con.AccountId);
			Contact conOld = contactMap.get(con.id);
			ids.add(conOld.AccountId);           
        }
        List<Account> accList = [select id, No_Of_Contact__c,(select id from Contacts) from Account where id in:ids];
        for(Account acc:accList){
            acc.No_Of_Contact__c = acc.contacts.size();
        }
        
        update accList;
    }
        
    
    
}