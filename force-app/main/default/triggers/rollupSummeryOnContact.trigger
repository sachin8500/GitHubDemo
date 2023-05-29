trigger rollupSummeryOnContact on Contact (after insert, after update,after delete, after undelete) 
{
    if(trigger.isAfter){
        
        {
            RollupSummuryContact2.countOfContact(trigger.new);
        }
        
        if(trigger.isDelete)
        {
           RollupSummuryContact2.countOfContact2(trigger.old);
        }
    }
    
}