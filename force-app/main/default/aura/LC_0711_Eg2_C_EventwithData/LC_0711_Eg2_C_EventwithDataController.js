({
	callme : function(component, event, helper) {
        var nmmm=component.get("v.nm");
		var evt=component.getEvent("Second");
        evt.setParams({"empname":nmmm});
        evt.fire();
        
	}
})