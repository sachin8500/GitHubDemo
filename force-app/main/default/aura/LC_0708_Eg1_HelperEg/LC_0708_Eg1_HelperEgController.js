({
	gm : function(component, event, helper) 
    
    {
		component.set("v.msg1", "good Morning");
        helper.myHelper(component);
	},
    
    gn : function(component, event, helper) 
    {
		component.set("v.msg1", "good Night");
      	helper.myHelper(component);
	}
})