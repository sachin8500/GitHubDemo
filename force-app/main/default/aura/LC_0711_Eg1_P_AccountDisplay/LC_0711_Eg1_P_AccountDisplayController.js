({
	 showme : function(component, event, helper) 
    {
        var action= component.get("c.getData");
        //set param if you want to pass the account id from the event
        //var acc=event.getParam("aid");
        //action.setParams('a':acc);
        action.setCallback(this,function(response){
            
            var state=response.getState();
            if(state=='SUCCESS'){
                
                var result =response.getReturnValue();
                component.set("v.accounts",result);
            }
        });
        $A.enqueueAction(action);
        
		var acc=event.getParam("acc");
            var accounts=component.get("v.accounts");
            accounts.push(acc);
         component.set("v.accounts",accounts);   
	},
    callme : function(component, event, helper) 
    {
        var col =[
            {label:'AccountName',fieldName:'Name',type:'Text'},
            {label:'Phone',fieldName:'Phone',type:'Text'},
            {label:'Rating',fieldName:'Rating',type:'Text'},
           ];
        component.set("v.aculmns",col);
	}
   
    
})