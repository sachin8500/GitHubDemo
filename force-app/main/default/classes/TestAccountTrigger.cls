@isTest
public class TestAccountTrigger 
{
    @isTest
    
    public static void method1()
    {
        Account acc = new Account ();
        acc.name = 'test1';
		acc.Industry='Media';		      
        insert acc;
    }

}