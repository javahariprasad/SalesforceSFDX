trigger KnowledgeTrigger  on Knowledge__kav (before insert, before update) {
    List<Knowledge__kav > listFI = ( List<Knowledge__kav >)Trigger.New;
    for(Knowledge__kav kav :listFI ){        
        Knowledge__kav oldKAV = Trigger.oldMap != null ? Trigger.oldMap.get(kav.Id) : null;
        system.debug(' kav.PublishStatus   '+kav.PublishStatus );
        if(oldKAV == null || (kav.PublishStatus != oldKAV.PublishStatus && kav.PublishStatus == 'Draft')){
            kav.Scheduled_Publish_Date__c = null;
        }
    }
}