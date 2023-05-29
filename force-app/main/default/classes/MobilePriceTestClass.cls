@istest

public class MobilePriceTestClass {
    
    @istest
    
    static void testDiscount(){
        
        Mobile_Shope__c obj = new Mobile_Shope__c();
        
        obj.Brand__c='Samsung';
        obj.Price__c=10000;
        obj.Price__c=(obj.price__c - (obj.price__c*20)/100);
        
        insert obj;
        
        system.assertEquals(8000,obj.price__c);
    }
    
    @istest
    
    static void testDiscount1(){
        
        Mobile_Shope__c obj = new Mobile_Shope__c();
        
        obj.Brand__c='Apple';
        obj.Price__c=10000;
        obj.Price__c=(obj.price__c - (obj.price__c*10)/100);
        
        insert obj;
       
        system.assertEquals(9000, obj.price__c);
    }
    
}