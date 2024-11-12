trigger TDSEventTrigger on TDSEvent__e (after insert) {
   
    
    for(TDSEvent__e  te : trigger.new){
    	System.debug('Event is fired');
        
        if(te.acctId__c =='1'){
            /*List<TDSEvent__e> listtds = new list<TDSEvent__e>();
            TDSEvent__e  td4 = new TDSEvent__e ();
            td4.acctId__c = '5';
            listtds.add(td4);
            EventBus.publish(listtds);*/
        }
        
    }


}