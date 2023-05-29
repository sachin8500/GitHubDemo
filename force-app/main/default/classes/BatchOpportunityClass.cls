public class BatchOpportunityClass implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext context){
        String query ='select id, Description from Opportunity where isClosed =true';
        return Database.getQueryLocator(query);
        
    }

    public void execute(Database.BatchableContext context, List<opportunity> records){
        
        System.debug('iin exdfd' + records);
        List<Opportunity> lsttoUpdate = new List<Opportunity>();
        for(Opportunity obj : records){
            
            obj.Description = 'Opportunity Closed';
            lsttoUpdate.add(obj);
            
        }
        if (!lsttoUpdate.isEmpty()){
            
            update lsttoUpdate;
        }
          
   }
    
    public void finish(Database.BatchableContext context){
        
       
        
    }
}