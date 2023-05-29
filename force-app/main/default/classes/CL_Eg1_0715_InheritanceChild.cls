public class CL_Eg1_0715_InheritanceChild extends CL_Eg1_0715_InheritanceParent 
{
        public void sub()
   	{
        system.debug('value of x is '+x);
        Integer z=y-x;
        system.debug(z);
    }
    public void mul()
    {
        Integer z=y*x;
        System.debug(z);
    }
}