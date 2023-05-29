public class DMLDemo {
    
/*    public void insertRecord()
        
    {
        Contact obj = new Contact (FirstName ='Sachin', LastName = 'More');
        insert obj;
        System.debug('obj :' + obj);
        
    }*/
    
 /*public void insertRecord()
 {
     Contact obj = new Contact ( FirstName= 'Savita', LastName= 'More');
     insert obj;
     System.debug('obj : '+ obj);
 }
*/
    public void insertRecord()
    {
        Contact obj = new Contact( FirstName='Vinuta', LastName='More');
        insert obj;
        System.debug('obj :' + obj);
               
        
    }
    
    public void bulkInsert(Integer noOfRecords){
    List<Contact> lstContacts = New List<Contact> ();
    
    for(integer i = 1; i <=noOfRecords; i++){
        Contact obj = new Contact();
        obj.FirstName= 'Apex'+ i;
        obj.LastName ='Contact'+ i;
        lstContacts.add(obj);
                
    }
        insert lstContacts;
        system.debug('lstContacts: '+ lstContacts);
    }
        
       
}