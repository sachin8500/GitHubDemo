({
	saveme : function(component, event, helper) 	
    
    {
        //step 1- get all data from the component
        
        var name=component.get("v.name");
        var phone=component.get("v.phone");
        
        //step 2 - call the apex class
        
        var action = component.get("c.createAccount");
        
        //step 3 - pass the parameter to the apex method
        
        action.setParams({"nm":name,"ph":phone});
        //step 4- callback the function
        
        action.setCallBack(this,function(response){
            var state = response.getState();
            if(state=='SUCCESS')
            {
                var res = response.getReturnValue();
                component.set("v.message",res);
            }
            
        });        
        
        // step 5- enqueue action
		$A.enqueueAction(action);
    },
    
    clearme : function(component, event, helper) 
    
    {
		
	}
})