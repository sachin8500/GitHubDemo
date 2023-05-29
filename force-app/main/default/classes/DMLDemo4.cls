public class DMLDemo4 {
    
    public List<Contact> getRecord(Integer noOfRecords){
        
        List<Contact> lstContact3 = new List<Contact>();
        for(Integer i =1;i<=noOfRecords; i++){
            
            Contact obj = new Contact();
            obj.FirstName='Apex' + i;
            obj.LastName='Conatct' + i;
            lstContact3.add(obj);            
        }
        return lstContact3;
    }

}