({
    doInit : function(component, event, helper,resolve,reject) {
        
       // helper.callPromise(component,1);
        /*
            	helper.helperFunctionAsPromise(component, helper.appendViaApex, 1)
                .then($A.getCallback(function() {
                    helper.callPromise2(component);
                    
                }))
                .then($A.getCallback(function() {
                    console.log('Done, no errors');
                }))
                .catch($A.getCallback(function(err) {
                    var toastEvent = $A.get("e.force:showToast");
                    
                    toastEvent.setParams({
                        title: 'Error',
                        type: 'error',
                        message: err.message
                    });

                    toastEvent.fire();
                    console.log('Error');
                }))
                .then($A.getCallback(function() {
                    console.log('A bit like finally');
                }));
          */          
            },
  
    save : function(component, event, helper) {
        //for(var i=0;i<2;i++){
            helper.callPromise(component,'1');
        //}
        
    },
    
    waiting: function(component, event, helper) {
    	//$A.util.addClass(component.find("uploading").getElement(), "uploading");
    	//$A.util.removeClass(component.find("uploading").getElement(), "notUploading");
    },
    
    doneWaiting: function(component, event, helper) {
    	//$A.util.removeClass(component.find("uploading").getElement(), "uploading");
    	//$A.util.addClass(component.find("uploading").getElement(), "notUploading");
    },
     handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
        }

         component.set("v.fileName", fileName);
    },
    
     
 // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
       // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
   },
    
 // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
     // make Spinner attribute to false for hide loading spinner    
       component.set("v.Spinner", false);
    }
})