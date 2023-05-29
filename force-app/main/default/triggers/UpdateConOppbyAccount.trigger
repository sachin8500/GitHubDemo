trigger UpdateConOppbyAccount on Account (After insert, before update) {
    
    List<Contact> conList= new List<Contact> ();
    List<Opportunity> oppList= new List<Opportunity> ();
    
    for(Account acc: Trigger.new){
        
        Contact con = new Contact ();
        con.AccountId = acc.id;
        con.LastName=acc.name;
        con.Phone= acc.phone;
        
        Opportunity opp = new Opportunity();
        opp.AccountId=acc.id;
        opp.Name=acc.name;
        opp.StageName='Prospecting';
        opp.closeDate=date.today()+14;
        
        conList.add(con);
        oppList.add(opp);
    } 
    insert conList;
    insert oppList;
}