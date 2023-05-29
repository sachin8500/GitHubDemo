public class CL_0720_Eg1_QueueableApex implements Queueable
{
    public void execute(QueueableContext QC){
        List<Employee__c> EM = [Select Id, Dept_Name__c from Employee__c];
        List<Employee__c> empList = new List<Employee__c> ();
        
        for(Employee__c e : EM){
            e.Dept_Name__c='Queueable Apex';
            empList.add(e);
        }
        database.update(empList,false);
            
        
    }
    
}