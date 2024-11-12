public with sharing class UploadFile_Controller {
    
    //public transient Attachment objAttachment;
    
	public transient ContentVersion objContentVersion;

    //Use getter so we can make attachment transient
    /*public Attachment getObjAttachment(){
        objAttachment = new Attachment();
        return objAttachment;
    }*/
    
    public ContentVersion getObjContentVersion(){
        objContentVersion = new ContentVersion();
        return objContentVersion;
    }


    public Boolean fileUploadProcessed{get;set;}
    public String message{get;set;}
    public String messageType{get;set;}


    Public void uploadFile(){
        try {
            
            system.debug('In side controller'+objContentVersion.VersionData);
            
            
            system.debug('In side controller'+objContentVersion.Title);
            system.debug('In side controller'+objContentVersion.ContentSize);
           
            //system.debug('In side controller'+objContentVersion.ContentType);
            objContentVersion.PathOnClient='/' + objContentVersion.Title;
        	objContentVersion.IsMajorVersion = false;
            insert objContentVersion;
            objContentVersion = [select id, ContentDocumentId from ContentVersion WHERE Id =: objContentVersion.Id];
    		ContentDocumentLink cl = new ContentDocumentLink();
    		cl.ContentDocumentId = objContentVersion.ContentDocumentId;
    		cl.LinkedEntityId = '5001U0000033YR5QAM'; 
    		cl.ShareType = 'V';
     		cl.Visibility = 'AllUsers';
            
            insert cl;
    		system.debug('objContentVersion.id'+objContentVersion.Id+ '        Content Document Id :'+cl.ContentDocumentId );
            //objAttachment.ParentId = (Id) ApexPages.currentPage().getParameters().get('id');

            //insert objAttachment;

            message = 'File was uploaded successfully';
            messageType = 'success';
            system.debug('In side controller Ater Success');

        }catch(Exception e){
            message = e.getMessage();
            
            messageType = 'error';
            system.debug('In side controller Ater error'+message);
        }
        fileUploadProcessed = true;
    }
}

//https://salesforce.stackexchange.com/questions/164305/not-showing-file-name-in-slds-file-selector
//https://github.com/jrattanpal/Blog-LC-VF-UploadFile