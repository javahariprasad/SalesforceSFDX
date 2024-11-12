trigger FeedItemTrigger  on FeedItem (before insert, after insert,before update, after update) {
    
      		Case__e ev = new Case__e();
            ev.subject__c = 'EmailToCaseHari';
            EventBus.publish(ev);
     
    FeedItemHandler fih =new FeedItemHandler();
    if(Trigger.isInsert && Trigger.isAfter){
        List<FeedItem> listFI = ( List<FeedItem>)Trigger.New;
        for(FeedItem fi : listFI){ 
            System.debug(' isAfter fi is   '+fi);
        } 
        fih.populateCustomFeed(Trigger.New);
        
    }
     if(Trigger.isInsert && Trigger.isBefore){
        List<FeedItem> listFI = ( List<FeedItem>)Trigger.New;
        for(FeedItem fi : listFI){ 
            System.debug(' isBefore fi is   '+fi);
        } 
    }
    if(Trigger.isUpdate && Trigger.isBefore){
        List<FeedItem> listFI = ( List<FeedItem>)Trigger.New;
        for(FeedItem fi : listFI){ 
            System.debug(' isBefore update fi is   '+fi);
        } 
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        List<FeedItem> listFI = ( List<FeedItem>)Trigger.New;
        for(FeedItem fi : listFI){ 
            System.debug(' isBefore update fi is   '+fi);
        } 
    }
}