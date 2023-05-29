//if account created with same contact name then contact should deleted

trigger DelectContactWithSameName on Account (before insert) {

   Set<String> accoutsSet= new Set<String>();
    
    for (account a : trigger.new ){
        
        accoutsSet.add(a.name);
    }List<Contact> conList = [Select id, name from Contact where name in : accoutsSet];
    
    if(conList.size()>0 && conList != null){
        
        Delete conList;
    }
    
    
}