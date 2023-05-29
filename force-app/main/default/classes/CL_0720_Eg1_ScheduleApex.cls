Public class CL_0720_Eg1_ScheduleApex implements Schedulable
{
	Public void Execute(SchedulableContext SC)
	{
		List<Employee__c> OP = [Select ID,First_Name__c from Employee__c];
		List<Employee__c> EmpList = new List<Employee__c> ();
		for(Employee__c EO:OP)
		{
            EO.First_Name__c='System Operation';
            EmpList.add(EO);            
		}
		Update EmpList;		
	}
	
}