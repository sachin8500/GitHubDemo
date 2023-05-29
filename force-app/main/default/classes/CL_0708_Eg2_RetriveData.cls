public class CL_0708_Eg2_RetriveData 
{	
    @auraEnabled
    
    public static Account GiveData(){
        
        Account acc = [Select Id, Name, Phone, Industry, Rating from Account limit 1];
        
        return acc;
    }
}