public class Cl_1508_eg5_datatable1 
{
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList()
    
    {        
        return [select Id, FirstName,LastName, Email, Phone from Contact limit 10];
    }
}