({
    doInit: function(component, evt, helper) {
        
        var  errMessage = "This is my first error message. \n"  ;
        errMessage +=   "This is my senond error message. \n"  ;
        errMessage +=   "This is my third error message. \n"  ;
        var v = $A.get("$Label.c.toastmultiline");
        var msg = v.split(',');
        var mm ='';
        for(var i=0;i<msg.length;i++){
            mm+= msg[i]+'\n';
            console.log(  'mm   '+mm);
        }
        var va = component.get("v.ContentObj.Description");
        var v22 = component.get("v.input4");
        console.log('v iss  '+va);
        console.log('v iss  '+v22);
        
       //helper.showToast(mm);
        /*setTimeout(
                $A.getCallback(function() {
                    component.find("overlayLib").notifyClose();
                }), 5000); // Waits 5 seconds
        */
        
    },
     removeAttachment: function(component, evt, helper) {
	// var va = component.get("v.ContentObj.Description");
        var v22 = component.get("v.ss");
      
        console.log('v iss  '+v22);
	}
    
   
    
})