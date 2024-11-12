public class CaseTriggerHandler {
    
    public static void EmailToCaseHandler(List<Case> listNew){
        set<string> setFromAddress = new set<string>{'noreply@optimizermail.vizientinc.com','noreply@vectorvms.com','smatram@allegisgroup.com','davadhani@allegisgroup.com','snomula@teksystems.com','bayta@teksystems.com'};
        map<string,case> caseIdForSub = new map<string,case>();
        set<String> caseSub = new set<String>();
        for(Case c : listNew){
            if(c.Origin == 'Email'){  
                system.debug(' New ly creatd case id  '+c.Id);
                caseIdForSub.put(c.Subject,c);
                caseSub.add(c.Subject);
            }
        }
        System.debug('Cases created with subject Email :'+caseIdForSub);
        if(caseIdForSub.isEmpty()) return;
        List<EmailMessage> listEM = [select id , ParentId, FromAddress from EmailMessage where FromAddress not in : setFromAddress];        
        for(EmailMessage em : listEM){
            caseIdForSub.remove(em.ParentId);
        }
        map<string,case> mapOldCases = new map<string,case>();
        //map<Id,Case> mapOldCases = new map<Id,case>([select id, subject from case where Origin = 'Email' and subject in : caseSub]);
        for(Case oc : [select id, subject from case where Origin = 'Email' and subject in : caseIdForSub.keySet()]){
            mapOldCases.put(oc.Subject,oc);
        }
        
        //System.debug('Cases exists with same subject :'+mapOldCases);
       // if(mapOldCases.isEmpty()) return;
        list<case> listUC = new list<case>();
        Id caseId;
        for(Case c : caseIdForSub.values()){
            system.debug(' case id for newly created case '+c.Id);
            if(mapOldCases.containsKey(c.subject)){
                case oc =   mapOldCases.get(c.subject);
            	if(c.Subject == oc.subject){
                    Case uc = new Case(Id= oc.Id, status = 'Working');
                    caseId = oc.Id;
                    listUC.add(uc);
                    System.enqueueJob(new AsyncExecutionExample(listUC));
                    System.debug('matched with existing case -> New Sub :'+c.Subject +'   Existing case sub '+ oc.subject);
                    c.description.addError('Alread exists');
            	}
            }
        }
        system.debug('  listUC  is '+listUC);
        if(!listUC.isEmpty()){
            //invokeFuture();
             system.debug(' before pulising event ');
            Case__e ev = new Case__e();
            ev.subject__c = 'EmailToCaseHari';
            EventBus.publish(ev);
             system.debug(' after  pulising event ');
            //System.enqueueJob(new AsyncExecutionExample(listUC));
           // update listUC;
        }
         for(Case oc : [select id, subject , status from case where Origin = 'Email' and Id =: caseId]){
           system.debug(' after updating case '+oc);
        }
        
        for(Case c : caseIdForSub.values()){
            system.debug(' case id for newly created case '+c.Id);
            if(mapOldCases.containsKey(c.subject)){
                case oc =   mapOldCases.get(c.subject);
            	if(c.Subject == oc.subject){
                    //c.description.addError('Alread exists');
            	}
            }
        }
        
        
    } 
    
   public class AsyncExecutionExample implements Queueable {
    list<case> listcases;
       AsyncExecutionExample(list<case> listcases){
           this.listcases = listcases;
       }   
    public void execute(QueueableContext context) {
           System.debug(' queuable job executed   ');	
           //update  listcases;   
    }
}
    /*@future
    public static void invokeFuture(String strCase){
        System.debug('invokded future method');        
        
    }*/

}