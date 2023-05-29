trigger AccountWithContactTrigger on Account (after insert) {
    
    List<Contact> con = new List<Contact>();
    
    for(Account a : trigger.new){       
              
        Contact c = new Contact();
        c.AccountId = a.Id;
        c.LastName=a.Name;
        c.Phone=a.Phone;
        
        con.add(c);
    }
    insert con;
}