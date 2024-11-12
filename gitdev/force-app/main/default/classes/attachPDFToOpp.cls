public class attachPDFToOpp{
	public String MstrId{GET;SET;}
    public Opportunity objOpportunity {get; set;}
    public BOOLEAN isRCI{GET;SET;}
    public BOOLEAN isCounseling{GET;SET;}
    public BOOLEAN isPerformance{GET;SET;}
    public String filName{GET;SET;}
     public BOOLEAN isAdoptionReimbursement{GET;SET;}
    //public ApexPages.PageReference page2{GET;SET;}
    public String baseURL{GET;SET;}
    public String userApprovedBy{GET;SET;}
    public CAddress caddr{GET;SET;}
    public String email{GET;SET;}
    public list<customLineItemWrapper> listolw {GET;SET;}
    public decimal totalprice {GET;SET;}
    public String strManager  {GET;SET;}
    public String strManagerhelp  {GET;SET;}
	public PageReference Cancel()
    {
        PageReference Pdf = NEW PageReference('/'+MstrID);
        pdf.setredirect(TRUE);
        RETURN Pdf;
    }
	//constructor
	public attachPDFToOpp() {
        baseURL = Url.getOrgDomainURL().toExternalForm();
		MstrID = Apexpages.currentPage().getParameters().get('id');		
        filName='oppMerPDF';
        this.userApprovedBy = UserInfo.getName();
        this.strManager ='Lorena Ferry, Vice President & General Manage.';
        this.strManagerhelp = 'Metrology & Analysis Systems Division';
        
        this.objOpportunity = [select id, Account.Name, Account.BillingAddress, CreatedDate from Opportunity where id =: MstrId];
        Address addr = (Address) objOpportunity.Account.BillingAddress;
        this.caddr = new CAddress();
        this.caddr.street = addr.getStreet();
        this.caddr.city = addr.getCity();
        this.caddr.country = addr.getCountry();
        this.caddr.pc = addr.getPostalCode();
        this.caddr.state = addr.getState();
        this.email = 'abced@gmail.com';
        Integer count =1;
        this.listolw= new list<customLineItemWrapper>();
        this.totalprice =0;
        for(OpportunityLineItem ol : [select id ,Description, Quantity, UnitPrice , TotalPrice, OpportunityId from OpportunityLineItem where OpportunityId =:MstrID ]){
            customLineItemWrapper objclw = new customLineItemWrapper();
            objclw.itemNo = count++;
            objclw.partNo = '1';
            objclw.descrition = ol.Description;
            objclw.quantity = ol.Quantity;
            objclw.unitprice = ol.UnitPrice;
            objclw.totalPrice = ol.TotalPrice;
            this.totalprice = this.totalprice+ol.TotalPrice;
            listolw.add(objclw);
        }
        
        
        
        
        /*this.objCase = [select id , ContactId, Contact.Name , Contact_Employee_ID__c, Date_of_Hire__c, Date_of_Termination__c, Reason_for_Termination__c, Preferred_Email_Phone__c , 
                        Preferred_Address__c, New_Employer_Name__c, New_Employer_Mailing_Address__c, New_Employer_Web_Address__c, New_Employer_Phone_Number__c, 
                        Is_New_Employer_a_Competitor__c, New_Employment_Industry__c, New_Employment_Job_Title__c, New_Employment_Scope_Area__c, New_Employment_Duties_Responsibilities__c, 
                        Noncompete_signed__c, Describe_noncompete__c, Nonsolicit_signed__c, Describe_nonsolicit__c, Confidentiality_signed__c, Describe_confidentiality__c, Asset_returned_to_Corp_IS__c, 
                        Date_Asset_s_Returned__c, Corp_IS_informed_if_asset_not_returned__c, Ticket_Number__c, IGP_IGP_KE_IIP_Amount__c, IGP_IGP_KE_IIP_Payout_Date__c, Awards_on_Hold__c, Awards_on_Hold_Date__c, 
                        Award_Documents_Signed__c,  Level_2__c, Letters_Sent__c, Initiate_Litigation__c,Private_Public_Fees__c,Contact.FirstName, Contact.LastName,Private_Public_Amt_Paid__c, Legal_Court_Fees__c,
                        Legal_Fee_Amt_Paid__c, Mother_Med_Fees__c, Mother_Med_Amt_Paid__c, Foreign_Adoption_Fees__c, Foreign_Adpt_Amt_Paid__c, Other_Adpt_Fees__c, Other_Adpt_Amt_Paid__c, Total_Adoption_Expense_Amount__c, 
                        Date_of_Approval__c, Amount_Approved__c,Contact.Email from case where id =: MstrID];*/
        
	}
    
    public PageReference pdfAction()
    {
        PageReference savepage =  Page.AttachMerPDF;
        try{
        savepage.getParameters().put('id',MstrID);
        system.debug('id:- '+MstrID);
        BLOB pdfBlob;
        IF (!Test.isRunningTest()) {
            pdfBlob = savepage.getContent();
        } ELSE { 
            pdfBlob = BLOB.valueOf('Test');
        }
        List<ContentDocumentLink> rciattch;
        	String FinalTitle = filName;
 
            ContentVersion conVer = NEW ContentVersion();
            conVer.ContentLocation = 'S'; 
            conVer.PathOnClient = FinalTitle+'.pdf'; 
            conVer.Title = FinalTitle; 
            conVer.VersionData = pdfBlob;
            INSERT conVer;  
 
            Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId; 
            ContentDocumentLink conDocLink = NEW ContentDocumentLink();
            conDocLink.LinkedEntityId = MstrID;
            conDocLink.ContentDocumentId = conDoc; 
            conDocLink.shareType = 'V';
            INSERT conDocLink;
            UPDATE objOpportunity;
 
            PageReference pageRef = NEW PageReference( baseURL+'/lightning/r/Case/' + System.currentPageReference().getParameters().get('id')+'/view');
            pageRef.setRedirect(TRUE);
            RETURN pageRef;
        }Catch(Exception e){
            system.debug('Exception'+e.getMessage());
            RETURN null;
        }
    }
    
    public class CAddress{
        public String street {get; set;}
        public String city {get; set;}
        public String country {get; set;}
        public String state {get; set;}
        public String pc {get; set;}
    }
    /*
    public static void createlineItem(){
        OpportunityLineItem opl1 = new OpportunityLineItem(OpportunityId = '0061U000004EOk8QAG', Product2Id='01t1U000001Auq1QAC', Description = 'LS9300AD',Quantity =1, UnitPrice = 10000.00,Part_No__c='123');
        OpportunityLineItem opl2 = new OpportunityLineItem(OpportunityId = '0061U000004EOk8QAG', Product2Id='01t1U000001Auq2QAC', Description = 'DIC Option',Quantity =2, UnitPrice = 20000.00,Part_No__c='234');
        insert opl1;
        insert opl2;
    }*/
    
    public class customLineItemWrapper{
        
        public Integer itemNo {get; set;}
        public String partNo {get; set;}
        public String descrition {get; set;}
        public decimal quantity {get; set;}
        public decimal unitprice {get; set;}
        public decimal totalPrice {get; set;}
        
        
        
    }

}