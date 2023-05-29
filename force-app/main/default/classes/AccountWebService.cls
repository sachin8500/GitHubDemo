@restResource(urlMapping='/Account/AccountWebService/*')
global with sharing class AccountWebService {
  
    @httpGet

    global static Account getAccount(){

        String accId=RestContext.request.params.get('Id');

        return [Select Id,Name, Type, Industry from Account where Id= : accId  WITH SECURITY_ENFORCED];

    }
    @httpPost
    global static Account createAccount(String name, String type, String Ind){
        Account acc = New Account();
        acc.Name=name;
        acc.Type=type;
        acc.Industry=Ind;
        insert acc;
        return acc;
    }

    @httpPatch
    global static Account createAccount(String accId, String name, String type, String Ind){
        
        Account acc = [Select Id, Name, Type, Industry from Account where Id=: accId];
        acc.Name=name;
        acc.Type=type;
        acc.Industry=Ind;
        update acc;
        return acc;
    }

}