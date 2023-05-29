trigger CreateContactTrigger on Account (after insert, after update) {
    
    List<Contact> conList= new List<Contact>();
    
    integer n, i=0;
    Account acc = new Account();
    for (Account ac : trigger.new){
        
        n=integer.valueOf(ac.No_of_Contact__c);
        
        acc=ac;
    }
    while (i<n){
        
        contact c = new contact();
        c.lastName='NewAc'+i;
        c.phone='7276018233';
        conlist.add(c);
        c.AccountId=acc.id;
        i++;
    }


insert conList;
}