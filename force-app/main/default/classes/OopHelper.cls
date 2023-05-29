public class OopHelper {
    public void Execute(){
        
        ChildClass obj = new ChildClass();
        List<Contact> lstContacts = obj.sum();
        System.debug('lstContacts from Child ' + lstContacts.size());
        
        ParentClass obj2 = new ParentClass();
        List<Contact> lstContacts1 = obj2.sum();
        
        System.debug('lstContacts1 from parent ' + lstContacts1.size());
    }

}