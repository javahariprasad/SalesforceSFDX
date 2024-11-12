({
        uploadImage : function(component, event, helper) {
            /*var fileInput = component.find("file-input").getElement();
               var message = fileInput.files[0];
               var vfWindow = component.find("vfFrame").getElement().contentWindow;
               console.log(vfWindow);
               console.log(message);
                //Update this to be dynamic instead.  Use same logic as URL in iframe url generation.
                vfWindow.postMessage(message, 'https://wisdom-dev-ednithinlighttest.ap1.visual.force.com');*/
                //Recieve from VF Page
                 var vfOrigin = "https://wisdom-dev-ed--nithinlighttest.ap1.visual.force.com";
            
            window.addEventListener("message", function(event){
            console.log(event.data);
            if(event.origin != vfOrigin){
                return;
            }
            
        },false);
               
    },
    
    doInit : function(component) {
         var vfOrigin = "https://haritcs-dev-ed--c.visualforce.com";
        window.addEventListener("message", function(event) {
            //if (event.origin !== vfOrigin) {
                // Not the expected origin: Reject the message!
              //  return;
            //}
            // Only handle messages we are interested in
            if (event.data.name === "com.mycompany.chatmessage") {
                // Handle the message
                alert("Message received"+event.data.payload);
                console.log(event.data.payload);
            }

        }, false);

    },

   
 sendToVF : function(component, event, helper) {

        var message = component.get("v.message");

        var vfOrigin = "https://haritcs-dev-ed--c.visualforce.com";

        var vfWindow = component.find("vfFrame").getElement().contentWindow;

        vfWindow.postMessage(message, vfOrigin);

    }



})