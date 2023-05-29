public class CL_0708_LT_CreateAccount 
{
    @AuraEnabled
    public static string createAccount (string name, string phone,string rating,string industry){
        
        string result;
           try        
        {
            Account a = new Account();
            a.Name = name;
            a.Phone = phone;
            a.Rating= rating;
            a.Industry= industry; 
            insert a;
            result='Account created sucessfully' + a.Id;
          
        } 
        catch(exception e){
            
            result='Account Creation failed' + e.getMessage();
        }
        
        return result;
        
    }
}