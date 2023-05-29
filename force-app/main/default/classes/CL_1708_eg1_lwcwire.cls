public with sharing class CL_1708_eg1_lwcwire {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactData(){
        return [select Name from Contact WITH SECURITY_ENFORCED limit 10];
    }
}