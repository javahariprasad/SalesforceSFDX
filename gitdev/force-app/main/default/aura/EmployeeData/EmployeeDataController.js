({
	     
    "handleComponentEvent": function (component, event, helper) {
        var eId = event.getParam("eId");
        var eName = event.getParam("eName");
        var eCity = event.getParam("eCity");
        //component.set('v.eId',eId);
        const lde = component.find('lde');
        lde.parentData(eId,eName,eCity);
    }
})