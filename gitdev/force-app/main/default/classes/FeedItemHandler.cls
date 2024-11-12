public class FeedItemHandler {
    
    public void populateCustomFeed(List<FeedItem> listFI){
        
        TDSEvent__e  td = new TDSEvent__e ();
        td.acctId__c= '123455';
        EventBus.publish(td);
        
        map<Id, Custom_FeedItem__c> mapForCF = new map<Id, Custom_FeedItem__c>();
        for(FeedItem fi : listFI){
             Custom_FeedItem__c cf = new Custom_FeedItem__c(Body__c=fi.Body, CommentCount__c=fi.CommentCount, FeedItem__c = fi.Id, LikeCount__c = fi.LikeCount,ParentId__c = fi.ParentId,
                                                            Visibility__c = fi.Visibility,Title__c = fi.Title);
            
            
            mapForCF.put(fi.Id,cf);
            
        }
        
       
        
        
        
        system.debug(' mapForCF ' +mapForCF);
        map<Id,CollaborationGroupFeed> mapcg = new map<Id,CollaborationGroupFeed>();
        for(CollaborationGroupFeed cf : [select Parent.CollaborationType, Parent.Name,ParentId,  LinkUrl, Id,  RelatedRecordId , Type, Visibility From CollaborationGroupFeed where Id in : mapForCF.keySet()]){
            mapcg.put(cf.ParentId,cf);
            
        }
        
        /*map<Id,Id> mapOfColGrp = new  map<Id,Id>();
        for(Custom_CollaborationGroup__c cg : [SELECT Id,  CollaborationGroupId__c from  Custom_CollaborationGroup__c where CollaborationGroupId__c in : mapcg.keyset()]){
            mapOfColGrp.put(cg.CollaborationGroupId__c, cg.Id);
        }
      	
        list<Custom_CollaborationGroup__c> listcolGrps = new list<Custom_CollaborationGroup__c>();
        for(CollaborationGroup cg : [SELECT Id, Name, GroupEmail , MemberCount FROM CollaborationGroup where id in: mapcg.keyset()]){
            if(!mapOfColGrp.containsKey(cg.Id)) {
        		Custom_CollaborationGroup__c  ccg= new Custom_CollaborationGroup__c(CollaborationGroupId__c = cg.Id);
                listcolGrps.add(ccg);
            }
        }
        if(!listcolGrps.isEmpty()){
        	insert listcolGrps;
        } 
        
       for(CollaborationGroupMember cf : [SELECT Id, CollaborationGroupId, Member.Name FROM CollaborationGroupMember where CollaborationGroupId in : mapcg.keySet()]){
           
          //  Custom_Collaboration_GroupMember__c cbg = new Custom_Collaboration_GroupMember__c(ChatterGroup__c = cf.CollaborationGroupId, Member__c = cf.MemberId);
       }
*/        
           system.debug(' mapcg ' +mapcg);
        for(CollaborationGroupMember cgm : [SELECT id, MemberId , Member.Name, CollaborationGroupId FROM CollaborationGroupMember WHERE CollaborationGroupId in: mapcg.keySet()]){
            CollaborationGroupFeed cgf = mapcg.get(cgm.CollaborationGroupId);
            //Id feedItemId = mapcg.get(cgm.CollaborationGroupId);
            String memberId = '<a href="'+'/'+cgm.MemberId+'">'+cgm.Member.Name+'</a>';
            system.debug(' memberId ' +memberId);
            Custom_FeedItem__c cf  = mapForCF.get(cgf.Id);
            cf.GroupMembers__c =(cf.GroupMembers__c == null ? '' : cf.GroupMembers__c+';')+' '+ +cgm.Member.Name;
            cf.ParentName__c = cgf.Parent.Name;
            system.debug('  cf.GroupMembers__c ' + cf.GroupMembers__c);
        }
        
        system.debug(' final group Custom_FeedItem__c ' +mapForCF.values());
        if(!mapForCF.isEmpty()){
            insert mapForCF.values();
        }
        
    }

}