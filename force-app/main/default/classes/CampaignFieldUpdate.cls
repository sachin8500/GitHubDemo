public class CampaignFieldUpdate {
    
    public static void FieldUpdate(){
        
        List<Campaign> listOfCampaigns= new List<Campaign> ();
        
        listOfCampaigns = [Select Name from Campaign where BudgetedCost = null];
        
        integer count = 0;
        
        for(Campaign c : listOfCampaigns) {
            
            count++;
            c.BudgetedCost= 5000;
            System.debug('count in number ' + count + ', updated records ' + c.BudgetedCost);
        }
        
        update listOfCampaigns;
    }
    
}