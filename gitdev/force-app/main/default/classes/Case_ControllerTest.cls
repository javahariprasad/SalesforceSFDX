@isTest
public class Case_ControllerTest {
    
    public static testmethod void testgetCase(){
        case c = new case();
        insert c;
        System.debug('Id '+c.Id+'   desc '+c.Description);
        Test.startTest();
        Case_Controller.getCase();
        Test.stopTest();
        c= [Select id,Description from case];
        System.assertEquals('abcd', c.Description);
    }

}