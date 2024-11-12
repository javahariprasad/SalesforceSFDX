public class ExcelGeneratorController {

    public List<CaseWrapper> listCaseWrapper{get; set;}
	public String xmlheader {get;set;}
    public String endfile{get;set;}
    private ApexPages.StandardController controller;
    public ExcelGeneratorController(ApexPages.StandardController controller){
        this.controller = controller;
		xmlheader ='<?xml version="1.0"?><?mso-application progid="Excel.Sheet"?>';
        endfile = '</Workbook>';

        listCaseWrapper = new List<CaseWrapper>();
		String caseId= '5001U00000thoQzQAI';
        try {
                for(Case c : [SELECT Id, CaseNumber FROM Case where Id =: caseId]){
                                                        CaseWrapper caseWrp = new CaseWrapper();
														caseWrp.Id = c.Id;
														caseWrp.CaseNumber = c.CaseNumber;
														listCaseWrapper.add(caseWrp);
                                                        }
        } catch(Exception ex){
            System.debug('Error : ' + ex.getMessage() +' '+ ex.getCause() + ' '+  ex.getLineNumber());
        }
	}

    public class CaseWrapper{
        public String Id{get; set;}
        public String CaseNumber{get; set;}
    }
    
    public static void generateExcel(){
        Blob excelData;
        PageReference pageEX = Page.ExcelGeneratorPage;
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
        System.debug(' cv Id '+cv.Id);
       
    }
}