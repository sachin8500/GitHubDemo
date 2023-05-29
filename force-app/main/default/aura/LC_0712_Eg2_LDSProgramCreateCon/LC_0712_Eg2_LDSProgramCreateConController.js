({
	invokeme : function(component, event, helper) 
    
    {
		component.find("rec").getNewRecord(
        									"Contact",
            								null,
            								false,
            $A.getCallback(function(){
                var acc= component.get("v.Newcon");
                if(acc==null){
                    alert('contact iniatilization failed');
                }
                else{
                    
                    alert('contact iniatilization Success');
                }
            })
        
        								);
        
	},
    
    saveme : function(component, event, helper) 
    
    {
        component.find("rec").saveRecord(function(response){});
	}
})