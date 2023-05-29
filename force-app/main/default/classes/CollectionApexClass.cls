public class CollectionApexClass 
{
	public static void howtoUseList()
    {
        String str;
    	List<String> lst = new List<String>();
      	lst.clear();
        lst.add('Java');
        lst.add('dotNet');
        lst.add('apex');
        System.debug('lst = '+ lst);
        
        List<Integer> IntegerLst= New List<Integer> ();
        IntegerLst.add(4);
        IntegerLst.add(6);
        
        List<Integer> addingAllValues = new List<Integer> ();
        addingAllValues.addAll(Integerlst);
        
        System.debug('addingAllValues = '+ addingAllValues);
        
        
        
        
    }
     
}