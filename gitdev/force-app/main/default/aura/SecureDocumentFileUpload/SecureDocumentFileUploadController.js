({
    "doInit": function (component, event, helper) {
        helper.getDocxMetaData(component, event);

        var defaultFiles = component.get('v.defaultFiles');
        var predefinedDocTypes = [];  // Need to assign docs from parent component 
        //var predefinedDocTypes = ["Goverment Issued Card", "Social Securty Card", "Utility Bill"];// These values  will be populated from parent component   
        if (typeof predefinedDocTypes !== 'undefined' && predefinedDocTypes.length > 0) {
            defaultFiles = predefinedDocTypes.length;
            component.set('v.bPredefinedDocs', true);
        } else {
            helper.getCatagoryValues(component);
            helper.getMasterDocTypeValues(component);
        }
        component.set('v.predefinedDocTypes', predefinedDocTypes);
        helper.initializeFileArray(component, defaultFiles, predefinedDocTypes)
        var cont = [];
        for(var j = 0;j < 5;j++){
            cont.push({'sobjectType': 'ContentVersion'});
        }
		component.set("v.listConversion",cont);
    },
    "addRow": function (component, event, helper) {
        var files = component.get('v.files');
        var file = {};
        file.rowCount = files.length + 1;
        file.selectedfile = '';
        file.selectedCategory = '';
        file.selectedType = '';
        files.push(file);
        component.set('v.files', files);
    },

    "removeRow": function (component, event, helper) {
        var index = event.getSource().get('v.name');
        var files = component.get('v.files');
        files.splice(index - 1, 1);
        for (var i = 0; i < files.length; i++) {
            files[i].rowCount = i + 1;
        }
        component.set('v.files', files);
    },
    "save": function (component, event, helper) {
        console.log('save ');
        var files = component.get('v.files');
        var bfiles = component.get('v.bfiles');
        for (var i = 0; i < files.length; i++) {
            if (files[i].fileToBeUploaded != null) {
                console.log('Files from Index :' + i + '   ' + files[i].fileToBeUploaded.name);
            } else {
                console.log('Files from Index :' + i + '  is empty');
            }
        }
        component.set('v.files', files);
        helper.uploadDocumentAsync(component, event,files);
        let result = [1,2,3];
        //helper.sequentialProcessFiles2(component,event,helper,result);


    },
    "getDocTypeValsOnCategory": function (component, event) {
        var files = component.get('v.files');
        var index = event.getSource().get('v.name');
        var docCategory = files[index - 1].selectedCategory;
        var list = [];
        if (docCategory == 'BMW') {
            list = ["Wheel", "Engine"];
        } else if (docCategory == 'Volvo') {
            list = ["Sound", "Tire"];
        } else if (docCategory == 'Saab') {
            list = ["Seat", "Trunk"];
        }
        files[index - 1].typeOptions = list;
        files[index - 1].selectedType = '';
        component.set('v.files', files);
    },
    "handleComponentEvent": function (component, event, helper) {
        var action = event.getParam("action");
        var fileObj = event.getParam("fileObj");
        var childKey = event.getParam("childKey");
        var bPredefinedDocs = component.get("v.bPredefinedDocs");
        var intIndex = parseInt(childKey);
        console.log('Event is fired from Child -> ' + action + ', Key :' + childKey);
        if (action == 'upload') {
            helper.setFileObj(component, intIndex, fileObj);
        } else {
            helper.removeAttachment(component, intIndex);
        }

    },
})