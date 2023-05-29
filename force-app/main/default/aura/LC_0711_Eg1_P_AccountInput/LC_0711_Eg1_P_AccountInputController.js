({
	callme : function(component, event, helper) 
    {
        var col =[
            {label:'AccountName',fieldName:'Name',type:'Text'},
            {label:'Phone',fieldName:'Phone',type:'Text'},
            {label:'Rating',fieldName:'Rating',type:'Text'},
           ];
        component.set("v.aculmns",col);
	},
    showme : function(component, event, helper) 
    {
		var acc=event.getParam("acc");
            var accounts=component.get("v.accounts");
            accounts.push(acc);
         component.set("v.accounts",accounts);   
	}
})