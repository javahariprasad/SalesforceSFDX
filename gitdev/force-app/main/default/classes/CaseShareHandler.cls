public class CaseShareHandler {
    @InvocableMethod(label='Case Share' description='' category='Case')
    public static void shareCaseRecord(List<CaseShareInformation> caseInfo) {
        CaseShareInformation shareInformation = caseInfo.get(0);
        CaseShare newShare = new CaseShare(); 
        newShare.CaseId = shareInformation.caseId;
        newShare.UserOrGroupId = shareInformation.userId;
        newShare.CaseAccessLevel = shareInformation.caseAccessLevel;
        newShare.RowCause = 'Owner';
        insert newShare;
        
    }
    public class CaseShareInformation {
        @InvocableVariable
        public String caseId;
        @InvocableVariable
        public String userId;
        @InvocableVariable
        Public String caseAccessLevel;
        
    }  
    
     /*public List<String> GetBrandNames2(String Color){        
        Map<String,List<String>> mapOfBrandAndColors2 = new Map<String,List<String>>{
                'volksWagen' => new List<String>{'blue','white','black','grey'},
                 'mBenz'=>    new List<String>{'blue','black','silver','white'},
                 'honda' =>   new List<String>{'grey','black','silver','white'} 
            }; 
         return mapOfBrandAndColors2.containsKey(Color);
    }*/
    
}