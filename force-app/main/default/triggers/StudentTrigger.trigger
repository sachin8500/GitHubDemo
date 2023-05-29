trigger StudentTrigger on Student__c (before insert, before update) {
    
    for (Student__c stud : trigger.new){
        
        if(stud.Marital_status__c == 'Yes'){
            
            stud.adderror('Spouse name should not blank');
        }
            
    }
    
}