trigger NewRollupSumTrigger on Contact (before insert) {

    set<id> accIds = new set<id>();
	if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete)

	{
		
	for(Contact con:trigger.new)
	{
		accIds.add(con.Accountid);
	}

	}

	if(trigger.isdelete && trigger.isAfter){

	{
		
	for(Contact con:trigger.old)
	{
		accIds.add(con.Accountid);
	}

	}
	}

	if(trigger.isInsert || trigger.isUpdate || trigger.isUndelete){
	List<Account> accList = [select id,No_Of_Contact__c,(Select id from Contacts) from Account where id in : accIds];

	for(Account acc:accList)
	{
		acc.No_Of_Contact__c = acc.Contacts.size();
	}
        update accList;
}
	
    
   if( trigger.isdelete && trigger.isAfter){

List<Account> accList = [select id,No_Of_Contact__c,(Select id from Contacts) from Account where id in : accIds];

	for(Account acc:accList)
	{
		acc.No_Of_Contact__c = acc.Contacts.size();
	}
    
    update accList;
}

	
}