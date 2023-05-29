({
	callme : function(component, event, helper) 
    
    {
		var accnt= component.get("v.acc");
        
        var action= component.get("c.callAccount");
        action.setParams({"acc":accnt});
        action.setCallback(this,function(response){
            var state = response.getstate();
            if(state=='SUCCESS'){
                var res=response.getReturnValue();
                console.log(res);
            }
            
        });
        
        $A.enqueueAction(action);
	}
})