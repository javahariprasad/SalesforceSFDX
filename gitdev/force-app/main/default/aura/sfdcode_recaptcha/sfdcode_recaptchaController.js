({
	doInit: function (cmp, evt, helper){
         cmp.set('v.lcHost', window.location.hostname);
        var vurl = 'https://'+ cmp.get("v.domain")+'--c.visualforce.com';
        

        var frameSrc = '/apex/sfdcode_recaptcha?id=' + cmp.get('v.recordId') + '&lcHost=' + cmp.get('v.lcHost');
        console.log('frameSrc:' , frameSrc);
        cmp.set('v.frameSrc', frameSrc);
        let vfOrigin ="https://haritcs-dev-ed--c.visualforce.com";
        window.addEventListener("message", function(event) {
                    console.log(event.data);
            
            if(event.data.state == 'LOADED'){
                //Set vfHost which will be used later to send message
                 console.log(event.data.vfHost);
                cmp.set('v.vfHost', event.data.vfHost);
            }
                    //alert('Origin from ........  ... .. '+event.origin);
                    if (event.origin != vfOrigin) {
                        alert('Rejected '+Rejected);
                        // Not the expected origin: Reject the message!
                        return;
                    } 
                    if (event.data==="Unlock"){   
                       // let myButton = cmp.find("myButton");
                        //myButton.set('v.disabled', false);
                       // alert('success.. ');
                    } if (event.data==="Save"){ 
                        alert("Submit clicked");
                        
                    } 
                }, false); 
        
        /*
       	var action = cmp.get('c.getVFPageDomainFromLgtComp');
        action.setCallback(this, function(response) {
        var state = response.getState();
            if (state === "SUCCESS") {
                var returnObj    = response.getReturnValue();
                cmp.set('v.vfPageURL',returnObj);
                let vfOrigin = returnObj;
            	window.addEventListener("message", function(event) {
                    console.log(event.data);
                    alert('Origin from ........  ... .. '+event.origin);
                    if (event.origin != vfOrigin) {
                        alert('Rejected '+Rejected);
                        // Not the expected origin: Reject the message!
                        return;
                    } 
                    if (event.data==="Unlock"){   
                        let myButton = cmp.find("myButton");
                        myButton.set('v.disabled', false);
                        alert('success.. ');
                    } if (event.data==="Save"){ 
                        alert("Submit clicked");
                        
                    } 
                }, false);    
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        });
        $A.enqueueAction(action);        
             */        
	},
    doSubmit: function (cmp, evt, helper){
        alert("Do Submit");
    },
    resizeIframe: function(obj) {
        
    alert('hello');    
    obj.style.height = '500px';
  },
    
    
    
     sendToVF : function(component, event, helper) {

        //var message = component.get("v.message");
        //
         var frame = document.getElementById("myFrame");
         

        var vfWindow = component.find("myFrame").getElement().contentWindow;
alert(vfWindow);
        //vfWindow.postMessage(message, vfOrigin);

    }




    
})