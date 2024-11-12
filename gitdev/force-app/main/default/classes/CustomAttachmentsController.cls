public class CustomAttachmentsController {
    /* Class Name  : HRIS_CustomAttachmentsController 
* Description  : This class for working with Classic Attachments in Lightening Custom Component HRIS_ClassicAttachments 
* Created By   : Karthik Palakurthi
* Created Date : 09-11-2022
* Modification Log:  
* --------------------------------------------------------------------------------------------------------------------------------------
* Developer                Date                 Modification ID        Description
* ---------------------------------------------------------------------------------------------------------------------------------------

* Karthik                  9/15/2022              ENHC0061836 – Converted Case Attachments from Classic to Lightning
*/
    
    @AuraEnabled
    public static List<HRIS_DocumentAttachWrapper> addAttachment(string recordId, string fileName, string base64Data){
        //base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment att = new Attachment();
        att.Name = fileName;
        att.ParentId = recordId;
        att.Body = EncodingUtil.base64Decode(base64Data);
        insert att;
        return recentAttachContentDocuments(recordId);
    }
    
    /********************************************************************************************************
* @author        karthik
* @date          16-Sep-2022
* @description   used to update lightning file(ContentVersion) to given Case
*********************************************************************************************************/
    @AuraEnabled
    public static String doUploadAttachment(String caseId, String contentBody, String contentName, String contentId) {        
        contentBody = EncodingUtil.urlDecode(contentBody, 'UTF-8');              
        List<ContentVersion> listOfContents = [select id, ContentDocumentId, VersionData from ContentVersion WHERE id =: contentId];
        ContentVersion objCont;
        System.debug('listOfContents   '+listOfContents);
        if(listOfContents.isEmpty()){           
            objCont =new ContentVersion(); 
            objCont.Title =contentName; 
            objCont.VersionData=EncodingUtil.base64Decode(contentBody);
            objCont.PathOnClient='/' + contentName ;
            objCont.IsMajorVersion = false;
             ContentVersion testContentInsert =new ContentVersion(); 
            insert objCont;
            createDocumentLinkToCase(caseId,objCont.Id);
            
        }else{
            objCont = listOfContents.get(0);
            String existingBody = EncodingUtil.base64Encode(objCont.VersionData);
            objCont.VersionData = EncodingUtil.base64Decode(existingBody + contentBody);
            update objCont;
        }
        //return recentAttachContentDocuments(caseId);
        return objCont.Id;
        
    }   
    /********************************************************************************************************
* @author        karthik
* @date          05-May-2020
* @description   used to create Dcumentlink to given Case and File. 
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
    @AuraEnabled
    public static StatusInfo getCaseStatus(String recordId){
        
        return null;
    }
    
    @AuraEnabled
    public static list<HRIS_DocumentAttachWrapper> doRowSave(string strAttachObj,String recordId){
        try{
            HRIS_DocumentAttachWrapper docAttach = (HRIS_DocumentAttachWrapper)JSON.deserialize(strAttachObj, HRIS_DocumentAttachWrapper.class);
            String docId = docAttach.docId;
            System.debug(' docAttach.docDescription   '+docAttach.docDescription);
            if(docAttach.docType == 'Lightning'){
                ContentDocument objContentDocument = new ContentDocument(Id = docId);
                objContentDocument.Description = docAttach.docDescription;
                update objContentDocument;
            }else if(docAttach.docType == 'Classic'){
                Attachment objAttachment = new Attachment(id=docAttach.docId);
                objAttachment.Description = docAttach.docDescription;
                update objAttachment;
            }        
            return recentAttachContentDocuments(recordId);
        }catch (Exception e) {
            throw new AuraHandledException(e.getMessage());    
        }
    }
    
    @AuraEnabled
    public static list<HRIS_DocumentAttachWrapper> doRowDelete(string strAttachObj,String recordId){
        try{
            HRIS_DocumentAttachWrapper docAttach = (HRIS_DocumentAttachWrapper)JSON.deserialize(strAttachObj, HRIS_DocumentAttachWrapper.class);
            HRIS_AttachmentExtension.deleteDocumentForId(docAttach.docId);
            return recentAttachContentDocuments(recordId);
        }catch (Exception e) {
            throw new AuraHandledException(e.getMessage());    
        }
    }
    
    /********************************************************************************************************
* @author        karthik
* @date          12-Sep-2022
* @description   used to retreive files for given caseId
*********************************************************************************************************/
    @AuraEnabled
    public static List<HRIS_DocumentAttachWrapper> recentAttachContentDocuments(String recordId){
        return HRIS_AttachmentExtension.getAttachments(recordId);
    }
    
    public class StatusInfo{
        @AuraEnabled
        public boolean isCaseClosed{get;set;}
        
        @AuraEnabled
        public boolean isInitiatorUser{get;set;}
    }
    
    @AuraEnabled
    public static String downloadAttachments(string recordId){
        
        String docName = 'apex-zip-sample.zip'; // Document's name
        List<Attachment> attachments = [SELECT Name, Body FROM Attachment WHERE ParentId = :recordId];
        System.debug('>>> attachments ' + attachments.size());
        Zippex sampleZip = new Zippex();
        for(Attachment file : attachments) {
            sampleZip.addFile('folder/' + file.Name, file.Body, null);
        }
        try{
            Document doc = new Document();
            doc.FolderId = UserInfo.getUserId();
            doc.Name = docName;
            doc.Body = sampleZip.getZipArchive();
            insert doc;
            System.debug('>>> doc ' + doc.Id);
            return '/servlet/servlet.FileDownload?file=' + doc.Id;
        } catch ( Exception ex ) {
            System.debug('>>> ERROR ' + ex);
        }
        return null;
    }
}