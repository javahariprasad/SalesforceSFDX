trigger CaseEvent on Case__e (after insert) {
    
    
    
    for (Case__e event : Trigger.New) {
        
        System.debug(' evet is '+event);
        list<case> listCases = new list<case>();
        /*for(Case oc : [select id, subject from case where Origin = 'Email' and subject =: event.subject__c]){
            case c= new case(id=oc.Id, status = 'Working');
            listCases.add(c);
        }
        update listCases;*/
    }
    
    
}