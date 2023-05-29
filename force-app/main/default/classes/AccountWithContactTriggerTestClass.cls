@isTest
public class AccountWithContactTriggerTestClass {
	@isTest
    public static void AccountWithContactTriggerMethod(){
        
        Account acc = New Account(Name='Test');        
        Insert acc;    
        
        Contact con = new Contact();
        con.AccountId = acc.id;
        con.lastName = acc.name;
        con.Phone=acc.Phone;
        insert con;
        
        
    }
}