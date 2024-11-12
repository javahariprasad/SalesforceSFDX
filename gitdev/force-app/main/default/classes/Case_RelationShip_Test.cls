@isTest
public class Case_RelationShip_Test {
    
   
    private static Case populateCaseTestData(){
        Case c = new Case();
        return c ; 
    }
   
    private static ContentVersion populateContentData(String docCategory,String docType){
        ContentVersion contentVersion = new ContentVersion();
        String fname = 'dummy';
        contentVersion.Title = fname;
        contentVersion.Category__c = docCategory;
        contentVersion.PathOnClient = '/' + fname;        
        contentVersion.VersionData = Blob.valueOf('Hello world');
        return contentVersion ; 
        
    }
   
    @isTest
    public static void mapCaseToContentVersionsSameCatTwoFilesTest(){
         System.debug(' Start For Scenario .... two same  catagories ');
        Test.StartTest(); 
        Case_RelationShip dcr = new Case_RelationShip();
        Case c = populateCaseTestData();
        List<Id> listContentIds = new List<Id>();
        ContentVersion contVer1 = populateContentData('Identity','Utility Bill');
        insert contVer1;
        ContentVersion contVer2 = populateContentData('Identity','Utility Bill');
        insert contVer2;
        listContentIds.add(contVer1.Id);
        listContentIds.add(contVer2.Id);
        
        if(dcr!=null){
          dcr.mapCaseToContentVersions(listContentIds,c);
        }
        Test.stopTest();
        System.debug(' End For Scenario .... two same  catagories ');
    }

    
    @isTest
    public static void mapCaseToContentVersionsDifferentCatTwoFilesTest(){
        System.debug(' Start For Scenario .... two diferent catagories ');
        
        Test.StartTest(); 
        Case_RelationShip dcr = new Case_RelationShip();
        Case c = populateCaseTestData();
        
        List<Id> listContentIds = new List<Id>();
        ContentVersion contVer1 = populateContentData('Identity','Utility Bill');
        insert contVer1;
        ContentVersion contVer2 = populateContentData('Consumer','Utility Bill');
        insert contVer2;
        listContentIds.add(contVer1.Id);
        listContentIds.add(contVer2.Id);
        
        if(dcr!=null){
          dcr.mapCaseToContentVersions(listContentIds,c);
        }
        Test.stopTest();
        System.debug(' End For Scenario .... two diferent catagories ');

    }
    
    @isTest
    public static void mapCaseToContentVersionsThreeDifferentFilesTest(){
        System.debug(' Start For Scenario .... three different catagories ');
        Test.StartTest(); 
        Case_RelationShip dcr = new Case_RelationShip();
        Case c = populateCaseTestData();
        List<Id> listContentIds = new List<Id>();
        ContentVersion contVer1 = populateContentData('Identity','Utility Bill');
        insert contVer1;
        ContentVersion contVer2 = populateContentData('Consumer','Utility Bill');
        insert contVer2;
        ContentVersion contVer3 = populateContentData('Estate','Utility Bill');
        insert contVer3;
        listContentIds.add(contVer1.Id);
        listContentIds.add(contVer2.Id);
        listContentIds.add(contVer3.Id);
        
        if(dcr!=null){
          dcr.mapCaseToContentVersions(listContentIds,c);
        }
        Test.stopTest();
        System.debug(' End For Scenario .... three different catagories ');
    }

}