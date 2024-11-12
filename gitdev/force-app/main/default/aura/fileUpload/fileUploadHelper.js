({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
    
    uploadHelper: function(component,resolve, reject) {
        // start/show the loading spinner   
        //component.set("v.showLoadingSpinner", true);
        
        // get the selected files using aura:id [return array of files]
        var fileInput = component.find("fileId").get("v.files");
        // get the first file using array index[0]  
        var file = fileInput[0];
        var self = this;
        
        // check the selected file size, if select file size greter then MAX_FILE_SIZE,
        // then show a alert msg to user,hide the loading spinner and return from function  
        /*if (file.size > self.MAX_FILE_SIZE) {
            component.set("v.showLoadingSpinner", false);
            component.set("v.fileName", 'Alert : File size cannot exceed ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Selected file size: ' + file.size);
            return;
         }*/
        console.log('1111hello');
    
        // create a FileReader object 
        var objFileReader = new FileReader();
        // set onload function of FileReader object   
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;
 
            fileContents = fileContents.substring(dataStart);
            // call the uploadProcess method 
            //self.uploadInChunk(component, file, fileContents);
            
            
             var action = component.get("c.saveTheFile");
       // return new Promise(function (resolve, reject) {
        action.setParams({
            fileName: file.name,
            base64Data: fileContents            
        });
            
        console.log('gell');
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            var state = response.getState();
           
             if (component.isValid() && state === "SUCCESS") {
                    console.log('success'+response.getReturnValue());
                    return resolve(response.getReturnValue());
                }
                else if (component.isValid() && state === "ERROR") {
                    console.log('errors');
                    var errors = response.getError();
                    reject(response.getError()[0]);
                }
        });
        // enqueue the action
        $A.enqueueAction(action);
            
        });
  		console.log('End of upload');
        objFileReader.readAsDataURL(file);
    },
    
    populateReuestData: function(component,file,fileContents){
        var listFileContents = component.get("v.listFileContents");
        listFileContents.push(listFileContents);
    },
 
   /* uploadProcess: function(component, file, fileContents) {
        // set a default size or startpostiton as 0 
        var startPosition = 0;
        // calculate the end size or endPostion using Math.min() function which is return the min. value   
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
 
        // start with the initial chunk, and set the attachId(last parameter)is null in begin
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '');
    },
 */
 
    uploadInChunk: function(component, file, fileContents) {
        // call the apex method 'saveChunk'
        
        var action = component.get("c.saveTheFile");
       // return new Promise(function (resolve, reject) {
        action.setParams({
            fileName: file.name,
            base64Data: fileContents            
        });
            
        console.log('gell');
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            var state = response.getState();
            console.log('state '+state);
             if (component.isValid() && state === "SUCCESS") {
                    console.log('success'+response.getReturnValue());
                    resolve(response.getReturnValue());
                }
                else if (component.isValid() && state === "ERROR") {
                    console.log('errors');
                    var errors = response.getError();
                    reject(response.getError()[0]);
                }
        });
        // enqueue the action
        $A.enqueueAction(action);
       // });      
    },
    
      callPromise2: function(component,event){
        
        var promiseArray = [];        
          for(var i= 0; i<2;i++){
        	var promise1 = this.uploadHelper(component,event);
            promiseArray.push(promise1);
        }
          
        Promise.all(promiseArray).then(function(results) {
            console.log('Results ****'+results);
            //component.set("v.resp",results[0]);
            //var p1Results = results[0]; //Results from Promise 1
           // var p2Results = results[1]; //Results from Promise 2

           //Do your thing
        }).catch(function (err) {
          //Handle errors on any promise here
        });
 
  },
    
    callPromise: function(component,event){
       Promise.all([
           // helper.serverSideCall(component,exeAction1),
            this.uploadHelper(component,event),
            this.uploadHelper(component,event),
            this.uploadHelper(component,event)


        ]).then(
            function(response) {
                console.log('response    ****'+response);
                //component.set("v.status" ,"Success" ) ; 
                
//component.set("v.statusArray" ,response[0] ) ; 
                
            }
        ).catch(
            function(error) {
               // component.set("v.status" ,error ) ; 
                console.log(error);
            }
        );
},
    
    helperFunctionAsPromise : function(component, helperFunction) {
        //console.log('Promise '+atr);
        return new Promise($A.getCallback(function(resolve, reject) {
          
            helperFunction(component, resolve, reject);            
        }));
    },
    
    nothingToDo : function(component) {
        //console.log('Promise '+atr);
        return new Promise(function(resolve, reject) {
            console.log('Promise 3 ');
            resolve('success');           
        });
    },
    
    checkResults : function(component,promiseArray){
         Promise.all(promiseArray).then(function(results) {
             
            console.log('Results ****'+results);
            //var p1Results = results[0]; //Results from Promise 1
           // var p2Results = results[1]; //Results from Promise 2

           //Do your thing
        }).catch(function (err) {
           console.log('errors');  
          //Handle errors on any promise here
        });

    },
    
    appendViaApex : function(component, resolve, reject) {
        
        var appendAction = component.get('c.append');
        
        appendAction.setParams({
            's': 'hello',
            'successPercentage': 10,
            'seq': '1',
        });

        appendAction.setCallback(this, function(response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                console.log(' Return value in appendAction '+ response.getReturnValue())
                //component.set('v.message', response.getReturnValue());
                if(resolve) {
                    console.log('resolving appendViaApex');
                    resolve('appendViaApexPromise succeeded');
                }
            } else {
                if(reject) {
                    console.log('rejecting appendViaApexPromise');
                    reject(Error(response.getError()[0].message));
                }
            }
        });
        //console.log('Queueing appendAction');
        $A.enqueueAction(appendAction);

    },
    
    uploadHelpeArray: function(component,resolve, reject) {
        console.log('hello');
        //var fileInput = component.find("fileId").get("v.files");
        // get the first file using array index[0]  
        //var file = fileInput[0];
        var self = this;
         //var listFileContents = [];
         var listFileContents = component.get("v.listFileContents");
        
        console.log('hello 222');
        for(var i=0;i<2;i++){
            var fileInput = component.find("fileId").get("v.files");
        	var file = fileInput[0];
            console.log(" insed  "+file.name);
            var objFileReader = new FileReader();
            var fileContents;
            objFileReader.onload = $A.getCallback(function() {
                fileContents = objFileReader.result;
                var base64 = 'base64,';
                var dataStart = fileContents.indexOf(base64) + base64.length;
                fileContents = fileContents.substring(dataStart);
            });
            if(fileContents == null){
            	console.log('End of upload'+fileContents);
            }
            objFileReader.readAsDataURL(file);   
        	listFileContents.push(fileContents);
            console.log(' After End of upload');
        }            
             var action = component.get("c.saveTheFileArray");
       // return new Promise(function (resolve, reject) {
        action.setParams({
            fileName: file.name,
            base64Data: listFileContents            
        });
            
        console.log('gell'+ listFileContents.length);
        
        // set call back 
        action.setCallback(this, function(response) {
            // store the response / Attachment Id   
            var state = response.getState();
             console.log('error '+state);
             if (component.isValid() && state === "SUCCESS") {
                    console.log('success'+response.getReturnValue());
                    return resolve(response.getReturnValue());
                }
                else if (component.isValid() && state === "ERROR") {
                    console.log('errors');
                    var errors = response.getError();
                    reject(response.getError()[0]);
                }
        });
        // enqueue the action
        $A.enqueueAction(action);
            
        
    },
       
    
   

    //https://salesforce.stackexchange.com/questions/219489/javascript-promise-chaining-in-lightning-component-has-transaction-issue-in-serv
    //https://rajvakati.com/2018/05/29/using-promise-in-lightning-component/
})