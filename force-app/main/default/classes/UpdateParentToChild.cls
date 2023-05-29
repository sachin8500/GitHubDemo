public class UpdateParentToChild 
{
    public void parentToChildRelationship()
    
    {
   List<Account>lstAccount = new List<Account>();
        
   lstAccount = [SELECT ID, Name, (SELECT ID, Name, AccountId, Related_Account_Name__c FROM Contacts) FROM Account];

   List<Contact> lstContacts;
  
        for(Account obj : lstAccount) {
            
           
}
    }
}