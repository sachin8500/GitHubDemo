public class AccountDemoExtesion_CX {
    
    public Account acc;
    
    
    public AccountDemoExtesion_CX(ApexPages.StandardController controller) {
    
        acc= (account)controller.getrecord();

    }
    public void save()

    {
        if(acc.rating=='Hot'){
        
            acc.SLA__c='Gold';
        }
        
        insert acc;
        
    }
    

}