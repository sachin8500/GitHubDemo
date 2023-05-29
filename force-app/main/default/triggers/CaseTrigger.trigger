trigger CaseTrigger on Case (before insert, before update) {
    
    for (Case obj : Trigger.new){
        
        if (obj.Status == 'New'){
            
            obj.Priority= 'High';
        }
        
        
    }
   

}