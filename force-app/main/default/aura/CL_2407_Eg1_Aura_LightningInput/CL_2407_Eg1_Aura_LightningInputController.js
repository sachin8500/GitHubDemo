({
	cal : function(component, event, helper) 
    
    {
		var n1= parseInt(component.get("v.num1"));
        var n2= parseInt(component.get("v.num2"));
        var n3= parseInt(component.get("v.num3"));
        
        if(n1>n2 && n1>n3){
            component.set("v.result", n1);
        }
        else if(n2>n1 && n2>n3){
            component.set("v.result",n2);
            
        }
            else if(n3>n1 && n3>n2){
                component.set("v.result",n3);
            }
	},
    
    clr : function(component, event, helper) 
    {
       
        
		component.set("v.result", "");
        component.set("v.result","");
        component.set("v.result","");
	} 
})