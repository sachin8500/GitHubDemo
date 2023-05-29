//Prefix first name with DR when new lead is created or updated
trigger LeadTrigger on Lead (before insert, before update) {

    for(Lead l: trigger.new){
      
        l.FirstName='Dr. '+ l.FirstName;
        
    }
    
}