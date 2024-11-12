({
	save : function(component, event, helper) {
             var allValid = component.find('f1').reduce(function (validSoFar, inputCmp) {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);
            if(allValid){
                var cmpEvent = component.getEvent("cmpEvent");         
                cmpEvent.setParams({ "eId": component.get('v.eId'), "eName": component.get('v.eName'), "eCity": component.get('v.eCity') });
                cmpEvent.fire();
                component.set('v.eId','');
                component.set('v.eName','');
                component.set('v.eCity','');
            }
	}
})

				/*var cmpEvent = component.getEvent("cmpEvent");         
                cmpEvent.setParams({ "eId": component.get('v.eId'), "eName": component.get('v.eName'), "eCity": component.get('v.eCity') });
                console.log(' eID  '+component.get('v.eId'));
                cmpEvent.fire();
                component.set('v.eId','');
                component.set('v.eName','');
                component.set('v.eCity','');*/