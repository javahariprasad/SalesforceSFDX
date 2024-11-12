({
    handleFilesChange: function (component, event, helper) {
        var fileName = 'No File Selected..';
        var objFile;
        if (event.getSource().get("v.files").length > 0) {
            fileName = event.getSource().get("v.files")[0]['name'];
            objFile = event.getSource().get("v.files")[0];
        }
        component.set("v.fileName", fileName);
        if (helper.isFilesValid(component, objFile)) {
            var cmpEvent = component.getEvent("cmpEvent");
            cmpEvent.setParams({ "action": "upload", "fileObj": objFile, "childKey": component.get('v.childKey') });
            cmpEvent.fire();
        }
    },
    "removeAttachment": function (component, event) {
        component.set("v.fileName", '');
        var cmpEvent = component.getEvent("cmpEvent");
        cmpEvent.setParams({ "action": "delete", "childKey": component.get('v.childKey') });
        cmpEvent.fire();
    },
})