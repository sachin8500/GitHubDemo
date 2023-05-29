public class JobClassDemo {
    
    public static void selectStatus(List<Job__c> Js){
        
        for(Job__c varJob : Js){
            
            if(varJob.skill__c=='Java' && varJob.experince__c>=6){
                
                varJob.status__c='You are selected!';                
                
            }
            
            else if (varJob.skill__c=='Salesforce' && varJob.experince__c>=6){
                
                varJob.status__c='You are selected!';
            }
            
            else{
                
               varJob.status__c='You are rejected!';
            }
            
            
        }
        
    }
    
}