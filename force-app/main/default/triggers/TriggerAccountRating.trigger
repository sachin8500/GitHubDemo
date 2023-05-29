//When ever new account is inserted with industry as banking 
//rating as hot and owership as warm
trigger TriggerAccountRating on Account (before insert) {
    
    List<Account> accounts =Trigger.New;
    
    for (Account a : accounts){
        
        if(a.industry =='Banking'){
            
            a.rating='Hot';
            a.ownership='Public';
        }
    }
    
}