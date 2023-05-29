({
	callme : function(component, event, helper) {
		var amt = component.get("v.pri");
        var rate = component.get("v.rate");
        var term = component.get("v.term");
        var int = (amt*rate*term)/100;
        

        if(int>10){
            component.set("v.flag",true);
        }
        component.set("v.res",int);
        
	}
})