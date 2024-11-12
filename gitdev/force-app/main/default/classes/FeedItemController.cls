public class FeedItemController {
    
  @AuraEnabled( cacheable=true )
    public static FeedItemListWrapper getFeedItemList(String loginUserId){
        
        System.debug('Feed Item invoked '+loginUserId);
        FeedItemListWrapper objWrap = new FeedItemListWrapper();
        objWrap.listRecords = [SELECT Id, Body, Status,  CreatedDate FROM FeedItem WHERE InsertedById = '0051U000002FLoPQAW' and Type ='TextPost'];
        system.debug(' list records are .. '+objWrap.listRecords);
        return objWrap;
    }
    
    public class FeedItemListWrapper {
    @AuraEnabled
    public List < FeedItem > listRecords;
    @AuraEnabled
    public Integer recordCount =3;
    @AuraEnabled
    public String recordTypeId;    
    }
    
     public PageReference FinishLoginFlowStartUrl() {
         
         Id uId = UserInfo.getUserId();
        //do stuff
        
        //finish the login flow and send you to the startUrl (account page in this case)
        return Auth.SessionManagement.finishLoginFlow('https://haritcs-dev-ed.lightning.force.com/lightning/page/chatter');
    }


    public PageReference FinishLoginFlowHome() {
    
        return Auth.SessionManagement.finishLoginFlow();
    }

}