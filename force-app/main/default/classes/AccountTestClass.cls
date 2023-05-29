@isTest
public class AccountTestClass 
{
	@isTest
    public static void method1()
    {
        Account acc = new Account ();
        acc.name='sachin';
        acc.phone='13346';
        
        insert acc;
        
        Opportunity opp = new Opportunity ();
        opp.Name= 'opp1';
        opp.StageName='Prospect';
        opp.CloseDate= System.today()+15;
        insert opp;
       }
}