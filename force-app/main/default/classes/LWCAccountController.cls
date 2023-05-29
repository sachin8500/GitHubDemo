public with sharing class LWCAccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String searchText){
        try {
            if(String.IsEmpty(searchText)){
                return[Select Id, Name From Account  WITH SECURITY_ENFORCED];
            }
            else{
                searchText= '%'+searchText+'%';
                return[Select Id, Name From Account where Name LIKE : searchText WITH SECURITY_ENFORCED];
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAccountContats(String accountId){
        try {            
                return [Select Id, Name From Contact where accountId=:accountId WITH SECURITY_ENFORCED];
            }
            
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}