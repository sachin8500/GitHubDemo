({
	callme : function(component, event, helper) 
    
    {
		var accn=component.get("v.accnn");
        var acci=component.get("v.accin");
        
        var action= component.get("c.AccList");
        action.setParams({'AccName':accn, 'Indus':acci});
        action.setCallback(this,function(result){
            
            status =result.getState();
            if(status=='SUCCESS'){
                var res=result.getReturnValue();
                var evt=$A.get("e.c:LE_0708_Eg1_ApplicationEvent");
                evt.setParams({"acccccid":res});
                evt.fire();
            }
        });
        $A.enqueueAction(action);
	}
})