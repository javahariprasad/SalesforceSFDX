({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000, //Chunk Max size 750Kb 
    
    upload: function(component, file, fileContents) {
        var startPosition = 0;
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 		this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '');
    },
    
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId) {
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.doUploadAttachment");
        action.setParams({
            caseId: component.get("v.recordId"),
            contentBody: encodeURIComponent(getchunk),
            contentName: file.name,
            contentId: attachId
        });

        // set call back 
        action.setCallback(this, function(response) {
            attachId = response.getReturnValue();
            var state = response.getState();
            if (state === "SUCCESS") {
                startPosition = endPosition;
                endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                if (startPosition < endPosition) {
                    this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    this.getPageInitData(component,null);
                    component.set("v.spinner", false);  
                }     
            }else if (state === "ERROR") {
                component.set("v.spinner", false);
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    getPageInitData: function(component, event,helper) {
        var param;
        var result = decodeURIComponent((new RegExp('[?|&]' + param + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
    	var vRecordId;
        var sum;
        vRecordId = component.get("v.recordId");
        if(vRecordId == undefined || vRecordId == null || vRecordId == ''){
        	component.set("v.recordId",result );
            vRecordId = component.get("v.recordId");
        }
        
         //Wrapper
        var actionConDoc = component.get("c.recentAttachContentDocuments");
        actionConDoc.setParams({ recordId : vRecordId });
        actionConDoc.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.recentAttachContentDocuments',response.getReturnValue());                
 				component.set("v.Sum",component.get("v.recentAttachContentDocuments").length);
                helper.prepareURL(component, event,helper);
            }
        });
        $A.enqueueAction(actionConDoc);
        
    },
    
    getStatus: function(component, event) {
        component.set("v.isCaseClosed",false);
        component.set("v.isInitiatorUser",true);
    },
    
    openModalHelper : function(component, event, helper) {
    	component.set("v.AttachObj", {});
        var modal = component.find("AttachModal");
        var modalBackdrop = component.find("AttachModalBackdrop");
        $A.util.addClass(modal,"slds-fade-in-open");
        $A.util.addClass(modalBackdrop,"slds-backdrop_open");    
    },
    
    rowEditHelper: function(component, event, helper) {    
        var AllRowsList = component.get("v.recentAttachContentDocuments");
        var selectedMenuItemValue = event.getParam("value");
        var vRecordId = selectedMenuItemValue.split('Edit-')[1];
        console.log(' vRecordId      '+vRecordId);
        for (var i = 0 ; i < AllRowsList.length; i++) { 
            if(vRecordId == AllRowsList[i].docId){
                var AttachWrapper = AllRowsList[i];
                AttachWrapper.docId = AllRowsList[i].docId;
                console.log(' AllRowsList[i].docDescription   '+AllRowsList[i].docDescription); 
                AttachWrapper.docDescription = AllRowsList[i].docDescription;
                component.set("v.AttachWrapper", AttachWrapper);
            }           
        }
    },
    
    closeModalHelper : function(component, event, helper) {
    	var modal = component.find("AttachModal");
        var modalBackdrop = component.find("AttachModalBackdrop");
        $A.util.removeClass(modal,"slds-fade-in-open");
        $A.util.removeClass(modalBackdrop,"slds-backdrop_open");
    },
    
    rowSaveHelper : function(component, event) {
    	var vRecordId;
        vRecordId = component.get("v.recordId");
    	//var vAttachObj = component.get("v.AttachObj");
    	console.log('  ... '+ JSON.stringify(component.get("v.AttachWrapper")));
        var action = component.get("c.doRowSave"); 
        action.setParams({'strAttachObj': JSON.stringify(component.get("v.AttachWrapper")), 'recordId' : vRecordId });  
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                component.set("v.recentAttachContentDocuments", response.getReturnValue());                 
            }else if (response.getState() === "ERROR") {
        		
            }else{
                
            }
        });
        $A.enqueueAction(action);
    },
    
    DeletedRowHelper: function(component, event, helper) {
        var vRecordId;
        vRecordId = component.get("v.recordId");
    	var action = component.get("c.doRowDelete"); 
        var AllRowsList = component.get("v.recentAttachContentDocuments");
        var selectedMenuItemValue = event.getParam("value");
        var vSlctdRecordId = selectedMenuItemValue.split('Delete-')[1];
        var attObj;
        for (var i = 0 ; i < AllRowsList.length; i++) { 
            if(vSlctdRecordId == AllRowsList[i].docId){
            	attObj = AllRowsList[i];    
            }
        }
        action.setParams({'strAttachObj': JSON.stringify(attObj), 'recordId' : vRecordId}); 
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
            	component.set("v.recentAttachContentDocuments", response.getReturnValue());    
            }else if (response.getState() === "ERROR") {
        		
            }else{
                
            }
            
        });
        $A.enqueueAction(action);        	        
    },
    showMessage : function(message,isSuccess) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": isSuccess?"Success!":"Error!",
            "type":isSuccess?"success":"error",
            "message": message
        });
        toastEvent.fire();
    }
    
})