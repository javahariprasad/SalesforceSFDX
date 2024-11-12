public class ExportExcel {
    public List<OpportunityWrapper> oppWrapper{get; set;}
	public String xmlheader {get;set;}
    public String endfile{get;set;}
    private ApexPages.StandardController controller;
    public ExportExcel(ApexPages.StandardController controller){
        this.controller = controller;
		xmlheader ='<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?>';
        endfile = '</Workbook>';

        oppWrapper = new List<OpportunityWrapper>();
		String oppId= '0061U000004EOjlQAG';
        try {
                for(Opportunity oppty : [SELECT Id, Name, Amount, StageName , CloseDate FROM Opportunity where Id =: oppId]){
                                                        OpportunityWrapper oppWrp = new OpportunityWrapper();
														oppWrp.Name = oppty.Name;
														oppWrp.Amount = Oppty.Amount;
														oppWrp.StageName = Oppty.StageName;
														oppWrp.CloseDate = Oppty.CloseDate;
														oppWrapper.add(oppWrp);
                                                        }
        } catch(Exception ex){
            System.debug('Error : ' + ex.getMessage() +' '+ ex.getCause() + ' '+  ex.getLineNumber());
        }
	}

    public class OpportunityWrapper{
        public String Name{get; set;}
        public Decimal Amount{get; set;}
        public String StageName{get; set;}
        public Date CloseDate {get; set;}
    }
    
    public static void exportXLS(){
        Blob excelData;
        PageReference pageEX = Page.GenerateExcel;
        excelData = pageEX.getContent();
        System.debug(' Blob value '+excelData);
        saveContentDocument(excelData);
    } 
    
    public static void saveContentDocument(Blob excelData) {
        String fileName = 'sample.xls';  
        ContentVersion cv =new ContentVersion(); 
        cv.Title =fileName; 
        cv.VersionData=excelData;
        cv.PathOnClient='/' + 'fileName' ;
        cv.IsMajorVersion = false;
        insert cv; 
        system.debug('cv.id '+ cv.id);
        cv = [select id, ContentDocumentId from ContentVersion WHERE Id =: cv.Id];
        ContentDocumentLink cl = new ContentDocumentLink();
        cl.ContentDocumentId = cv.ContentDocumentId;
        cl.LinkedEntityId = '5001U00000thoQzQAI'; 
        cl.ShareType = 'V';
        cl.Visibility = 'AllUsers';     
    	insert cl;
       
    }
}