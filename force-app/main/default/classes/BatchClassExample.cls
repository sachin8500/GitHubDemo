global class BatchClassExample implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext context){
        
        string query = 'select id, name, type from Opportunity';
        return Database.getQueryLocator(query);       
        
    }
    
    global void execute (Database.BatchableContext context, List <Opportunity> scope){
        
        for(Opportunity opp : scope){
            
            opp.type='New Customer';
            
           }
        update scope;
        
    }
    
    global void finish(Database.BatchableContext context){
        
        AsyncApexJob Job= [select id, status, jobType from AsyncApexJob where id=:context.getJobId() ];
        System.debug( 'Jo status '+ job.status);
    }
    
}