({
	doInit : function(component, event, helper) {
        var notifications = [];
        var notification1 = {
             location: "FLORIDA",
             startDate: "10/12/2019",
             endDate: "11/12/2019",View
         };
         var notification2 = {
             location: "LAS VEGAS",
             startDate: "10/20/2019",
             endDate: "11/11/2019",
          };
        notifications.push(notification1);
        notifications.push(notification2);
        //component.set("v.notifications", notifications);
        /**/
        var screen = component.get("v.screen");
        console.log('Screen from  ssss '+screen);
        if(screen == 'get'){
        	helper.getNotifications(component,event);
        }
    },
    
   
   navigateToViewComponent : function(component, event, helper) {
        var index =  event.getSource().get("v.name"); 
        component.set('v.index',index);
        console.log('index...&&&'+index);
        var notifications = component.get('v.notifications');
       
        var objItem = notifications[index];	
        var cardNumber = objItem.cardNumber;
        var notificationDetails = {};
        notificationDetails.location = objItem.location;
        notificationDetails.depDate = objItem.startDate;
        notificationDetails.retDate = objItem.endDate;
        notificationDetails.secondaryPhone = objItem.secondaryPhone;
        notificationDetails.cardNumber =  '('+cardNumber.replace(/.(?=.{4})/g, '')+')';
        console.log('Card Number '+notificationDetails.cardNumber);
		helper.formatPhoneNumber(component,notificationDetails);
        component.set('v.objNotifications', notificationDetails);
       
        var navigateEvent = $A.get("e.force:navigateToComponent");
        navigateEvent.setParams({
            componentDef: "c:ViewTravelNotificationDetails",
            componentAttributes: {
                notifications : component.get('v.notifications'),
                objNotifications : component.get('v.objNotifications'),
                index : index
            }
        });
        navigateEvent.fire();
    }


	
})