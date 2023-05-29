public with sharing class Cl_1708_Eg2_findingAccountData {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountRecords(){
        
        return [select Name from Account WITH SECURITY_ENFORCED limit 10];
    }
}