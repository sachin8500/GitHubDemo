public with sharing class TestDemoBatch implements database.batchable<sObject>
{
    public Database.QueryLocator Start(Database.BatchableContext BC) 
    {
        return Database.getQueryLocator('select id, name from Account');

    }
    public void Execute(Database.BatchableContext BC,List<Account> accList)
    {
        for(Account acc: accList)
        {
            acc.name='Batch Updated- '+ acc.name;
        }
        update accList;
    }
    public void Finish(Database.BatchableContext BC)
    {

    }

}