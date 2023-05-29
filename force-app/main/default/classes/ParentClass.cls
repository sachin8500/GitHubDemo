public virtual class ParentClass {

    public virtual List<Contact> sum(){
        
        List<Contact> lstContacts= [select id, name from Contact];
        
        return lstContacts;
        
    }
    
}