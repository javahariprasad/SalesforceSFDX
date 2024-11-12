({
	doInit : function(component, event, helper) {
        let vfOrigin = "https://haritcs-dev-ed--c.visualforce.com";
        window.addEventListener("message", function(event){
            console.log(event.data);
            if(event.origin != vfOrigin){
                return;
            }
            if(event.data = "Unlock"){
                let myButton = component.find("myButton");
                myButton.set('v.disabled',false);
            }
        },false);
		
	},
    doInit : function(component, event, helper) {
        alert("Do Submit");
    }
})