({
	formatPhoneNumber: function(component,notificationDetails ) {
        var phoneNumber = notificationDetails.secondaryPhone;
        var s = (""+phoneNumber).replace(/\D/g,'');
        var m = s.match(/^(\d{3})(\d{3})(\d{4})$/);
        var formattedPhone = (!m) ? null : "(" + m[1] + ") " + m[2] + "-" + m[3];
        notificationDetails.secondaryPhone = formattedPhone;
        component.set('v.notificationDetails', notificationDetails);
    },
    
    deleteNotifications : function(component,event) {
        var  self = this;
      	var action = component.get("c.deleteTravelNotification");
        var accountReferenceId = '12345';
        var startDate = '10/12/2019';
        action.setParams({
            accountReferenceId: accountReferenceId,
            startDate: startDate
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var objResponse = response.getReturnValue();
                console.log('objResponse is '+objResponse);
                if(objResponse === 'success'){
                	self.showToast('Successfully deleted.', 'Success!', 'success', 'pester', 5000);
                    self.navigateToViewComponent(component,event);
                }else{
                    self.showToast('Unknown exception occured, Please try again.', 'Error!', 'error', 'pester', 5000);
                }
            }else{
                self.showToast('State Unknown exception occured, Please try again.', 'Error!', 'error', 'pester', 5000);
            }
        });
        $A.enqueueAction(action);
    },
    
    showToast: function(message, title, type, mode, duration) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: title,
            message: message,
            duration: "3000",
            type: type,
            mode: mode
        });
        toastEvent.fire();
    },
    navigateToViewComponent : function(component, event) {
        var notifications = component.get('v.notifications');
        var index = component.get('v.index');
        notifications.splice(index,1);
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:GetTravelNotifications",
            componentAttributes: {
                notifications : notifications,
                index : index,
                screen: 'view'
            }
        });
        navigateEvent.fire();
    }
})