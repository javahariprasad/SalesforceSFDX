({
    "isFilesValid": function (component, objFile) {
        var errMsg = '';
        var flag = true;
        errMsg = this.isValidFileCheck(component, objFile);
        if (errMsg !== '') {
            this.showToast(errMsg, 'Error!', 'error', 'pester', 5000);
            component.set("v.fileName", '');
            flag = false;
            return flag;
        }

        return flag;
    },
    "isValidFileCheck": function (component, objFile) {
        var maxFileSize = component.get('v.maxFileSize');
        var maxFileSizeBytes = maxFileSize * 1024 * 1024;
        var accept = component.get('v.accept');
        var errMsg = '';

        if (objFile.size > maxFileSizeBytes) {
            errMsg = 'Attachment is more than ' + maxFileSize + ' MB for File ' + objFile.name;

        } else if (!this.validateFileExtension(objFile, accept)) {
            errMsg = 'Invalid attachment type found in File ' + objFile.name + '. You\'re allowed to attach only ' + accept;
        }
        return errMsg;
    },
    "validateFileExtension": function (objFile, accept) {
        var count = 0;
        var ext = objFile.name.split(".");
        ext.some(r => {
            var f = r.toLowerCase();
            if (accept.includes("." + f.trim()) && f.trim() !== "") {
                count++;
            }
        });
        if ((ext.length > 2 && count > 1) || count === 0) {
            return false;
        }
        return true;
    },
    "showToast": function (message, title, type, mode, duration) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: title,
            message: message,
            duration: "5000",
            type: type,
            mode: mode
        });
        toastEvent.fire();
    },
})