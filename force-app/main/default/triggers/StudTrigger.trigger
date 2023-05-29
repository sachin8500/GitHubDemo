trigger StudTrigger on Student__c (before insert) {
    
    for (Student__c stud: trigger.new){
        if(stud.addreess__c==null){
            stud.addreess__c='Pune';
        }
    }

}