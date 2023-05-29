public class CollectionDemo {

    public void testListCollection () {
        
        List <Integer> lstNumber = new List <Integer>();
        
        lstNumber.add (10);
        lstNumber.add (20);
        lstNumber.add (30);
        lstNumber.add (40);
        lstNumber.add (50);
        
        for(Integer Num : lstNumber){
        System.debug(Num);
            }
        System.debug ('lstNumber ' + lstNumber);
        //System.debug ('lstNumber ' + lstNumber.size());
        
    }
}