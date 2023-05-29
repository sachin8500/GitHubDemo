({
	gm : function(component, event, helper) 
    
    {
		var m1='HI Sachin';
        var m2='Good Morning';
        
        component.set("v.msg1",m1);
        component.set("v.msg2",m2);
        helper.helperMethod(component);
             
	},
    
    gn : function(component, event, helper) 
    
    {
		var m1='HI Sachin';
        var m2='Good Night';
        
          component.set("v.msg1",m1);
        component.set("v.msg2",m2);
        helper.helperMethod(component);
             
	}
    
    
})