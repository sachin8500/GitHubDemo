trigger HighPriorityContactTigger on Contact (after insert) 
{
    if(trigger.isAfter){
        
        if(trigger.isInsert){
            
            HighPriorityContactHandler.HighPriorityContact(trigger.new);
        }
    }
}