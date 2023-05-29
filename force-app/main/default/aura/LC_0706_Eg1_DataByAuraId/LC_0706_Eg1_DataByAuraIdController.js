({
	callme : function(component, event, helper) {
		var name= component.find("empname").get("v.value");
        var age= component.find("empage").get("v.value");
        var sal= component.find("empsal").get("v.value");
        
        
        console.log('name ======>'+ name);
        console.log('age ======>'+ age);
        console.log('salary ======>'+ sal);
	}
})