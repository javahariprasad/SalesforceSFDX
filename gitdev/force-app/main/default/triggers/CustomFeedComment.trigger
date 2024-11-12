trigger CustomFeedComment  on FeedComment (before insert, after insert, before update, after update) {
    
     if(Trigger.isUpdate && Trigger.isBefore){
        List<FeedComment> listFI = ( List<FeedComment>)Trigger.New;
        for(FeedComment fi : listFI){ 
            System.debug(' isBefore isUpdate fi is   '+fi);
        } 
    }
     if(Trigger.isUpdate && Trigger.isAfter){
        List<FeedComment> listFI = ( List<FeedComment>)Trigger.New;
        for(FeedComment fi : listFI){ 
            System.debug('isAfter isUpdate fi is   '+fi);
        } 
    }
    if(Trigger.isInsert && Trigger.isBefore){
        List<FeedComment> listFI = ( List<FeedComment>)Trigger.New;
        for(FeedComment fi : listFI){ 
            System.debug(' isBefore fi is isInsert  '+fi);
        } 
    }
    if(Trigger.isInsert && Trigger.isAfter){
        List<FeedComment> listFI = ( List<FeedComment>)Trigger.New;
        for(FeedComment fi : listFI){ 
            System.debug(' isAfter fi is isInsert  '+fi);
        } 
    }

}