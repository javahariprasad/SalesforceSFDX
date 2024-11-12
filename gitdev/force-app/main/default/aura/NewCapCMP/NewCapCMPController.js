({
    init: function(component, event) {
        window.addEventListener("message", function(event) {
            component.getEvent("reCaptchaSuccessEvt").fire();
        }, false);
    }
})