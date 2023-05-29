public class Loops {

    public static void looping (){    
        
        List<Contact> listOfContacts =new List<Contact>();
        
        listOfContacts = [SELECT Name From Contact WHERE Current_Counrtry__c='' Limit 10];
        Integer count = 0;
       
        for(Contact Con : listOfContacts )
            
        {
            count++; 
            Con.Current_Counrtry__c = 'Amsterdam';
            System.debug ('Loop Number: '+ count + ',updated Current_Counrtry wuth: '+ Con.Current_Counrtry__c);
        }
        update listOfContacts;
        }
    
}