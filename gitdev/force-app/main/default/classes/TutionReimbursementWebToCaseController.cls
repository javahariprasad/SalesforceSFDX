public without sharing class TutionReimbursementWebToCaseController {
    
    @AuraEnabled
    public static string createCase(string jsonCase,list<string> versionIds){
        string message='';
          return message;
    }
    
  /**
   * @description Method to create a case submitted through Web Form
   * @param jsonCase, lstCourses,  versionIds
   * @return message (success or Error)
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */    
    /*@AuraEnabled
    public static string createCase(string jsonCase,List<Course__c> lstCourses,list<string> versionIds){
        string message='';
        try{
            case cs;
            Boolean eContactServiceCall = false;
            //system.debug('jsonCase---'+jsonCase);
            CaseWrapperW2CForm.Tutionwrapper jsonTMBWrap = ( CaseWrapperW2CForm.Tutionwrapper) JSON.deserialize(jsonCase,  CaseWrapperW2CForm.Tutionwrapper.class);
                //Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(recordType).getRecordTypeId(); 
                Id tutionQueueID = System.Label.HR_Tuition_Reimbursement_Queue;
                String recordType = System.Label.Case_Record_TypeName;
                Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
                Id sawEmployeeConRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('SAW_Employee').getRecordTypeId();  

                String eContactId = !String.isEmpty(jsonTMBWrap.employeeID) ?contactExistsByEmployeeId(jsonTMBWrap.employeeID) : null;
                if(String.isEmpty(eContactId)){ 
                      eContactId = contactExists(jsonTMBWrap.employeeEmail);
                }
                if(String.isEmpty(eContactId)){
                    contact cont= insertEmployeeContact(jsonTMBWrap,sawEmployeeConRecordTypeId);
                    eContactId = cont!=null ? cont.id : null;
                    eContactServiceCall  = true;
                }
                if(!String.isEmpty(eContactId)){              
                    cs = Web2CaseInsertUtility.caseInsertMapping(recordTypeId,jsonTMBWrap,eContactId,tutionQueueID);
                    insert cs;
                }         
            if(cs.Id!=Null){
                	insertHRMWebFormsDataRepository(jsonTMBWrap, lstCourses, cs.id);                
                	insertCourses(lstCourses,cs.id);
                if(!versionIds.isEmpty()){
                    uploadContent(versionIds,cs.id); 
                }
            }
            if(!String.isEmpty(eContactId) && cs.Id!=Null){
                CaseContactOpco.doPeopleSoftCalloutW2C(eContactId, null, cs.Id, eContactServiceCall, false);
            }
            message='Success';  
        }
        catch(exception ex){
            system.debug('error message---'+ex.getMessage()+':'+ex.getStackTraceString());
            message =ex.getMessage();
            throw new AuraHandledException(ex.getMessage());
        }
        return message;
    }*/
    

  /**
   * @description Method to delete contentDocuments for a given list of Content versionIds
   * @param deleteVersions
   * @return no return value
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */        
    @AuraEnabled
    public static void removeContentDocs(list<string> deleteVersions){
        list<ContentDocument> conDocId = new list<ContentDocument>();
        try{
            if(!deleteVersions.isEmpty()){
                for(contentVersion conVer : [select id,contentDocumentId from 
                                             contentVersion where id IN : deleteVersions] ){
                                                 ContentDocument condoc = new ContentDocument(id=conVer.contentDocumentId);
                                                 conDocId.add(condoc);
                                             }  
            }
            
            if(!conDocId.isEmpty()){
                delete conDocId; 
            }
        }catch(exception ex){
            system.debug('error message delete---'+ex.getMessage()+':'+ex.getStackTraceString());
            throw new AuraHandledException(ex.getMessage());
        }
        
    }
    
  /**
   * @description Method to insert  ContentDocumentLink and attach it to Case
   * @param contentVersionId, recId
   * @return no return value
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */      
    /*public static void uploadContent(list<string> contentVersionId,string recId){
        try{
            List<ContentDocumentLink> conDoc = new List<ContentDocumentLink>();
            if(!contentVersionId.isEmpty()){
                for(contentversion contVer : [select id,contentdocumentid from contentversion where id IN :contentVersionId]){
                    ContentDocumentLink cdl = New ContentDocumentLink();
                    cdl.LinkedEntityId = recId;
                    cdl.ContentDocumentId = contVer.contentdocumentid;
                    conDoc.add(cdl);
                } 
            }
            
            if(!conDoc.isEmpty()){
                insert conDoc;
            }
            system.debug('conDoc----'+conDoc);
        }
        catch(exception ex){
            system.debug('upload documents error---'+ex.getMessage()+':'+ex.getStackTraceString());
             throw new AuraHandledException(ex.getMessage());
        }
    }*/

  /**
   * @description Method to return the contact for matching email
   * @param conId
   * @return conId
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */
   /* public static Contact getContactEmail(Id conId){
        if(conId!=null){
        	return [SELECT Id, Name, LastName, FirstName, Email, Business_Email__c, SAW_Supervisor__c, SAW_Supervisor__r.Name, SAW_Supervisor__r.Email from Contact where Id =:conId];
        }
        return null;
    }*/

  /**
   * @description Method to return the contact for matching EmployeeId
   * @param contactEmployeeId
   * @return conId
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */
   /* public static String contactExistsByEmployeeId(String contactEmployeeId){
        if(!String.isBlank(contactEmployeeId)){
        List<Contact> conList = [Select Id from Contact WHERE SAW_Employee_ID__c =:contactEmployeeId];
        return conList.size() > 0 ? String.Valueof(conList[0].Id) : '';
        }
        return null;
    }*/
    
  /**
   * @description Method to return the contact for matching Email
   * @param contactEmail
   * @return conId
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */    
   /* public static String contactExists(String contactEmail){
        List<Contact> conList = [Select Id from Contact where Email =: contactEmail OR Business_Email__c =: contactEmail OR Preferred_Email__c =: contactEmail OR SAW_Preferred_Contact_Email__c =: contactEmail];
        return conList.size() > 0 ? String.Valueof(conList[0].Id) : '';
    } */

  /**
   * @description Method to insert the contact with given details
   * @param jsonTMBWrap, sawEmployeeConRecordTypeId
   * @return Contact
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */
   /*public static contact insertEmployeeContact(CaseWrapperW2CForm.Tutionwrapper jsonTMBWrap, id sawEmployeeConRecordTypeId){
        contact cont = new contact();
        cont.RecordTypeId=sawEmployeeConRecordTypeId;
        cont.FirstName =jsonTMBWrap.firstName;
        cont.lastName =jsonTMBWrap.lastName;
        cont.Email=jsonTMBWrap.employeeEmail;
        cont.SAW_Employee_ID__c = jsonTMBWrap.employeeID;
        insert cont;
        
        return cont;
    } */

  /**
   * @description Method to insert the Courses with given details
   * @param lstCourses, caseId
   * @return Contact List
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */
    /*public static List<Course__c> insertCourses(List<Course__c> lstCourses,Id caseId ){
        List<Course__c> crsList = new List<Course__c>();
        if(lstCourses.size()>0){
            for(Course__c cours: lstCourses){
                Course__c crs = new Course__c();
                if(cours.Name!=null || cours.Tuition_Cost__c!=null || cours.Book_Cost__c!=null ||
                    cours.Grade__c!=null || cours.Course_Begin_Date__c!=null || cours.Course_Completion_Date__c!=null){
                    crs.Name=cours.Name;
                    crs.Tuition_Cost__c =cours.Tuition_Cost__c;
                    crs.Book_Cost__c =cours.Book_Cost__c;
                    crs.Grade__c=cours.Grade__c;
                    crs.Course_Begin_Date__c=cours.Course_Begin_Date__c;
                    crs.Course_Completion_Date__c=cours.Course_Completion_Date__c;
                    crs.Case__c=caseId;
                    crsList.add(crs);
                }
            }
            if(crsList.size()>0){
                insert crsList;
            }
        }
        
        
        return crsList;
    } */

  /**
   * @description Method to insert HRMWebFormsDataRepository
   * @param jsonTMBWrap, lstCourses, caseId
   * @return webformrepo
   * @author  
   * @since 2023-02-17 Created
   * @since 
   * 
   */  
/*public static void insertHRMWebFormsDataRepository(CaseWrapperW2CForm.Tutionwrapper jsonTMBWrap,List<Course__c> lstCourses, id caseId){
    HRMWebFormsDataRepository__c repo = new HRMWebFormsDataRepository__c();
    string courseTitles='';
    String tuitionCosts='';
    String bookCosts='';
    String crsbeginDates='';
    String crsComplDates='';
    String grades='';
    repo.Case__c = caseId;
    repo.Employee_First_Name__c = jsonTMBWrap.firstName;
    repo.Employee_Last_Name__c = jsonTMBWrap.lastName;
    repo.Employee_Email__c = jsonTMBWrap.employeeEmail;
    repo.Employee_ID__c = jsonTMBWrap.employeeID;
    repo.Educational_Institution__c = jsonTMBWrap.eduInstitution;
    repo.Degree_Program__c = jsonTMBWrap.degreeProgram;
    repo.Degree_Major_Field_of_Study__c = jsonTMBWrap.degreeStudy;
    repo.Expected_Graduation_Date__c = jsonTMBWrap.expDtGraduation;
    repo.Description__c = jsonTMBWrap.expBenefitOfPrg;
    repo.HRM_Legal_Full_Name__c = jsonTMBWrap.fullLegalName;
    for(Course__c cours: lstCourses){ 
        if(cours.Name!=null || cours.Tuition_Cost__c!=null || cours.Book_Cost__c!=null ||
                    cours.Grade__c!=null || cours.Course_Begin_Date__c!=null || cours.Course_Completion_Date__c!=null){       
            courseTitles = courseTitles+' ; '+cours.Name;
            tuitionCosts = tuitionCosts+' ; '+cours.Tuition_Cost__c;
            bookCosts = bookCosts+' ; '+cours.Book_Cost__c;
            grades = grades+' ; '+cours.Grade__c;
            crsbeginDates = crsbeginDates+' ; '+cours.Course_Begin_Date__c;
            crsComplDates = crsComplDates+' ; '+cours.Course_Completion_Date__c;
        }

    }
    repo.Course_Title__c = courseTitles;
    repo.Tuition_Cost__c = tuitionCosts;
    repo.Book_Cost__c = bookCosts;
    repo.Grade__c = grades;
    repo.Course_Begin_Date__c = crsbeginDates;
    repo.Course_Completion_Date__c = crsComplDates;
    insert repo;
}*/
}