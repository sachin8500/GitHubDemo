({
	CreateAccHelper : function(component) {
		
        
        var name = component.get("v.name");
        var rating = component.get("v.rating");
        var industry = component.get("v.industry");
        var phone = component.get("v.phone");
        
		var action = component.get("c.createAccount");
        action.setParams({"name":"name","phone":"phone","rating":"rating","industry":"industry"});
        
        action.setCallback(this,function(response)
                           {
                               var st = response.getState();
                               if(st=='SUCCESS'){
                                   var res= response.getReturnValue();
                                   //alert(r);
                                   component.set("v.flag",true);
                                   component.set("v.result",res);
                               }
                               else if (st=='ERROR'){
                                   
                                   alert('try again later');
                                   //component.set("v.flag",false);
                                   //component.set("v.result",res);
                               }
            
        });
        
        $A.enqueueAction(action);
      
	
	}
})