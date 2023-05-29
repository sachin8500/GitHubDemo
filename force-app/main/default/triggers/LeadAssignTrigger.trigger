//when we insert new lead. if industry is banking then assign
//corporate team, as owner of the lead if industry is other than
//banking assign to personalteam as owner of the lead
//group g=[select id from group where name='corporate_team' 
//and type ='Queue']

trigger LeadAssignTrigger on Lead (before insert) {
    
    Group ct= [select id from Group where name='Corporate Team' and Type='Queue'];
    Group pt= [select id from Group where name='Personal Team' and Type='Queue'];
    
    List<Lead> leads = trigger.new;
    for(Lead l : Leads)
    {
        
        if(l.industry=='Banking'){
            
           l.ownerId=ct.Id;
    }else{
        l.OwnerId=pt.Id;
    }
}
}