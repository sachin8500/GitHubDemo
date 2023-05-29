public class CL_0711_LT_getAccSearchText 
{
 @AuraEnabled 
    public static List<Account> getAccount(string searchText){
        string query= 'select id,name,phone,rating,industry from Account where name like\'%'+searchText+'%\'';
        List<Account> accounts = Database.query(query);
        
        return accounts; 
    }	
}