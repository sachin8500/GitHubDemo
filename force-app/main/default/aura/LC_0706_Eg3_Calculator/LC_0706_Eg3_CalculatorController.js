({
	addme : function(component, event, helper) 
    {
		var A = component.get("v.aval");
        var B = component.get("v.bval");
        var R = parseInt(A) + parseInt(B);
        component.set("v.result",R);
        
	},
    subme : function(component, event, helper) 
    {
		var A = component.get("v.aval");
        var B = component.get("v.bval");
        var R = parseInt(A) - parseInt(B);
        component.set("v.result",R);
	},
    mulme : function(component, event, helper) 
    {
		var A = component.get("v.aval");
        var B = component.get("v.bval");
        var R =parseInt(A) * parseInt(B);
        component.set("v.result",R);
	},
})