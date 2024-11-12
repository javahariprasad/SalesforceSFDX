({
    
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 750000,      //Chunk Max size 750Kb 
  
    appendViaApex : function(component, resolve, reject, atr) {
        console.log('Attr value '+atr);
        var appendAction = component.get('c.append');
        
        appendAction.setParams({
            's': 'hello',
            'successPercentage': 10,
            'seq': atr,
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
    helperFunctionAsPromise : function(component, helperFunction, atr) {
        console.log('Promise '+atr);
        return new Promise($A.getCallback(function(resolve, reject) {
            console.log('Promise 222 '+atr);
            helperFunction(component, resolve, reject, atr);            
        }));
            
        
        
    },
    
    myPromise1 : function (component,atr) {
         var appendAction = component.get('c.AuraCaseMethod');

        return new Promise(function (resolve, reject) {
            appendAction.setParams({
            's': 'hello',
            'successPercentage': 10,
            'seq': atr,
        });
            console.log('call back');
            appendAction.setCallback(this, function (response) {
               var state = response.getState();

                if (component.isValid() && state === "SUCCESS") {
                    console.log('success');
                    resolve(response.getReturnValue());
                }
                else if (component.isValid() && state === "ERROR") {
                    console.log('errors');
                    var errors = response.getError();
                    reject(response.getError()[0]);
                }
            });

            $A.enqueueAction(appendAction);
        });
    },
    
    callPromise: function(component,atr){
        
        
        var promiseArray = [];
        for(var i= 0; i<2;i++){
        	var promise1 = this.myPromise1(component,atr);
            promiseArray.push(promise1);
        }
        
        Promise.all(promiseArray).then(function(results) {
            console.log('Results ****'+results);
            //var p1Results = results[0]; //Results from Promise 1
           // var p2Results = results[1]; //Results from Promise 2

           //Do your thing
        }).catch(function (err) {
          //Handle errors on any promise here
        });
    },
   
        
    
})