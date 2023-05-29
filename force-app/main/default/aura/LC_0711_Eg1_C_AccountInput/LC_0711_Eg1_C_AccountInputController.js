({
	callme : function(component, event, helper) {
		var newAcc=component.get("v.newAccount");
        var myevt=component.getEvent("sac");
        myevt.setParams({"acc":newAcc});
        myevt.fire();
	},
    clearme : function(component, event, helper) {
		
	}
})