public class ViewHideCpController {
    
    @AuraEnabled
    public static List<String> getPicklistValues(){
       List<String> optionlist = new List<String>(); 
        optionlist.add('Education');
        optionlist.add('Sports');
       //List<Account> picklistValues = [SELECT Category__c from Account where Category__c !=null];
        
        return optionlist;
          
    }


   
}