//when account is create we need to create opp records aumatically

trigger AccountOptyCreateTrigger on Account (after insert) {
    
    List<Account> acc = Trigger.New;
    List<Opportunity> oppList = New List<Opportunity> ();
    
    For (Account a : acc){
        
        Opportunity op = New Opportunity ();
        
        op.Name= a.Name+ '_Opp1';
        op.StageName='Prospect';
        op.CloseDate= System.today()+15;
        op.AccountId=a.Id;
        oppList.add(op);
        
            
        
    }
    Insert oppList;
    
}