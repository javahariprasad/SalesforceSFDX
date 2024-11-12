public class KnowledgePublishingService {
    @InvocableMethod(label='Schedule- Publish Knowledge Article' description='Schedule- Publish Knowledge Article.')
    public static void execute (List<Request> requestList) {
        if(!requestList.isEmpty()){
            Request req = requestList[0];
            if(req.scheduleType == 'Publish now')
                KbManagement.PublishingService.publishArticle(req.knowledgeArticleId, req.majorVersion);
            else{
                KbManagement.PublishingService.scheduleForPublication(req.knowledgeArticleId, req.scheduleDateTime);
                Knowledge__kav k = new Knowledge__kav (Id=req.knowledgeId,Scheduled_Publish_Date__c = req.scheduleDateTime);
                update k;
            }            
        }
    }
    
    public class Request{
        @InvocableVariable
        public Id knowledgeId;
        @InvocableVariable
        public Id knowledgeArticleId;
        @InvocableVariable
        public string scheduleType;
        @InvocableVariable
        public DateTime scheduleDateTime;
        @InvocableVariable
        public Boolean majorVersion;
        
    }
    
}