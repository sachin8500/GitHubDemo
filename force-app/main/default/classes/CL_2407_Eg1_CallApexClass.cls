public class CL_2407_Eg1_CallApexClass 

{
	@AuraEnabled
    public static string createAccount(String nm, string ph){
        string result;
        
        Account acc= new Account();
        acc.name=nm;
        acc.phone=ph;
        
        try{
            insert acc;
            result='Account created sucessfully with Account id '+ acc.id;
        }
        catch(exception e)
        {
            result='Account creation failed with error '+e.getMessage();          
            
        }
        return result;
            
            
        
        
    }
}