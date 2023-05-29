public class SQALApex {
    
   public void fetchAllAcc() 
    
    {
        List<Account> lstBox = [SELECT Id, Name FROM Account]; 
    
    for(Account objAcc : lstBox)
        
    {    
        if (objAcc.Active_CheckBox__c==false)
    {
        objAcc.Active_CheckBox__c = true;
        
    }
        else 
        {
            System.debug('Active_CheckBox__c ' + objAcc.Active_CheckBox__c);
        }
        update objAcc;
    }
    }
    
}