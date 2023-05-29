({
    calme : function(component, event, helper) 
    
    {	
        $A.createComponents(
        [
            ["lightning:button",
             {
             "label":"My Button",
             "variant":"destructive",
                 "aura:id":"Button1"
             }
            ],
            [
                "lightning:input",
                {
                    "aura:id":"myinput",
                    "label":"Please enter your name",
                    "type":"Text"
                    
                }
            ],
            [
                "c:LC_0711_Eg2_AccountSearchTable",
                {
                    "aura:id":"mycmp"
                }
            ]
        ],
            function(nickname,status,errorMessage){
                if(status=="SUCCESS"){
                    var bd = component.get("v.body");
                    nickname.forEach(function(item){
                        bd.push(item)  
                    });
                    component.set("v.body",bd);
                    
                }
            }
        );
    },
    
    clearme: function(component, event, helper){
    
    var b = component.find("Button1");
    var i = component.find("myinput");
    var c = component.find("mycmp");
        b.destroy();
        i.destroy();
        c.destroy();
}
})