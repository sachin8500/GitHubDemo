@Istest
public class TestClassExample {
    
    @istest
    Static void testme()
    {
        ExampleTestClass et = new ExampleTestClass ();
        et.invoke();
        system.assertEquals('sachin', et.name);
        system.assertEquals('Pune', et.city);
        
        et.call();
        system.assertEquals('savita', et.name);
        system.assertEquals('Belgaum', et.city); 
    }
    
    
}