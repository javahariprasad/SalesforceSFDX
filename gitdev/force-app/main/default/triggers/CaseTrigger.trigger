trigger CaseTrigger on Case (before insert, after insert,before update, after update, before delete, after delete) {
    
    if(Trigger.isUpdate && Trigger.isBefore){  // 
        
        
        //  Trigger.New -- New values
        //  Trigger.oldMap- Old values 
        
        List<Case> listcases = Trigger.New;
        
        
        Case newCase = listcases[0];
        
        //Case oCase = [select id,subject from Case where Id = : sCase.Id];
        Case oldCase = Trigger.oldMap.get(newCase.Id);
        
        system.debug(' Case subject is '+newCase.Subject);
        
        if(newCase.Subject  != oldCase.Subject){
            system.debug(' Subject is modified ');
        
        }else{
             system.debug(' Subject is not modified  ');
        }
        /*for(Case newCase:listcases){
            System.debug(' Case Subject is .. '+newCase.subject);
            
            if(newCase.subject == 'abcd')
                newCase.Description = 'updated by hari';
            
        }*/
        
       
        
        
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        List<Case> listcases = Trigger.New;
        
        Case sCase = listcases[0];
        Case oCase = [select id,subject from Case where Id = : sCase.Id];
        Case oldCase = Trigger.oldMap.get(oCase.Id);
        system.debug(' Case subject is '+oCase.Subject);
        
        //CaseTriggerHandler.invokeFuture();
        
         //for(Case newCase:listcases){
            /*System.debug(' Case Subject is .. '+oCase.subject);
            
             if(oCase.subject == 'abcd'){
                 oCase.subject = '123';
                oCase.Description = 'updated by Gokul';
                update oCase;
             }*/
            
    }
    
    
    
}