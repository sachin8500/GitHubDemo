({
	showme : function(component, event, helper) {
		//"showme" fired when page loaded
		//step 1 --call/get the method
		
        var action = component.get("c.Givedata");
        
        //step 2 pass the parameter 
        //in this exp step 2 as we are not passing any param here
        //step 3 invoke/call the function
        action.setCallback(this,function(response)
                           {
                           
                           var state= response.getState();
        							if(state=='SUCCESS')	
                                    {
            							var res= response.getReturnValue(); //step 3.1 get the state of invoke
                                        component.set("v.acc",res);  //step 3.2 get the result/val/response from SSC
                                    }
                           });
      
     //step 4 enqueue the action  $A.enqueueAction();
     	$A.enqueueAction(action);
        
	},
    callme : function(component, event, helper) {
		
	}
})