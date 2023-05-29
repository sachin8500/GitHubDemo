//whenever the opp created stage name as closed won share
//the recordswith demo user with read access
trigger OptySharingTrigger on Opportunity (after insert) {
    
    User u = [select id from User where alias='SMore'];
    
    List<OpportunityShare> share = new List<OpportunityShare> ();
    
    for(Opportunity op : Trigger.new){
        
        if(op.stageName=='Close Won'){
            
            OpportunityShare os =New OpportunityShare();
            
            os.OpportunityId=op.id;
            os.UserOrGroupId=u.id;
            os.OpportunityAccessLevel='Read';
            os.RowCause='Manual';
            
            share.add(os);
        }
        
        insert share;
    }
    

}