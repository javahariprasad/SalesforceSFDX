public with sharing class FileUploadController {
 
 
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {
        // check if fileId id ''(Always blank in first chunk), then call the saveTheFile method,
        //  which is save the check data and return the attachemnt Id after insert, 
        //  next time (in else) we are call the appentTOFile() method
        //   for update the attachment with reamins chunks   
        if (fileId == '') {
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        } else {
            appendToFile(fileId, base64Data);
        }
 
        return Id.valueOf(fileId);
    }
 
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        
         system.debug('Saving chatter files '+fileName + ' '+ contentType);
    ContentVersion testContentInsert =new ContentVersion(); 
    testContentInsert.Title =fileName; 
    testContentInsert.VersionData=EncodingUtil.base64Decode(base64Data);
    testContentInsert.PathOnClient='/' + fileName ;
        testContentInsert.IsMajorVersion = false;
    insert testContentInsert; 
    system.debug('testContentInsert.id '+ testContentInsert.id);
    testContentInsert = [select id, ContentDocumentId from ContentVersion WHERE Id =: testContentInsert.Id];
    ContentDocumentLink cl = new ContentDocumentLink();
    cl.ContentDocumentId = testContentInsert.ContentDocumentId;
    cl.LinkedEntityId = parentId; 
    cl.ShareType = 'V';
     cl.Visibility = 'AllUsers';
     
    insert cl;
    system.debug('testContentInsert.id');
    return testContentInsert.id;

        /*base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
 
        Attachment oAttachment = new Attachment();
        oAttachment.parentId = parentId;
 
        oAttachment.Body = EncodingUtil.base64Decode(base64Data);
        oAttachment.Name = fileName;
        oAttachment.ContentType = contentType;
 		
        system.debug('uploaded...');
        insert oAttachment;
 		system.debug('Ater uploaded...');
        return oAttachment.Id; */

    }
 
    private static void appendToFile(Id fileId, String base64Data) {
         //base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
    	//system.debug('appending');
   		/* ContentVersion a = [
        SELECT Id, VersionData,ContentDocumentId
        FROM ContentVersion
        WHERE Id = :contentDocumentId
    ];

    String existingBody = EncodingUtil.base64Encode(a.VersionData);
    a.VersionData = EncodingUtil.base64Decode(existingBody + base64Data); 
    }*/
    }
    
     @AuraEnabled
     public static Id uploadDocument(String base64Data, ContentVersion contentVersion) {
        System.debug(' File name :'+contentVersion.Title); 
        contentVersion.VersionData=EncodingUtil.base64Decode(base64Data);
        insert contentVersion; 
        system.debug('testContentInsert.id '+ contentVersion.id);
    return contentVersion.id;
     }
}