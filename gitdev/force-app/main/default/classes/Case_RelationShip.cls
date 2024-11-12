public without sharing class Case_RelationShip {
    
    Controller_Helper dch = new Controller_Helper();
    
       public void mapCaseToContentVersions(List<Id> listContentIds, Case cmpCase){
        Map<String,List<Id>> mapCategory = new Map<String,List<Id>>();
        
        Set<Id> setContnetIds = new Set<Id>();
        for(Id id:listContentIds){
           setContnetIds.add(id);
        }
        system.debug('setContnetIds are  '+setContnetIds);
        
 		if (!Schema.sObjectType.ContentVersion.isAccessible()) {
            return;
          }
            List<ContentVersion> listCont = [SELECT Id, Category__c,ContentDocumentId
                                              from ContentVersion where Id In : setContnetIds];
            
            system.debug('listCont   '+listCont.size());
            
            for(ContentVersion c:listCont){
                system.debug('Content Version  Categoery '+c.Category__c);
                if(null == mapCategory.get(c.Category__c)){
                    List<Id> listIds =new List<Id>(); 
                    listIds.add(c.Id);
                	mapCategory.put(c.Category__c,listIds);
                }else{
                    List<Id> listIds = mapCategory.get(c.Category__c);
                    listIds.add(c.Id);
                }
            }
        
        verifyForParentCase(mapCategory,cmpCase);
        
    }
    
   
    private void verifyForParentCase(Map<String,List<Id>> cMap,Case parentCase){
        insert parentCase;
        Controller_Helper helper = new Controller_Helper();
        for (String cat : cMap.keySet()){
             List<Id> listIds = cMap.get(cat);
            if(cMap.size() ==1 && listIds.size()==1){
                helper.linkToDocument(listIds.get(0), parentCase.Id);
            }else{
            	CaseToDocument(listIds,cat,parentCase);
            }
		}
        
		validateCreatedRecords(parentCase.Id);        
    }
    
    
       private void CaseToDocument(List<Id> listIds,String category,Case parentCase){
        Id  childCaseId = createChildCase(parentCase,category);
        Controller_Helper helper = new Controller_Helper();
        for(Id contentId : listIds){
        	helper.linkToDocument(contentId, childCaseId);
        }
    }
    
   
    private Id createChildCase(Case parentCase,String category){
        Case childCase =new Case();
        childCase.ParentId = parentCase.Id;
        insert childCase;
        return childCase.Id;
    }
    
    
    private void validateCreatedRecords(Id parentCaseId){
        
        System.debug('Parent Case : '+parentCaseId);
        
        List<Case> listCase = [SELECT Id , ownerId from Case where ParentId =: parentCaseId];
        
        System.debug('List of Child Cases : '+listCase.size());
        
        for(Case c : listCase){           
            
			System.debug(' Child Case Id   : '+c.Id);
            
            List<ContentDocumentLink> listCaseCDL = [SELECT  id, ContentDocumentId ,LinkedEntityId
                      					FROM ContentDocumentLink WHERE LinkedEntityId =: c.Id];
            
            
            for(ContentDocumentLink caseCDL : listCaseCDL){
            
                List<ContentDocumentLink> listCDL = [SELECT  id, ContentDocumentId ,LinkedEntityId
                                            FROM ContentDocumentLink WHERE ContentDocumentId =: caseCDL.ContentDocumentId];
                
                //System.debug(' Create CDL List '+listCDL.size());
                
               
                for(ContentDocumentLink cdl : listCDL){
                    
                    
                    
                    ContentVersion conVer = [SELECT  id, ContentDocumentId, ownerId
                                            FROM ContentVersion WHERE ContentDocumentId =: cdl.ContentDocumentId];  
                    
                    System.debug(' ContentDocument Id : '+cdl.ContentDocumentId +' and LinkedEntityId  :'+cdl.LinkedEntityId + '   Owner :'+conVer.OwnerId+'  For ContentVersion :'+ conVer.Id);
                
            	}
            }
            
        }
        
    }

}