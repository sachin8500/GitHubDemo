trigger accountoppdelete on Account (before delete)
{	
    List<Account> accList= [select id,(select id from Opportunities) from Account where id in: trigger.old];
    
    for(Account acc: trigger.old)
    {
        for(Account a:accList)
        {
            if(a.Opportunities.size()>=1)
            {
                acc.addError('not allowed as OPP available for this account!');
            }
        }
    }
}