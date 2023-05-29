public class RelatedOppLWCComp {
	@AuraEnabled
    public static List<Opportunity> getOpp(String accountRecordId, String searchValue){
		
        if(searchValue !='' && searchValue !=Null){
            String key = '%'+searchValue+'%';
            List<Opportunity> oppList = [Select Id, AccountId, Name from Opportunity 
                                         where AccountId =:accountRecordId And Name like :key];
            
            if(!oppList.isEmpty()){
              return oppList;  
            }
            	
            return Null;
            
        } else{
            
            List<Opportunity> oppList = [Select Id, AccountId, Name from Opportunity 
                                         where AccountId =:accountRecordId];
            
            return oppList;
        }      
	 }
}