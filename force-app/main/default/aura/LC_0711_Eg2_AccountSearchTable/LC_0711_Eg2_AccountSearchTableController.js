({
    loadMe : function(component, event, helper) 
    
    {
        var clm=[
            		{label:"Account Name",fieldName:"Name",type:"Text"},
                	{label:"Account Phone",fieldName:"Phone",type:"Text"},
                 	{label:"Account Industry",fieldName:"Industry",type:"Text"},
                 	{label:"Account Rating",fieldName:"Rating",type:"Text"},	
                ];
        component.set("v.columns",clm);
    },
    
    searchMe : function(component, event, helper) 
    {
        var srchtxt =component.get("v.st");
        var action =component.get("c.getAccount");
        action.setParams({"searchText":srchtxt});        
        action.setCallback(this,function(response){
                           var state= response.getState();
        if(state=='SUCCESS'){
            var result =response.getReturnValue();
            component.set("v.acc", result);
        }
                           });
      	
        $A.enqueueAction(action); 
    }
})