public class CreateContsbyAccountHandler {
    
    public static void contactCreateByAccHandler(List<Account> accList){
        
        List <Contact> ConList = new List <Contact> ();
    {
        
        for(Account acc : accList){
            
            for (integer i=1;i<=3;i++){
                
                Contact con = new Contact ();
                con.AccountId=acc.Id;
                con.LastName= acc.name +'Con ' +''+i;
                con.Email='abc'+''+i +'@gmail.com';
                conList.add(con);
                
                system.debug('conList>>>>>' + conList);
            }
        }
        
    }if (conList.size()>0){
        
        insert conList;
    }
        
        
    }

}