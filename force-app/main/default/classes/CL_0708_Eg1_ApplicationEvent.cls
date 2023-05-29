public class CL_0708_Eg1_ApplicationEvent 
{
	@AuraEnabled
    public static String AccList(String AccName, String Indus)
    
    {
        List<Account> a = [select id,Name,Phone,Rating from Account where Name=: AccName AND Industry=:Indus limit 1];
            
        if(a.size()>0){
            return a[0].id;	
        }else
            
        {
            return 'No records found';
        }
    }
    @AuraEnabled
        
        public static List<Contact> conList(String accid)
        {
            List<Contact> conLists=[select id,Name,Phone,Email From Contact where accountId=:accid];
            if(conLists.size()>0){
                return conLists;
            }else{ 
                return null;
            }
        }
	
	@AuraEnabled
        
        public static List<Opportunity> oppList(String accid)
        {
            List<Opportunity> oppLists=[select id,Name,StageName,Amount From Opportunity where accountId=:accid];
            if(oppLists.size()>0){
                return oppLists;
            }else{ 
                return null;
            }
        }    
    }