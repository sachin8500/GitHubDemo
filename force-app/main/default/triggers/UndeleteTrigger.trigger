trigger UndeleteTrigger on Case (after undelete) {
	
    List<case> cList = [SELECT Id, Description FROM case WHERE Id IN :trigger.new];
    for(case cs:trigger.new){        
        for(case cas: cList){
       		cas.Description = 'Undeleted case';
    	UPDATE cList;       
    }    

	}
}