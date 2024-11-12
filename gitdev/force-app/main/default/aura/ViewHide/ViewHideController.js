({
	doinit:function(component,event,helper){
      var action = component.get('c.getPicklistValues'); 
        action.setCallback(this, function(a){
            var state = a.getState(); // get the response state
            console.log('   state '+state);
            if(state == 'SUCCESS') {
                component.set('v.options', a.getReturnValue());
            }
        });
        $A.enqueueAction(action);   
    //component.set('v.options',['Education','Sports']); 
    //component.set('v.options2',['Java','Salesforce','C']); 
    //component.set('v.options3',['jan','feb','mar']);     
}
})