({
	callme : function(component, event, helper) 
    
    {
		alert('hi this is my first button invocation');
        
        component.set("v.empname","Sachin More")
        component.set("v.age",35)
        component.set("v.salary",100000)
	},
    
    clearme : function(component, event, helper) {
		component.set("v.empname","")
        component.set("v.age","")
        component.set("v.salary","")
	}
})