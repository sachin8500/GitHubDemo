public class StudentDemoExtesion3_cx {
    
    public List<student__c> listStud {get;set;}
    public StudentDemoExtesion3_cx(ApexPages.StandardSetController controller) {
    
        listStud = [select name, gender__c,age__c,Spouse_Name__c from student__c where gender__c = 'Male'];

    }

}