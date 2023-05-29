//When a new Opp is created set stagename as prospect 
//closedate as days from today
//type as new customer


trigger TriggerOpportunity on Opportunity (before insert) {
    
    List<Opportunity> oop = trigger.new;
    
    for (Opportunity op : oop){
        
        op.stagename='Prospect';
        op.closeDate=System.today()+15;
        op.Type='New Customer';
    }

}