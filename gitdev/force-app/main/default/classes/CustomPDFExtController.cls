public class CustomPDFExtController {
    
    public List<WrapperData> records {get; set;}
    public Account myAcct {get; set;}

    public CustomPDFExtController(){
        String caseID = Apexpages.currentPage().getParameters().get('id');
        System.debug('  My Accout id 22'+caseID);
        this.records = new List<WrapperData>();
        WrapperData data1 = new WrapperData();
        data1.empname ='hhhh';
        data1.emploc = 'ind';
        data1.empclass ='INT';
        data1.empage = '22';
        records.add(data1);
        WrapperData data2 = new WrapperData();
        data2.empname ='ssss';
        data2.emploc = 'us';
        data1.empclass ='EXT';
        data1.empage = '25';
        records.add(data2);
        WrapperData data3 = new WrapperData();
        data3.empname ='ssss';
        data3.emploc = 'us';
        data3.empclass ='EXT';
        data3.empage = '25';
        //records.add(data3);
     
    }
    
    public CustomPDFExtController(ApexPages.StandardController stdController) {
        this.myAcct = (Account)stdController.getRecord();
        System.debug('My Accout id 11'+myAcct.Id);
    }
    
    public class WrapperData{
        public String empname {get; set;}
        public String emploc {get; set;}
        public String empclass {get; set;}
        public String empage {get; set;}
    }

}