({
	getOpp : function(component, event, helper) 
    
	{
        var colll= [
            
            {label:"Name", fieldName:"Name"},
            {label:"StageName", fieldName:"StageName"},
            {label:"Amount", fieldName:"Amount"}
            
        ];
        component.set("v.col",colll);
        
		//var evt=$A.get("e.c:LE_0708_Eg1_ApplicationEvent");
        var acccc=event.getParam("acccccid");
        
        var action= component.get("c.oppList"); 
        action.setParams({"accid":acccc});
        action.setCallback(this,function(ress){
            
            var status=ress.getState();
            if(status=='SUCCESS'){
                var res=ress.getReturnValue();
                component.set("v.oppp",res);
            }
        });
        $A.enqueueAction(action);
        
        
       
	}
})