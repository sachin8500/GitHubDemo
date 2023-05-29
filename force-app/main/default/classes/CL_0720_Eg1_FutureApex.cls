public class CL_0720_Eg1_FutureApex 
{
    public static void Method1()
    {
        system.debug('Method1 - good mornging');
        system.debug('Method1 - good afternoon');
        system.debug('Method1 - good night');
    }
    @future
     public static void Method2()
    {
        system.debug('Method2 - good mornging');
        system.debug('Method2 - good afternoon');
        system.debug('Method2 - good night');
    }
    
     public static void Method3()
    {
        system.debug('Method3 - good mornging');
        Method1();
        system.debug('Method3 - good afternoon');
        Method2();
        system.debug('Method3 - good night');
    }
}