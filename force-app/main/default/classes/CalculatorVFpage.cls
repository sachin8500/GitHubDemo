public class CalculatorVFpage {
    
    public Decimal amount{set;get;}
    public Decimal year {set;get;}
    public decimal rate {set;get;}
    public decimal interest{set;get;}
    
    public CalculatorVFpage(){
        
        amount= 50000;
        year=1;   
        rate=10;
     
    }
    public void oneYear(){
        year=1;
        interest =  (amount*year*rate)/100;
    }
    public void twoYear(){
        year=2;
        interest =  (amount*year*rate)/100;
    }
    
}