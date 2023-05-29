({
	saveme : function(component, event, helper) 
    {
		var newacc = component.get("v.newAccount");
        var evt=component.getEvent("nickname");
        evt.setParams({"acc":newacc});
        evt.fire();
	},
    clearme : function(component, event, helper) {
		
	}
    
})