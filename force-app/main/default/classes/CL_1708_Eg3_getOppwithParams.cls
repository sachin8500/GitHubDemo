public with sharing class CL_1708_Eg3_getOppwithParams 
{   @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOPP(String name)
    {
        if(name==''){
            return [Select Name from Opportunity WITH SECURITY_ENFORCED limit 10];
        }
        
        String searchKey='%'+name+'%';

        return [Select Name from Opportunity where Name like:searchKey WITH SECURITY_ENFORCED limit 10];

    }
    
}