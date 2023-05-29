//Whena new account is created with owner with ownership as private
//then create Sachin as AccountTeamMember
//Setup>>buid>>customize>>Account>>Account Teams>>enable

trigger AccountTeamsTrigger on Account (after insert) {
    
    User u = [select id from User where alias = 'SMore'];
    
    List<AccountTeamMember> teams = New List<AccountTeamMember> ();
    
    for(Account a : Trigger.New){
        
        if(a.Ownership=='Private'){
            
            AccountTeamMember atm = New AccountTeamMember ();
            
            atm.AccountID = a.id;//id of account on which we want to create Teammemebr
            atm.UserId= u.id;//ID of user whom you want to add as teammember
            atm.TeamMemberRole='Account Manger';
            atm.AccountAccessLevel='Read';
            teams.add(atm);
            
        }
        insert teams;
    }
    

}