public class ChildClass extends ParentClass {
    
    public override List<Contact> sum(){
        
        List<Contact> lstContacts= [select id, name from Contact where AccountId !=NULL];
        
        return lstContacts;
        
    }
}