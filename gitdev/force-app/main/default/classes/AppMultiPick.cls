public class AppMultiPick {
   
@AuraEnabled()    
public static map<String,String> getMonitoringFrequency(string objName){

       map<String,String> mappick = new map<string,string>();
       Schema.DescribeFieldResult fieldResult = Account.Temp_ML__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
       for( Schema.PicklistEntry f : ple){
           mappick.put(f.getValue(),f.getLabel());
       }       
       return mappick;
   }
    
    @AuraEnabled
    public static Map<String,String> fetchSimpleMap(){
        try {
            Map<String,String> simpleMap = new Map<String,String>();
            simpleMap.put('fruit','apple');
            simpleMap.put('vegetable','potato');
            return simpleMap;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}