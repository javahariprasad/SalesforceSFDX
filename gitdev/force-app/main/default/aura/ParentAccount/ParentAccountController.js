({
	onPageReferenceChange: function(cmp, event, helper) {
    	var myPageRef = cmp.get("v.pageReference");
    	var id = myPageRef.state.c__id;
    	cmp.set("v.id", id);
	},
	updateId: function(cmp, event, helper) {
    	var idInput = cmp.find("idInput");
    	var newId = idInput.get("v.value");
        console.log('newId   '+newId);
    	var myPageRef = cmp.get("v.pageReference");
    	var newState = Object.assign({}, myPageRef.state, {c__id: newId});
        
    	cmp.find("navService").navigate({
        	type: myPageRef.type,
        	attributes: myPageRef.attributes,
        	state: newState
    	});
	}
})