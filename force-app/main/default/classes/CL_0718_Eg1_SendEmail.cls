public class CL_0718_Eg1_SendEmail 

{
    public void sendEmail()
        
    {
		messaging.SingleEmailMessage se = new messaging.SingleEmailMessage ();
        
        List<string> myList = new List <string> {'smartusers85@gmail.com'};
        
            se.setToAddresses(myList);
        	se.setSubject('this is the Test email from apex programming');
        	se.setPlainTextBody('this is the Test email from apex programming');
            se.setSenderDisplayName('Sachin More');
        
        List<Messaging.Email> emailMessages = new List<Messaging.Email> {se};
        messaging.sendEmail(emailMessages);
        
        system.debug('emailMessages' + emailMessages);
        
   	}
                            
}