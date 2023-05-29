@istest

public class JobClassTest {
    
    @istest
    
    static void function1(){
       
        Job__c varJob = new Job__c();
        varJob.skill__c='Java';
        varJob.Experince__c=6;
        varJob.Status__c='You are selected!';
        insert varJob;
        
        System.assertEquals('You are selected!', varJob.Status__c);
        
    }

        @istest
    
    static void function2(){
       
        Job__c varJob = new Job__c();
        varJob.skill__c='salesforce';
        varJob.Experince__c=7;
        varJob.Status__c='You are selected!';
        insert varJob;
        
        System.assertEquals('You are selected!', varJob.Status__c);
    }
            @istest
    
    static void function3(){
       
        Job__c varJob = new Job__c();
        varJob.skill__c='SAP';
        varJob.Experince__c=5;
        varJob.Status__c='You are rejected!';
        insert varJob;
        
        System.assertEquals('You are rejected!', varJob.Status__c);
    }
}