({
    createme : function(component, event, helper) 
    {
        $A.createComponent(
            "lightning:button",
            {
                "label":"Hello",
                "variant":"destructive",
                "onclick":component.getReference("c.callme")
            },
            function(newbutton,status,errorMessage)
            {
                if(status=='SUCCESS'){
                    var body1=component.get("v.body");
                    body1.push(newbutton);
                    component.set("v.body",body1);
                }
            }
            
        );
    },
    callme: function(component){
        
        alert('Hello! this button created in Runtime');
    }
})