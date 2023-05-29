Public class CL_0720_Eg1_BatchApex implements Database.batchable<sObject>,Schedulable
{
	Public Database.QueryLocator Start(Database.batchableContext BC)
		
	{
		string Q= 'SELECT Id from Employee__c';
		Return Database.getQueryLocator(Q);
	}
	
	Public void Execute (Database.BatchableContext BC, List<Employee__c> EmpList)		
	{
		Delete EmpList;
	}
	
	Public void Finish(Database.BatchableContext BC)
	{
		
	}
    
    public void execute (SchedulableContext SC){
        CL_0720_Eg1_BatchApex BA = New CL_0720_Eg1_BatchApex ();
        database.executeBatch(BA);
        
    }
}