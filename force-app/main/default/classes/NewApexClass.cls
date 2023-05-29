public with sharing class NewApexClass implements Queueable
{
    public void execute(QueueableContext QC) 
    {
        delete[select id from case where createddate=Last_Month];
    }   
}