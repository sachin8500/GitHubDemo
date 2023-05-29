public class DMLDemoNew{
  
    public void insertAccContact()
        
    {
        Account objAcc=new Account();
        objAcc.Name='Test Apex Account';
        insert objAcc;
        System.debug('objAcc: '+ objAcc);    
        
        Contact objCon=new Contact();
        objCon.FirstName='Contact -';
        objCon.LastName=objAcc.Name;
        objCon.AccountId=objAcc.id;
        
        insert objCon;
        
    }
       
 
    
    
}