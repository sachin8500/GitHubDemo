public class MobilePriceClass {
    
    public static void MobileDiscount(List<Mobile_Shope__c> ms){
        
        for(Mobile_Shope__c obj: ms){
            
            if(obj.brand__c=='Samsung'){
                
                obj.price__c= (obj.price__c - (obj.price__c*20)/100);
            }else if (obj.brand__c =='Apple'){
                
                obj.price__c= (obj.price__c - (obj.price__c*10)/100);
            }
            
        }
        
    }

}