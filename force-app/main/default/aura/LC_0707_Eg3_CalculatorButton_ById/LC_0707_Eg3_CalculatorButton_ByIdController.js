({
	Callme : function(component, event, helper) {
		
        var evt = event.getSource();
        var aid = evt.getLocalId(); 
        
        var a1 = component.find("aval").get("v.value");
        var b1 = component.find("bval").get("v.value");
        
        if(aid=='add')
        {
            var r = parseInt(a1)+parseInt(b1);
            component.find("res").set("v.value",r);
            
        }
          else if(aid=='sub')
        {
            var r = parseInt(a1)-parseInt(b1);
            component.find("res").set("v.value",r);
            
        }
            else
        {
            var r = parseInt(a1)*parseInt(b1);
            component.find("res").set("v.value",r);
            
        }
        
	}
})