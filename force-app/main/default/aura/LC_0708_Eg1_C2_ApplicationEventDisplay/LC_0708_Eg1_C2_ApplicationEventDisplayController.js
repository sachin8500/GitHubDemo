({
	getContact : function(component, event, helper) 
    {
        var coll= [
            
            {label:"Name", fieldName:"Name"},
            {label:"Phone", fieldName:"Phone"},
            {label:"email", fieldName:"email"}
            
        ];
        component.set("v.col",coll);
        
		//var evt=$A.get("e.c:LE_0708_Eg1_ApplicationEvent");
        var acccc=event.getParam("acccccid");
        
        var action= component.get("c.conList"); 
        action.setParams({"accid":acccc});
        action.setCallback(this,function(ress){
            
            var status=ress.getState();
            if(status=='SUCCESS'){
                var res=ress.getReturnValue();
                component.set("v.dataa",res);
            }
        });
        $A.enqueueAction(action);     
             
	}
    
})