({
	    init : function(component, event, helper) {
            
           // console.log(' HAI '+window.sessionstorage());
            
		var orderId =  component.get( "v.recordId");
        var action = component.get("c.postAdvancePayment");
        console.log(' orderId  '+orderId);
        action.setParams({
            orderId: orderId
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var serviceRespnse = response.getReturnValue();
               
            }
        });
        $A.enqueueAction(action);
        
        //console.log(' init Rec is '+rec);
        //var dismissActionPanel = $A.get("e.force:closeQuickAction");
        //dismissActionPanel.fire();
	}
   
    
    
})