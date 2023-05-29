public with sharing class DemoSchedulable implements Schedulable{
    public void Execute(SchedulableContext SC) 
    
    {
            List<account> accList=[select id, name from account];

            for(account acc:accList){
                acc.name='Created Today -'+ acc.name;
            }
            update accList;
    }
}