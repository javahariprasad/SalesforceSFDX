public without sharing class Case_Controller {
    
    public static String caseStr;
    
    public static Id createCase(){
        Case c = new Case();
        c.Subject= 'sample case';
        c.Status = 'New';
        c.Origin  = 'Web';
        c.OwnerId ='0051U000002FLoPQAW';
        
        try{
        insert c;
        
        }catch(Exception e){
            system.debug('Error  '+e);
        }
        system.debug(' Case Id  '+c.Id);
        
        return c.Id;
    }
    @AuraEnabled
    public static String AuraCaseMethod(String s, Decimal successPercentage,String seq){
        Id caseId = createCase();
        createContentAndDocumentLink(caseId);
        return caseId;        
    }
    
    @AuraEnabled
    public static String saveTheFile(String fileName, String base64Data) {
        system.debug(' hello save the File          '+System.currentTimeMillis());
        long start = System.currentTimeMillis();
        Id caseId = createCase();
        insertContent( fileName,  base64Data,caseId);
        long total = System.currentTimeMillis()-start;
        system.debug(' Total time in mils   :'+total);
        return String.valueOf(caseId);
    }
    
     @AuraEnabled
    public static String saveTheFileArray(String fileName, String[] base64Data) {
        system.debug(' hello save the File          '+System.currentTimeMillis());
        long start = System.currentTimeMillis();
        String str;
        for(String s:base64Data ){
           Id caseId = createCase();
           str = str+String.valueOf(caseId)+',';
           insertContent( fileName, s,caseId);  
        }       
        long total = System.currentTimeMillis()-start;
        system.debug(' Total time in mils   :'+total);
        return str;
    }
    
    @future
    
    
    
    public static void insertContent(String fileName, String base64Data, Id caseId){        
        ContentVersion  c = new ContentVersion();
        c.versionData = EncodingUtil.base64Decode(base64Data);
        c.Title = fileName;
        c.PathOnClient = '/'+ fileName;
        c.IsMajorVersion = false;
        try{
        insert c;
        }catch(Exception e){
            system.debug('Error  '+e);
        }
        
        
        createContentDocLink(c.Id,caseId);
    }
    
    public static Id createContent(){
        ContentVersion  c = new ContentVersion();
        c.versionData = EncodingUtil.base64Decode('hello');
        c.Title = 'hello';
        c.PathOnClient = '/'+ 'hello';
        c.IsMajorVersion = false;
        c.ContentLocation ='E';
        c.ExternalDatasourceId = '0XC1U00000003DrWAI';
            c.ExternalDocumentInfo1  = 'https://www.google.com';
            c.SharingOption ='R';
        c.SharingPrivacy = 'N';
        c.Origin = 'H';

        //ContentVersion  c = new ContentVersion();
        c.versionData = EncodingUtil.base64Decode('hello');
        c.Title = 'hello';
        c.PathOnClient = '/'+ 'hello';
        c.IsMajorVersion = false;
        try{
        insert c;
        }catch(Exception e){
            system.debug('Error  '+e);
        }
        system.debug(' createContent Id  '+c.Id);
        return c.Id;
        
        
    }
    @future
    public static void createContentAndDocumentLink(Id caseId){
        Id conId = createContent();
        createContentDocLink(conId,caseId);        
    }
    
    
    public static void createContentDocLink(Id conId, Id caseId){
        
        ContentVersion cId = [select Id, OwnerId, ContentDocumentId from ContentVersion where Id = :conId] ;
        
       system.debug(' Previous Owner Id  '+cId.OwnerId);
        
       
               
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.LinkedEntityId = caseId;
        cdl.ContentDocumentId = cId.ContentDocumentId;
        cdl.ShareType = 'V';
        cdl.Visibility = 'AllUsers';
        try{
        insert cdl;
            system.debug(' createContentDocLink Id  '+cdl.Id+'     Document Id '+cId.ContentDocumentId);
        }catch(Exception e){
            system.debug('Error  '+e);
        }
        
        cId.OwnerId ='0051U000002FLoPQAW';
        try{
            
        update cId;
        
        }catch (Exception  e){
            system.debug('Error  '+e);
        }
        
        List<ContentDocumentLink>  listcdl = [SELECT LinkedEntityId, ContentDocumentId from ContentDocumentLink where ContentDocumentId =:cId.ContentDocumentId];
        for(ContentDocumentLink cdl2 :listcdl ){
            system.debug('Linkinedd E tity '+cdl2.LinkedEntityId);
        }
        
        system.debug(' current Owner Id  '+cId.OwnerId);
        
        
        //ContentVersion c2d = [select Id ,OwnerId from ContentVersion where Id = :conId] ;
        
        
        
        system.debug('return '+caseId  + '    '+ conId );
    }
    
    
    
    public static String changeOwner(){
         //...5001U000008t72MQAQ    0681U000002lSM3QAM
             
        Case  c =  [Select Id from case where  Id = '5001U000008t72MQAQ'];
        ContentVersion cv = [Select Id from ContentVersion where  Id = '0681U000002lSM3QAM'];
        
        c.OwnerId = '0051U000002FLoPQAW';
        cv.OwnerId = '0051U000002FLoPQAW';
        update c;
        update cv;
        
        return c.Id +'  '+cv.Id;
        
    }
    
    public static void callScheduled(Id caseId , Id conId){
        scheduledMerge m = new scheduledMerge(caseId,conId);
        String sch = '0 5 * * * ?';
        String jobID = system.schedule('Merge Job', sch, m);
        
    }
    
  @AuraEnabled  
  public static String append(String s, Decimal successPercentage,String seq) {
       system.debug('1 append  Aura Enabled method   '+seq); 
        append2(s,successPercentage, seq);
        system.debug(' 22 append  Aura Enabled method   '+seq);
        return caseStr;
  }
    
    
  public static void append2(String s, Decimal successPercentage,String seq) {
      
        system.debug('Entry number *************** '+seq);
      /*//
        Long startingTime = System.now().getTime(); // Num milliseconds since Jan 1 1970
        Integer delayInMilliseconds = 100; // One-second delay
        while (System.now().getTime() - startingTime < delayInMilliseconds)  {
            // Do nothing until desired delay has passed
        }
        Case c = new Case();
        c.Subject= 'sample case';
        c.Status = 'New';
        c.Origin  = 'Web';
        //c.OwnerId ='0051U000002FLoPQAW';
        
        try{
        insert c;
        
        }catch(Exception e){
            system.debug('Error  '+e);
        }
      
       caseStr =c.Id+' Seq'+seq;
       system.debug(' Case Id  '+c.Id+ ' Sequence is ...'+seq);
      */
      system.debug('waittime ');
      /*if(Math.random() > successPercentage) {
      return '' + 1/0;
    } else {
      return s + 'a';
    }*/
    // System.debug(c.Id + ' Seq' +seq);
      
  }
//https://salesforce.stackexchange.com/questions/132689/instantiate-a-new-sobject-record-in-lightning-controller
	@Future
    public static void getCase(){
        Case c= [select Id, Description from case LIMIT 1];
        System.debug('Case Id '+c.Id);
        c.Description = 'abcd';
        update c;
 		c= [select Id, Description from case LIMIT 1];    
        System.debug(' Description c '+c.Description);
    }
    /*
     * Author: Sandeep 
     * Description : used to assign prior owner and profile name.
	 */
    public static void assginTDSOwnerAndProfile(Map<Id,Case> newMap, Map<Id,Case> oldMap){
        Boolean hasPermission = FeatureManagement.checkPermission('CanPerformSomeOperation');
        for(Case c : newMap.values()){
            Case oldCase  = oldMap.get(c.Id);
            if(c.OwnerId!=oldCase.OwnerId){
                //tdsOwner = oldCase.OwnerId;
                //tdsProfile = oldCase.Owner.Profile.Name;
            }
        }
    }
    
    
     public static void validateLeadStatus(Case leadObj,Case oldLead){
        
        if(leadObj.status == 'Working' || leadObj.status == 'def'){
            Case LeadObject = new Case(); // This takes all available fields from the required object. 
            Schema.SObjectType objType = LeadObject.getSObjectType(); 
            Map<String, Schema.SObjectField> M = Schema.SObjectType.Lead.fields.getMap();
            for (String str : M.keyset()) { 
                try { 
                    System.debug('Field name: '+str +'. New value: ' + leadObj.get(str) +'. Old value: '+oldLead.get(str)); 
                    if(
                        leadObj.get(str) != oldLead.get(str)){ 
                            system.debug('******The value has changed!!!! '); // here goes more code 
                        } 
                } catch (Exception e) { 
                    System.debug('Error: ' + e); 
                } 
            }
            
        }
    }
}