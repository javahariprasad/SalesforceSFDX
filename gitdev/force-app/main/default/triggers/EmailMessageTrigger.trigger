trigger EmailMessageTrigger on EmailMessage (before insert) {
    
    System.debug(' Email Message TRogger fired');
     for(EmailMessage  te : trigger.new){
    	System.debug('Event is fired');
        

        
    }

}