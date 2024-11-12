trigger Case_Update_Ttrig on Case (before insert, after insert,before update, after update) {
    if(Trigger.isInsert && Trigger.isBefore){
        //CaseTriggerHandler.EmailToCaseHandler(Trigger.New);
    }
      /*   
    if(Trigger.isUpdate && TRigger.isBefore){
        Integer difHrs =0;
        double dt;
        for(Case newCase:Trigger.New){
        Case oldCase = Trigger.oldMap.get(newCase.Id);
            if(newCase.status != oldCase.status){    
                if(newCase.status == 'Working' && oldCase.status != 'Working'){               
                    //newCase.AwatingTime__c = System.now();        
                }
                if(newCase.status != 'Working' && oldCase.status == 'Working'){
                    //newCase.DifferenceTime__c = newCase.DifferenceTime__c+(System.now().getTime()/1000 - newCase.AwatingTime__c.getTime()/1000);        
                }
            }  
        system.debug(' Awaiting time '+newCase.AwatingTime__c+ '  newCase.DifferenceTime__c'+newCase.DifferenceTime__c+ 'total minutes '+dt); 
            
            if(!'Booked'.equals('abc')){
                
            }
        }
    }
    else if(Trigger.isUpdate && TRigger.isAfter){
     for(Case newCase:Trigger.New){
        Case oldCase = Trigger.oldMap.get(newCase.Id);
         //Case_Controller.validateLeadStatus(newCase,oldCase);
     }
    }*/
}