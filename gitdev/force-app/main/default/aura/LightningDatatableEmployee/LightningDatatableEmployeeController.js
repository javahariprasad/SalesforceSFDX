({
    doInit : function(component, event, helper) {
        component.set('v.mycolumns', [
            {label: 'Employee Id', fieldName: 'eId', type: 'text'},
            {label: 'Emp.Name', fieldName: 'eName', type: 'text'}, 
            {label: 'City', fieldName: 'eCity', type: 'text'},
            {type: 'button-icon', label:'Action',
                            typeAttributes:
                            {
                                iconName: 'utility:delete',
                                name: 'delete',
                                iconClass: 'slds-icon-text-error'
                            }
                }
            ]);
       
       var empList = component.get('v.empList');
       component.set('v.empList', empList);
    },
    
    handlerow : function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        if(action.name == 'delete'){
            var rows = component.get('v.empList');
        	var rowIndex = rows.indexOf(row);
			rows.splice(rowIndex, 1);
        	component.set('v.empList', rows);
        } 
	},
    
    getDataFromparent : function(component, event) {
       var params = event.getParam('arguments');
       var empList = component.get('v.empList');
       var tdata = {}
       tdata.eId = params.param1;
       tdata.eName = params.param2;
       tdata.eCity = params.param3;
       empList.push(tdata);
       component.set('v.empList', empList);
	}
});