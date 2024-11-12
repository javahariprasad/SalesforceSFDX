/********************************************************************************************************
* @author         Deloitte
* @description    Extension class for uploading attachment functionality 
* @date           30-Mar-2017
* 
* Modification Log:
* -------------------------------------------------------------------------------------------------------
* Developer                Date                   Modification ID      Description
* -------------------------------------------------------------------------------------------------------
* Deloitte               28-March-2017                                  Initial version
* Karthik                5/23/2022                                      ENHC0061836 – Converted Case Attachments from Classic to Lightning
*********************************************************************************************************/
global with sharing class HRIS_AttachmentExtension {

     
    /********************************************************************************************************
    * @author        Deloitte
    * @date          28-March-2017
    * @description   Constructor 
    * @param         ApexPages.StandardController
    *********************************************************************************************************/
    public HRIS_AttachmentExtension(ApexPages.StandardController controller) {

    }
    
    /********************************************************************************************************
    * @author        Deloitte
    * @date          28-March-2017
    * @description   This method will be used to upload files to a Case
    * @param         caseId- Case ID to which the file will be attached to
                     attachmentBody- Attachment file to be uploaded
                     attachmentName - Name of the attachment file
                     attachmentId - Id of the attachment file, if already exists as we are uplaoding in chunks
    * @return        Attachment ID or Error message
    *********************************************************************************************************/
    @RemoteAction
    global static String doUploadAttachment2(String caseId, String attachmentBody, String attachmentName, String attachmentId) {
        system.debug('==================>'+attachmentBody);
        if(caseId!= null) {
            if(attachmentBody != null) {
                Attachment att = getAttachment(attachmentId);
                String newBody = '';
                if(att.Body != null) {
                    newBody = EncodingUtil.base64Encode(att.Body);
                }
                newBody += attachmentBody;
                att.Body = EncodingUtil.base64Decode(newBody);
                if(attachmentId == null) {
                    att.Name = attachmentName;
                    att.parentId = caseId;
                }
                upsert att;
                return att.Id;
            } else {
                return 'no attachement';
            }   
        } else {
            return 'case id null';
        }
    }
    
    /********************************************************************************************************
    * @author        Deloitte
    * @date          28-March-2017
    * @description   This method will be used to get already attached file, as file is uploaded in chunks
    * @param         attId - Id of the attachment file, if already exists
    * @return        Attachment - Already attached file is returned
    *********************************************************************************************************/

    private static Attachment getAttachment(String attId) {
        list<Attachment> attachments = [SELECT Id, Body
                                        FROM Attachment 
                                        WHERE Id =: attId];
        if(attachments.isEmpty()) {
            Attachment a = new Attachment();
            return a;
        } else {
            return attachments[0];
        }
    }
    /********************************************************************************************************
    * @author        Deloitte
    * @date          14-April-2017
    * @description   To create Case for PAF Form
    * @param         Case - caseObject
    * return         PageReference - case id is returned
    *********************************************************************************************************/
   
    
     /********************************************************************************************************
    * @author        karthik
    * @date          05-May-2020
    * @description   This method will be used to upload files to a Case
    * @param         caseId- Case ID to which the file will be attached to
                     attachmentBody- Attachment file to be uploaded
                     attachmentName - Name of the attachment file
                     attachmentId - Id of the attachment file, if already exists as we are uplaoding in chunks
    * @return        ContentVersion ID or Error message
    *********************************************************************************************************/
    @RemoteAction
    global static String doUploadAttachment(String caseId, String contentBody, String contentName, String contentId) {
        
        if(null == caseId) {
            return 'case id null';
        }else if(null == contentBody) {
            return 'no attachement';
        }        
        List<ContentVersion> listOfContents = [select id, ContentDocumentId, VersionData from ContentVersion WHERE id =: contentId];
        ContentVersion objCont;
        if(listOfContents.isEmpty()){
            objCont =new ContentVersion(); 
            objCont.Title =contentName; 
            objCont.VersionData=EncodingUtil.base64Decode(contentBody);
            objCont.PathOnClient='/' + contentName ;
            objCont.IsMajorVersion = false;
            insert objCont;
            createDocumentLinkToCase(caseId,objCont.Id);
        }else{
            objCont = listOfContents.get(0);
            String existingBody = EncodingUtil.base64Encode(objCont.VersionData);
            objCont.VersionData = EncodingUtil.base64Decode(existingBody + contentBody);
            update objCont;
        }
        return objCont.Id;
        
    }
    
    /********************************************************************************************************
    * @author        karthik
    * @date          05-May-2020
    * @description   used to create Dcumentlink to given Case and File. 
    * @param         ApexPages.StandardController
    *********************************************************************************************************/
    public static void createDocumentLinkToCase(String caseId, Id contentId){
        ContentVersion objCont = [select id, ContentDocumentId, VersionData from ContentVersion WHERE id =: contentId]; 
        ContentDocumentLink objCDL = new ContentDocumentLink();
        objCDL.ContentDocumentId = objCont.ContentDocumentId;
        objCDL.LinkedEntityId = caseId; 
        objCDL.ShareType = 'V';
        objCDL.Visibility = 'AllUsers';        
        insert objCDL;
    }
    
  public static List<HRIS_DocumentAttachWrapper> getAttachments(string caseId)
    {
        LIST<HRIS_DocumentAttachWrapper> allAttachedDocs = new LIST<HRIS_DocumentAttachWrapper>();
        //Classic 
		List<Attachment> attachedFiles =[SELECT Id,CreatedDate, Name, Description, CreatedBy.Name FROM Attachment where ParentId=:caseId];

        //Lightning
		List<ContentDocumentLink> contentDocumentLinks = [SELECT ContentDocumentId FROM 
                                                          ContentDocumentLink WHERE LinkedEntityId = :caseId];
        List<ContentVersion> contentVersions = new List<ContentVersion>();
        if (contentDocumentLinks.size() > 0)
        {
            List<Id> contentDocumentLinkIds = new List<Id>();
            for (ContentDocumentLink contentDocumentLink : contentDocumentLinks ){
                contentDocumentLinkIds .add(contentDocumentLink .ContentDocumentId);
            }
            contentVersions = [SELECT Id,ContentDocumentId,Title,VersionData,isLatest,CreatedDate,Description,CreatedBy.Name FROM ContentVersion WHERE ContentDocumentId in :contentDocumentLinkIds and FileType!='SNOTE' and IsLatest = true];
        }
        
        for(Attachment a : attachedFiles)
        {
            HRIS_DocumentAttachWrapper docAttach= new HRIS_DocumentAttachWrapper();
            docAttach.docId=a.id;
            docAttach.docName=a.name;
            docAttach.docCreatedDate = DateTime.newInstance(a.CreatedDate.year(),a.CreatedDate.month(),a.CreatedDate.day()).format('MM-dd-YYYY' );
            docAttach.docDescription = a.Description;
            docAttach.docCreatedDateTime = a.CreatedDate;
            docAttach.docCreatedBy = a.CreatedBy.Name;
            docAttach.docType = 'Classic';
            allAttachedDocs.add(docAttach);
        }
        
         for(ContentVersion c: contentVersions)
        {
            HRIS_DocumentAttachWrapper docAttach= new HRIS_DocumentAttachWrapper();
            docAttach.docId=c.ContentDocumentId;
            docAttach.docName=c.Title;
            docAttach.docCreatedDate = DateTime.newInstance(c.CreatedDate.year(),c.CreatedDate.month(),c.CreatedDate.day()).format('MM-dd-YYYY' );
            docAttach.docDescription = c.Description;
            docAttach.docCreatedDateTime = c.CreatedDate;
            docAttach.docCreatedBy = c.CreatedBy.Name;
            docAttach.docType = 'Lightning';
            allAttachedDocs.add(docAttach);
        }
        return allAttachedDocs;
    }
    
    public static void deleteDocumentForId(Id docId){
        try{
            Database.DeleteResult dr = Database.delete(docId);
        }catch(Exception ex){
            throw ex;
        }
     }
    
}