trigger AfterInsertContactTrigger on Account (after insert) {
    
    List<Account> acc = Trigger.New;
    
    List<Contact>  con = New List<Contact> ();
    
    For (Account a: acc){
        
        Contact c = New Contact ();
        
        c.LastName=a.Name +'_Con1';
        c.AccountId=a.Id;
        c.FirstName='AfterInsert';
        c.Birthdate= System.today();
        
        con.add(c);
        
    }
    
    insert con;

}