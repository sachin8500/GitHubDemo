trigger TestTrigger on Account (before insert, before update) {
    
    
    for (Account acc : Trigger.new ){
        
        if (acc.Status__c == 'Won'){
            
            acc.Description = 'Congratulation you won the deal!!!';
             
        }else
        {
            acc.Description= 'try again';
        }
        
    }
    
}