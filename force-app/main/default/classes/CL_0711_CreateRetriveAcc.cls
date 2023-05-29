public class CL_0711_CreateRetriveAcc 

{
	@auraEnabled 
    
    public static string InsertAccount(Account acc)
    {
        string Result;
        
        try
        {
            Insert acc;
            Result=acc.Id;
        }
        catch(exception e){
            
            Result='Failed';
        }
        return Result;
    }
    @auraEnabled 
    
    public static List<Account>getData()
    {
        List<Account> accounts=[select id,Name,Phone,Rating, Industry from Account];
        return accounts;
    }
    
}