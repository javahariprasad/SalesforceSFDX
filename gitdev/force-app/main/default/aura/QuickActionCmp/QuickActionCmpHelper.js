({
	showToast: function (message) {


      var toastEvent = $A.get("e.force:showToast");


      toastEvent.setParams({

          "title": "Action not allowed!",

          "message": message,

          "type" : "error",

          "mode" : "sticky"

   });


  toastEvent.fire();


},

})