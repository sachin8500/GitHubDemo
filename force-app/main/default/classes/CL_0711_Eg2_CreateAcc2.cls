public class CL_0711_Eg2_CreateAcc2 

{
	@AuraEnabled
    
    public static string callAccount(Account acc){
        string result;
        try{
            insert acc;
            result='SUCCESS'; 
        }
        catch(exception e){
            result= e.getMessage();
        }
        return result;
        
    }
}