({
	nxt : function(component, event, helper) 
    
    {
		component.set("v.name","Savita");
        component.set("v.age","35");
        component.set("v.salary","100000");
        
        component.set("v.name","Vinuta");
        component.set("v.age","12");
        component.set("v.salary","110000");
	},
    
    clr : function(component, event, helper) 
    {
		component.set("v.name","");
        component.set("v.age","");
        component.set("v.salary","");
	}
    
})