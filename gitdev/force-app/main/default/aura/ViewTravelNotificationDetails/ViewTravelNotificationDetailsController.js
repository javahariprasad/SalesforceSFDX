({
	doInit : function(component, event, helper) {
        var notifications = [];
        var notificationDetails = {
              location: "FLORIDA",
              depDate: "10/12/2019",
              retDate: "11/12/2019",
              secondaryPhone: "1234567890",
           
         };
         var notification2 = {
              location: "LAS VEGAS",
              startDate: "10/12/2019",
              endDate: "11/12/2019",
               secondaryPhone: "1234567890",
          };
        
        //notifications.push(notification1);
        notifications.push(notification2);
        component.set('v.notifications',notifications);
        
        component.set('v.notificationDetails', notificationDetails);
        /*
        var notifications = 	component.get('v.notifications');
        var index = 	component.get('v.index');
        var objItem = notifications[index];	
        console.log('location is ... '+objItem.location);
        var cardNumber = objItem.cardNumber;
        var notificationDetails = {};
        notificationDetails.location = objItem.location;
        notificationDetails.depDate = objItem.startDate;
        notificationDetails.retDate = objItem.endDate;
        notificationDetails.secondaryPhone = objItem.secondaryPhone;
        notificationDetails.cardNumber =  '('+cardNumber.replace(/.(?=.{4})/g, '')+')';
        console.log('Card Number '+notificationDetails.cardNumber);
        helper.formatPhoneNumber(component,notificationDetails);
        component.set('v.notificationDetails', notificationDetails);*/
    },
    
    edittravel : function(component, event, helper) {
       console.log('edit travel is called');
    },
    
   
    handleShowModal: function(component) {
        $A.createComponent("c:TravelNotificationConfirmationDialog", {},
                           function(content, status) {
                               if (status === "SUCCESS") {
                                   var modalBody = content;
                                   component.find('overlayLib').showCustomModal({
                                       header: "",
                                       body: modalBody, 
                                       showCloseButton: false,
                                       closeCallback: function(ovl) {
                                           console.log('Overlay is closing');
                                       }
                                   }).then(function(overlay){
                                       console.log("Overlay is made");
                                   });
                               }
                           });
    },
    
    handleApplicationEvent : function(cmp, event,helper) {
        var message = event.getParam("message");
        if(message == 'Ok')
        {
         console.log('user is clicked');
         helper.deleteNotifications(cmp,event);
        }
       else if(message == 'Cancel')
      {
        // if the user clicked the Cancel button do your further Action here for canceling
        console.log('user is not clicked');
      }
    }

	
})