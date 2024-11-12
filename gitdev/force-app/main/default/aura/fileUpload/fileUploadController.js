({
    doSave: function(component, event, helper) {
        var parentId = component.get('v.parentId');
        if (component.find("fileId").get("v.files").length > 0) {
            if(parentId ==null){
                helper.helperFunctionAsPromise(component, helper.appendViaApex);
            }
                 helper.nothingToDo(component)
                .then($A.getCallback(function() {
                   var promiseArray = [];
                    for(var i=0;i<4;i++){
                        var promise1 = helper.helperFunctionAsPromise(component, helper.uploadHelper);
                        promiseArray.push(promise1);
                        console.log('***** '+i);                        
                    }
                    console.log('All Reuests are submitted to Apex controller and started to uploading...');
                    helper.checkResults(component,promiseArray);
                }))
                .then($A.getCallback(function() {
                    console.log('Done, no errors');
                }))
                .catch($A.getCallback(function(err) {                    
                    console.log('Error');
                }))
                .then($A.getCallback(function() {
                    console.log('A bit like finally');
                }));
        } else {
            alert('Please Select a Valid File');
        }
    },
 
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        var fileObj;
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
            fileObj = event.getSource().get("v.files")[0];
            console.log(' file name child component '+fileObj.name); 
        }         
        component.set("v.fileName", fileName);
        var cmpEvent = component.getEvent("cmpEvent"); 
        console.log('Component value '+component.get('v.childKey'));
        cmpEvent.setParams({"fileObj":fileObj,"childKey":component.get('v.childKey')}); 
		cmpEvent.fire();
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