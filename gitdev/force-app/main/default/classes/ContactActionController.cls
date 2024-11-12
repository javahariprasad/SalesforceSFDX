public class ContactActionController {
	@AuraEnabled
    public static void updateCont(String recordId) {
    	System.debug(' In updateCont Record Id ');
        Account act = [SELECT Industry from Account where Id=:recordId];
        act.Industry = 'Apparel';
        //act.Industry = 'Agriculture';
        update act;
    	System.debug(' out updateCont Record Id '+act.Industry);
    }
    
}