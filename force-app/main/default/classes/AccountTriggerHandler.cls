public class AccountTriggerHandler {
   
    public static void beforeInsert(List<Account> newList){
        
        for (Account acc : newList){
            if(acc.Industry != null && acc.Industry == 'Media'){
            acc.rating = 'Hot';
            }
        }
    }
    
    public static void afterInsert(List<Account> newList){
        
        List<Opportunity> oppTobeInserted = new List<Opportunity> ();
        
        for(Account acc : newList){
            
            Opportunity opp = new Opportunity ();
            opp.Name = acc.Name;
            opp.AccountId =acc.id;
            opp.StageName='Prospecting';
            opp.CloseDate= System.today();
            oppTobeInserted.add(opp);
        }
        
        if(!oppTobeInserted.isEmpty()){
            
            insert oppTobeInserted;
        }
    }
}