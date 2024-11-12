({
	getNotifications : function(component,event) {
        console.log(' log is called ');
        var  self = this;
      	var action = component.get("c.getTravelNotifications");
        var accountReferenceId =  component.get("v.compCode")+'|'+  component.get("v.prodCode") + '|'+ component.get("v.prodCode");
        console.log('hello   getNotifications'+accountReferenceId);
        action.setParams({
            accountReferenceId: accountReferenceId            
        });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                var notificationList = response.getReturnValue();
                if(notificationList == null){
                	self.showToast('Error occured while retreving Travel notifications, Please try again.', 'Error!', 'error', 'pester', 5000);
                }else{
                    var myJSON = JSON.stringify(notificationList);                
        			console.log('Json Array '+myJSON);
                    var obj = JSON.parse(myJSON);
                    var fobj = obj[0];                    
                    console.log('From server '+fobj.location);
                    component.set("v.notifications", obj);
                }
            }else{
                self.showToast('State Error occured while retreving Travel notifications, Please try again.', 'Error!', 'error', 'pester', 5000);
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
    formatPhoneNumber: function(component,notificationDetails ) {
        var phoneNumber = notificationDetails.secondaryPhone;
        var s = (""+phoneNumber).replace(/\D/g,'');
        var m = s.match(/^(\d{3})(\d{3})(\d{4})$/);
        var formattedPhone = (!m) ? null : "(" + m[1] + ") " + m[2] + "-" + m[3];
        notificationDetails.secondaryPhone = formattedPhone;
        component.set('v.objNotifications', notificationDetails);
    },
	
});