trigger BackupTriggerTestingObj on TriggerTesting__c (before update) {
    
    List<TriggerTestingBackup__c> backtest = new List<TriggerTestingBackup__c>();
    
    for(TriggerTesting__c TrgTest: Trigger.old){
        
        TriggerTestingBackup__c bk = new TriggerTestingBackup__c();
        bk.FirstName__c = TrgTest.FirstName__c;
        bk.LastName__c =TrgTest.LastName__c;
        bk.Age__c=TrgTest.Age__c;
        
        backtest.add(bk);
    }
    Insert backtest; 
}