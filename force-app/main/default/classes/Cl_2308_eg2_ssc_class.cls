public with sharing class Cl_2308_eg2_ssc_class

{   @AuraEnabled (cacheable=true)
    public static list<Contact> bringContactList() 
    {
        return [select Id, FirstName,LastName,Phone,Email from Contact WITH SECURITY_ENFORCED limit 10];
    }
}