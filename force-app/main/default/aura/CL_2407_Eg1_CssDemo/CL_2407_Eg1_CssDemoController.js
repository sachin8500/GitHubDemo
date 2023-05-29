({
	cal : function(component, event, helper) 
    {
		var p= parseFloat(component.get("v.pri"));
        var t= parseFloat(component.get("v.term"));
        var i=parseFloat(component.get("v.int"));
        var r = (p*t*i)/100;
                
        component.set("v.result",r);
      
	},
    
    clr : function(component, event, helper) 
    {
		component.set("v.result","");
        component.set("v.pri","");
        component.set("v.term","");
        component.set("v.int","");
	}
})