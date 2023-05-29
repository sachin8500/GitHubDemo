public class ParentClassOverloading {

    public void sum(){
        integer no1 = 5;
        integer no2 = 6;
        System.debug( 'without param: ' + (no1+no2));
        
    }
    public void sum(integer no1, integer no2){
        
        System.debug('integer no1, integer no2 : ' + (no1+no2));
        
    }
    public void sum(decimal no1, integer no2){
        
        System.debug('decimal no1, integer no2 : ' + (no1+no2));
    }
    public void sum(decimal no1, decimal no2){
        
        System.debug('decimal no1, decimal no2 : ' + (no1+no2));
    }
}