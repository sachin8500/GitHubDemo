public class StudentHandler {
    
    public static void beforeInsert(List<Student__c> stud1){
        
        for(Student__c stud: stud1){
            if(stud.addreess__c==null){
                stud.addreess__c='California';
                
            }
        }
    }
       public static void beforeUpdate(List<Student__c> stud1){
        
        for(Student__c stud: stud1){
            if(stud.addreess__c==null){
                stud.addreess__c='NY';
                
            }
        }
    }
            }