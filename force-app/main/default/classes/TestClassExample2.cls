@Istest

public class TestClassExample2 {
    
    @istest
    
    static void testme2(){
        
        ExampleTestClass2 obj = new ExampleTestClass2();
        obj.setDate();
        
        system.assertEquals('Banking', obj.industry);
        system.assertEquals('Hot', obj.rating);
        
    }

}