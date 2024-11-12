/*
* Class Name  : HRIS_CustomAttachmentsController.js 
* Description  : This class for working with Classic Attachments in Lightening Custom Component HRIS_ClassicAttachments 
* Created By   : Karthik Palakurthi
* Created Date : 09-11-2022
* Modification Log:  
* --------------------------------------------------------------------------------------------------------------------------------------
* Developer                Date                 Modification ID        Description
* ---------------------------------------------------------------------------------------------------------------------------------------

* Karthik                  10/6/2022             ENHC0062492          Allow Multiple Upload with Browse and Drag Drop
*/


({ 
    handleAfterDownload : function(component,event,helper){        
        var cIds;
        var cURLinstance = '/sfc/servlet.shepherd/document/download/';
        var AllRowsList = component.get("v.recentAttachContentDocuments");
        for (var i = 0 ; i < AllRowsList.length; i++) { 
            var id = AllRowsList[i].docId;
            if(id.startsWith('069')){
                cIds = cIds != null ? cIds +'/'+ id : id;
            }       
        }
        cURLinstance = cURLinstance+cIds+'?name=foo.zip';
        
        var urlEvent = $A.get("e.force:navigateToURL"); 
        urlEvent.setParams({"url": cURLinstance});	
        urlEvent.fire();
        
    },
    handleAfterUpload:function(component,event,helper){
       	console.log('***** refresh');
   		helper.getPageInitData(component,event);
   },
    onFileUploaded:function(component,event,helper){
        component.set("v.spinner", true); 
        var files = component.get("v.fileToBeUploaded");
        if (files && files.length > 0) {
            var file = files[0][0];
            var reader = new FileReader(); 
            reader.onload = $A.getCallback(function() {
                var dataURL = reader.result;
                var content = dataURL.match(/,(.*)$/)[1];
                helper.upload(component, file, content);
            });
            reader.readAsDataURL(file); 
        }
    },
    doInit: function(component,event,helper){
        helper.getPageInitData(component,event,helper);
        helper.getStatus(component,event); 
    }, 
    
    handleUploadFinished:function(component,event,helper){
        var uploadedFiles = event.getParam("files");
        //console.log('Files uploaded: ',uploadedFiles);
    },
    goToViewAll : function(component,event,helper){
        console.log('here');
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": "/lightning/r/" + component.get("v.recordId") + "/related/CombinedAttachments/view"
        });
        urlEvent.fire();
    },    
    handleActionSelection: function (cmp, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        if(selectedMenuItemValue.includes('Edit-')){
        	helper.openModalHelper(cmp, event, helper);
        	helper.rowEditHelper(cmp, event);    
        }else if(selectedMenuItemValue.includes('Delete-')){
        	var r = confirm("Are you sure want to Delete the attachment, click OK to proceed.");
            if (r == true) {
                helper.DeletedRowHelper(cmp, event, helper);
            }    
        }else if(selectedMenuItemValue.includes('Download-')){
            var vRecordId = selectedMenuItemValue.split('Download-')[1];
            var vURL;           
            if(vRecordId.startsWith('069')){
                vURL = '/sfc/servlet.shepherd/document/download/' + vRecordId + '?operationContext=S1';
            }else{
        		vURL = '/servlet/servlet.FileDownload?file='+vRecordId+'&operationContext=S1';
            }
        	window.open(vURL,'_blank');
        }        
    },    
    // Function used to close the modal
    closeModal: function(component, event, helper) {
        helper.closeModalHelper(component, event, helper);
    },
    rowSave: function(component, event, helper) {
    	helper.rowSaveHelper(component, event);        
        helper.closeModalHelper(component, event, helper);
    }
})