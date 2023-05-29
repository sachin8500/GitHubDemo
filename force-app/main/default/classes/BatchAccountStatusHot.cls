//create a batch apex to fetch all accounts and update rating as hot

global class BatchAccountStatusHot implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        string query = 'select id, name from account';
        
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> scope){
        
        for(Account acc : scope){
            
            acc.rating = 'Hot';
            
        }
        Update scope;
    }
    
    global void finish(Database.BatchableContext bc){
                
        AsyncApexJob job = [select id, status, JobType from AsyncApexJob where id=:bc.getJobId()];
        system.debug('status: ' + job.status);
    }
    
}