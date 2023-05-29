({
	callme : function(component, event, helper) 
    {
		var col= [
            		
            {label:'AccountName',fieldName:'Name',type:'text'},
            {label:'Phone',fieldName:'Phone',type:'text'},
            {label:'Rating',fieldName:'Rating',type:'text'},
        		]; 
        
        component.set("v.acolumns",col);
	},
    showme : function(component, event, helper) 
    {
		var acc= event.getParam("acc");
        var accounts=component.get("v.accounts");
        accounts.push(acc); 
        component.set("v.accounts",accounts);
	}
})