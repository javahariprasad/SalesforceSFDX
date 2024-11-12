public class Controller_Helper {
    
    
    
    public  Id linkToDocument(Id contentId, Id caseId) {
		//system.debug('In linkToDocument Case Id '+caseId +' for ContentId :'+contentId);
       if (!Schema.sObjectType.ContentVersion.isAccessible() ||   
           (!Schema.sObjectType.ContentDocumentLink.fields.LinkedEntityId.isCreateable())) {
         return null;
       }
           
       ContentVersion contentVer = [SELECT id, ContentDocumentId
                      FROM ContentVersion WHERE Id =: contentId];
        
        //Create the ContentDocumentLink 
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = contentVer.ContentDocumentId;
        cdl.LinkedEntityId = caseId; 
        cdl.ShareType = 'V';
        cdl.Visibility = 'AllUsers'; 
        try{
        	insert cdl;
        }catch(Exception e){
          System.debug('Error Delete the ContentDocumentLink: '+e);  
        }  
        
        deleteDocumentLink(contentVer.ContentDocumentId,caseId);
        
        return cdl.Id;
     } 
    
    
    public void deleteDocumentLink(Id documentId,Id caseId){
        
        if (!Schema.sObjectType.ContentDocumentLink.isAccessible()){
           return;
         }
        List<ContentDocumentLink> deleteCDL = [SELECT id,
                             ContentDocumentId ,LinkedEntityId
                      FROM ContentDocumentLink
                      WHERE ContentDocumentId =: documentId and LinkedEntityId !=: getOwnerId() and LinkedEntityId !=: caseId];
        
        if (!Schema.sObjectType.ContentDocumentLink.isDeletable() || 
             !ContentDocumentLink.sObjectType.getDescribe().isDeletable() ||
           deleteCDL.size()==0) {
            return;
        }
        try{
        	delete deleteCDL; 
        }catch(Exception e){
          System.debug('Error Delete the ContentDocumentLink: '+e);  
        }
    }
    
      public String getOwnerId(){
          
      
        return userInfo.getUserId();
    } 
    
    

}