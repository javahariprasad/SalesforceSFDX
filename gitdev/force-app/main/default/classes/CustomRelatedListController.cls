public class CustomRelatedListController {
    
    @AuraEnabled( cacheable=true )
      public static RelatedListWrapper fetchRecords( String recordId )  {
          System.debug(' recordId '+recordId);
          RelatedListWrapper objWrap = new RelatedListWrapper();
          objWrap.listRecords = [select id, CaseNumber, ContactEmail, AccountId from case where AccountId =:recordId limit 3];
          String strCountSOQL = 'SELECT COUNT() from case where AccountId =:recordId';
          objWrap.recordCount = Database.countQuery( strCountSOQL );
          objWrap.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Marketing').getRecordTypeId();
          return objWrap;          
	}
    
    
        
    @AuraEnabled(cacheable=True)
    public static List<Contact> getJobHistories(String recordId){
        System.debug('Record Id '+recordId);
        return [SELECT Id, firstName, lastName, accountId, 
                account.name, mailingStreet, mailingCity, mailingState, mailingPostalCode, mailingCountry, email 
                FROM Contact
                LIMIT 1000];
    }
    
    @AuraEnabled(cacheable=True)
    public static List<Contact> searchJobHistory(String searchString){
        List<List<SObject>> contacts = [FIND :searchString IN ALL FIELDS RETURNING Contact(FirstName, LastName, Email, mailingStreet,
        mailingCity, mailingCountry, mailingPostalCode, account.Name)];

        return (List<Contact>) contacts[0];
    }

    @AuraEnabled
    public static void deleteJobHistories(List<Id> contactIds){
        if(contactIds.size() > 0 ){
            delete [SELECT Id FROM Contact WHERE Id in: contactIds];
        }
    }
    
	public class RelatedListWrapper {
    @AuraEnabled
    public List < Case > listRecords;
    @AuraEnabled
    public Integer recordCount =3;
    @AuraEnabled
    public String recordTypeId;    
    }
    
    
    public void isAlredySent(){
        map<Id,String> mapForEmailMessages = new map<Id,String>();
        for(EmailMessage em : [select id, EmailTemplate.Name,  RelatedToId, Status from EmailMessage]){
            mapForEmailMessages.put(em.RelatedToId,em.Status);
        }
        
        
    }
     // Attachements
    public class RelatedAttachListWrapper {
    @AuraEnabled
    public List < ContentDocumentLink > listRecords;
    @AuraEnabled
    public Integer recordCount =3;
    @AuraEnabled
    public String recordTypeId;    
    }
    
   
      @AuraEnabled( cacheable=true )
      public static RelatedAttachListWrapper fetchFiles( String recordId )  {
          System.debug(' recordId '+recordId);
          RelatedAttachListWrapper objWrap = new RelatedAttachListWrapper();
          objWrap.listRecords = [SELECT ContentDocumentId, ContentDocument.Title, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Case where id =:recordId) and LinkedEntity.Type='Case' limit 3];
          String strCountSOQL = 'SELECT COUNT() from case where AccountId =:recordId';
          objWrap.recordCount = Database.countQuery( strCountSOQL );
          objWrap.recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Marketing').getRecordTypeId();
          return objWrap;          
	}
    
    @AuraEnabled(cacheable=True)
    public static List<ContentDocumentLink> getAttachments(String recordId){
        System.debug('Record Id '+recordId);
        return [SELECT Id, ContentDocumentId, ContentDocument.Title, ContentDocument.CreatedBy.Name,  ContentDocument.LastModifiedDate, LinkedEntityId, ContentDocument.LatestPublishedVersionId  FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Case where id =:recordId) and LinkedEntity.Type='Case'];
          
        /*return [SELECT Id, firstName, lastName, accountId, 
                account.name, mailingStreet, mailingCity, mailingState, mailingPostalCode, mailingCountry, email 
                FROM Contact
                LIMIT 1000];*/
    }
    
    @AuraEnabled
    public static List<ContentDocumentLink> getAttachments2(String recordId){
        System.debug('Record Id '+recordId);
        return [SELECT Id, ContentDocumentId, ContentDocument.Title, ContentDocument.CreatedBy.Name,  ContentDocument.LastModifiedDate, LinkedEntityId, ContentDocument.LatestPublishedVersionId  FROM ContentDocumentLink where LinkedEntityId in ( SELECT Id FROM Case where id =:recordId) and LinkedEntity.Type='Case'];
          
        /*return [SELECT Id, firstName, lastName, accountId, 
                account.name, mailingStreet, mailingCity, mailingState, mailingPostalCode, mailingCountry, email 
                FROM Contact
                LIMIT 1000];*/
    }
    
    @AuraEnabled
    public static void deleteAttachments(List<Id> docIds){
        System.debug(' docIds are no cachable '+docIds);
        if(docIds.size() > 0 ){
            delete [SELECT Id FROM ContentDocument WHERE Id in: docIds];
        }
    }
    
}