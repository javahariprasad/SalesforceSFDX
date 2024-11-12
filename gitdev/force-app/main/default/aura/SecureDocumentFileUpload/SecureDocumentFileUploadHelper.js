({
    "getCatagoryValues": function (component) {
        var obj = component.get("v.conversion");
        var cars = ["Saabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", "Volvo", "BMW"];
        component.set("v.docCategoryOptions", cars);
        /*var action = component.get("c.getselectOptions");
        action.setParams({
            objObject: obj,
            fld: "Category__c"
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var list = response.getReturnValue();
                component.set("v.docCategoryOptions", cars);
            }
        });
        $A.enqueueAction(action);
        */
    },
    "getDocxMetaData": function (component, event) {
        /*var action = component.get("c.getDocxMetaData");
        var self =this;
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var list = response.getReturnValue();
                component.set("v.fileSizeLimit", list[0]);
                component.set("v.accept", list[1]);
                component.set("v.chunkLimit", list[2]);
                self.bCaptcha_MD = 'true';
                if(list[3]==='false'){
                	component.set("v.bCaptcha", false);
                    self.bCaptcha_MD = 'false';
                }
            }
        });
        $A.enqueueAction(action);
        */
    },
    "getMasterDocTypeValues": function (component) {
        /*var action = component.get("c.getDependentPicklistValues");
        action.setParams({
            sObjectName: "ContentVersion",
            fld: "Type__c"
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var myMap = response.getReturnValue();
                component.set("v.mastDocTypeOptions", myMap);
            }
        });
        $A.enqueueAction(action);*/
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


    "isFilesValid": function (component) {
        var errMsg = '';
        var flag = true;
        var files = component.get('v.files');
        console.log('files..!', files);
        errMsg = this.isValidFileCheck(component, files);
        console.log('Error message :' + errMsg);
        if (errMsg !== '') {
            this.showToast(errMsg, 'Error!', 'error', 'pester', 5000);
            flag = false;
            return flag;
        }
        var cdtObj = {};
        for (var i = 0; i < files.length; i++) {
            if (files[i].fileToBeUploaded.length === 0) continue;
            var cdt = files[i].fileToBeUploaded[0].name;
            if (cdtObj.hasOwnProperty(cdt))
                cdtObj[cdt].push('File # ' + (i + 1));
            else
                cdtObj[cdt] = ['File # ' + (i + 1)];
        }
        for (var key in cdtObj) {
            if (cdtObj.hasOwnProperty(key)) {
                if (cdtObj[key].length > 1) {
                    errMsg = 'Duplicate attachments found in ' + this.getFormatMessage(cdtObj[key]);
                    break;
                }
            }
        }
        if (errMsg !== '') {
            this.showToast(errMsg, 'Error!', 'error', 'pester', 5000);
            flag = false;
            return flag;
        }
        return flag;
    },
    "isValidFileCheck": function (component, files) {
        var maxFileSize = component.get('v.maxFileSize');
        var maxFileSizeBytes = maxFileSize * 1024 * 1024;
        var accept = component.get('v.accept');
        var errMsg = '';
        var count = 0;
        for (var i = 0; i < files.length; i++) {
            if ($A.util.isUndefined(files[i].selectedCategory) || $A.util.isEmpty(files[i].selectedCategory)) {
                errMsg = 'Document Category is missing for File # ' + (i + 1);
                break;
            }
            if ($A.util.isUndefined(files[i].selectedType) || $A.util.isEmpty(files[i].selectedType)) {
                errMsg = 'Document Type is missing for File # ' + (i + 1);
                break;
            }
            else if (files[i].fileToBeUploaded == null || files[i].fileToBeUploaded.length == 0) {
                errMsg = 'Attachment is missing for File # ' + (i + 1);
                break;
            }
            else if (files[i].fileToBeUploaded[0].size > maxFileSizeBytes) {
                errMsg = 'Attachment is more than ' + maxFileSize + ' MB for File # ' + (i + 1);
                break;
            } else if (!this.validateFileExtension(files[i].fileToBeUploaded[0], accept)) {
                errMsg = 'Invalid attachment type found in File # ' + (i + 1) + '. You\'re allowed to attach only ' + accept;
                break;
            }
        }
        return errMsg;
    },
    "getFormatMessage": function (errFiles) {
        for (var i = 0; i < (errFiles.length - 1); i++) {
            errFiles[i] = ' ' + errFiles[i];
        }
        return [errFiles.slice(0, errFiles.length - 1), errFiles[errFiles.length - 1]].join(' and ');
    },
    "isACKValid": function (component) {
        var newCase = component.get('v.newCase');
        if (!newCase.User_Consent__c) {
            this.showToast('Please check the Acknowledgement form', 'Error!', 'error', 'pester', 5000);
            return false;
        }
        return true;
    },


    "validateFileExtension": function (files, accept) {
        var count = 0;
        var ext = files.name.split(".");
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



    /* ********************** */


    "removeAttachment": function (component, intIndex) {
        var files = component.get('v.files');        
        files[intIndex].fileToBeUploaded = null;
        component.set('v.files', files);
    },

    setFileObj: function (component, intIndex, fileObj) {
        var files = component.get('v.files');
        files[intIndex].fileToBeUploaded = fileObj;
        component.set('v.files', files);
    },

    initializeFileArray: function (component, count, predefinedDocTypes) {
        var bPredefinedDocs = component.get('v.bPredefinedDocs');
        var files = [];
        
        for (var i = 0; i < count; i++) {
            var file = {};
            file.rowCount = (i + 1);
            if (bPredefinedDocs) {
                file.selectedType = predefinedDocTypes[i];
            } else {
                file.rowCount = (i + 1);
                file.selectedCategory = '';
                file.selectedType = '';
                file.typeOptions = [];
            }

            files.push(file);
        }
        component.set('v.files', files);
        console.log('number of files ' + files.length);
    },
    
    "uploadDocumentAsync":function(component, event, files) {
            var self = this;
            self.initializeContentVersion(component)
            .then($A.getCallback(function() {
            var listConversion = component.get("v.listConversion");
            var promiseArray = [];
                for(var i = 0; i< files.length; i++){
                    var promise1 = self.helperFunctionAsPromise(component, self.uploadFile, files[i].fileToBeUploaded, listConversion[i], self.invokeServerCall);
                    promiseArray.push(promise1);
                  }
                self.checkResults(component,promiseArray);
            }))
              .catch($A.getCallback(function(err) {
                  console.log('Error');
            }))
                 .then($A.getCallback(function() {
                 console.log('A bit like finally');
            }));
	},
    "helperFunctionAsPromise":function(component, callPromiseToUpload, file, contentVersion, invokeServerCall) {
        return new Promise($A.getCallback(function(resolve, reject) {
            callPromiseToUpload(component, resolve, reject, file, contentVersion, invokeServerCall);
        }));
    },
    "uploadFile":function(component, resolve, reject, file, contentVersion, invokeServerCall) {
        console.log(JSON.stringify(file));        
        var fr = new FileReader();
        fr.readAsDataURL(file);
        fr.onload = function() {
            let fileContents = fr.result;
            let base64Mark = "base64,";
            let dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
            fileContents = fileContents.substring(dataStart);
            invokeServerCall(component,fileContents, contentVersion, resolve, reject); 
        };
    },
    
    "invokeServerCall":function(component,fileContents, contentVersion, resolve, reject) {
        	var self = this;
        	let uploadDocumentAction = component.get("c.uploadDocument");
            uploadDocumentAction.setParams({
            	base64Data: fileContents, 
            	contentVersion: contentVersion
            });
            uploadDocumentAction.setCallback(this, function(response) {
                let state = response.getState();
                if (state === "SUCCESS") {                   
                    return resolve(response.getReturnValue());
                  }else if (response.getError() != null) {
                        reject(response.getError()[0]);
                  }
            });
            $A.getCallback(function() {
            	$A.enqueueAction(uploadDocumentAction);
            })();
    },
    
	"populateContentRequestData":function(component, file, index) { 
        var listConversion = component.get("v.listConversion");
        var contentVersion = listConversion[index];
        var fname = file.name;
        console.log('populateContentRequestData 2'+fname);
        fname = fname.substring(0, fname.lastIndexOf("."));
        fname = fname.replace(/[`~!@#$%^&*()_|+\-=?;:,.<>\{\}\[\]\\\/]/gi, '');
        fname = fname.replace('"','');
        fname = fname.replace("'",'');
        contentVersion.Title = fname;
        contentVersion.PathOnClient = "/" + file.name;
        //contentVersion.Type__c = docType;
        contentVersion.Category__c = 'Identity'; //docCategory;
        listConversion[index] = contentVersion;
        component.set("v.listConversion",listConversion);
        return contentVersion;
    },
    "initializeContentVersion":function(component) {
        var self = this;
        return new Promise(function(resolve, reject) {
        var files = component.get('v.files'); 
        for(var i = 0; i< files.length; i++){
            self.populateContentRequestData(component, files[i].fileToBeUploaded,i);
        }
        resolve('success');    
      });
    },
    
    "checkResults":function(component, promiseArray) {
         console.log('All files are uploaded');
         var self = this;
         Promise.all(promiseArray).then(function(results) {
             if(results!= null && results.length>0){
               console.log('checkResults success'+ results);
             }
        }).catch(function (err) {
           console.log('checkResults errors');
             console.log(err);
        });
    },
    
             "processFiles" : function(component, event, helper, array){              
                helper.sequentialProcessFiles2(component, event, helper, array);
          },
          
         
          methodThatReturnsAPromise2 : function(id) {
              return new Promise((resolve, reject) => {
                //setTimeout(() => {
                  console.log(`Processing ${id}`);
                  resolve(id);
                //}, 1000);
              })
            },
            sequentialProcessFiles2 : function(component, event, helper, array){
                    let tt = array.reduce( (accumulatorPromise, nextID) => {
                      console.log('All files '+nextID);  
                      return accumulatorPromise.then(() => {
                      var promise = helper.methodThatReturnsAPromise2(nextID);                      
                    });
                    }, Promise.resolve()); 
                    tt.then(e => {
                      console.log("Resolution is complete! Let's party.")
                    });    
                  } ,
                        
       
          
          
                           
})