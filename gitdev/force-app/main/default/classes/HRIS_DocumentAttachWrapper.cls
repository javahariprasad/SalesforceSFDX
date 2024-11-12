public class HRIS_DocumentAttachWrapper {
	@AuraEnabled
    public String docType{get; set;}
    @AuraEnabled
    public Id docId{get; set;}
    @AuraEnabled
    public string docName{get; set;}
    @AuraEnabled
    public string docCreatedDate{get; set;}
    @AuraEnabled
    public Datetime docCreatedDateTime{get; set;}
    @AuraEnabled
    public string docDescription{get; set;}    
    @AuraEnabled
    public string docCreatedBy{get; set;}
    
}