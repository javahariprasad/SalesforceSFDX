({
    getInput : function(cmp, evt) {
        var myName = cmp.find("name").get("v.value");
        var myText = cmp.find("outName");
        var greet = "Hi, " + myName;
        myText.set("v.value", greet);
    },
    doInit : function(cmp, evt, helper) {
        let vfOrigin = "https://haritcs-dev-ed--c.visualforce.com";
        
        alert('hello ....'+vfOrigin+'........'+evt.origin+'.....'+evt.data);
        return;
        
        window.addEventListener("message", function(evt){
            console.log(evt.data);
            alert(evt.origin)
            if(evt.origin != vfOrigin){
                alert('hello2');
                return;
            }
            if(evt.data = "Unlock"){
                var myButton = cmp.find("myButton");
                myButton.set('v.disabled',false);
            }
        },false);
		
	},
    doSubmit : function(cmp, evt, helper) {
        alert("Do Submit");
    }
})