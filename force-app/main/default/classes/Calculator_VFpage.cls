public class Calculator_VFpage {
    public integer aval{set;get;}
    public integer bval{set;get;}
    public integer cval{set;get;}
    
    public void add() {
        
        cval=aval+bval;
    }       
    public void mul() {
        
        cval=aval*bval;
    }  
    public void cancel() {
        
        aval=0;
        bval=0;
        cval=0;
    }  
    
}