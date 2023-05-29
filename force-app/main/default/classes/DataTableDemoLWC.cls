public class DataTableDemoLWC {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(String accountRecordId, String searchValue){
		
        if(searchValue !='' && searchValue !=null){
            string key = '%' + searchValue+ '%';
        	list<Contact> conList= [Select Id, Name, Phone, AccountId From Contact where AccountId = :accountRecordId AND Name LIKE: key];
            
            if(!conList.isEmpty()){
                return conList;
            }else{
                return null;
            }
            
        }else{
            list<Contact> conList= [Select Id, Name, Phone, AccountId From Contact where AccountId = :accountRecordId];
            System.debug(conList); 
            return conList;
        }
        
       
        
}
}