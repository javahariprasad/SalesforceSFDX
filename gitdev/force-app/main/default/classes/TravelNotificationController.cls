public class TravelNotificationController {
    
    @AuraEnabled
    public static List<TravelNotificationDetails> getTravelNotifications(String cardNumber){
        system.debug(' in map');
       List<TravelNotificationDetails> objTravelDetailsList = new  List<TravelNotificationDetails>();
        for(Integer i= 0; i<2; i++){
            system.debug('added in list');
            TravelNotificationDetails objDetails = new  TravelNotificationDetails();       
            objDetails.cardNumber= '4306791100804423';
            if(i==0){
                objDetails.location = 'INDIA';
                objDetails.endDate = '10/15/2019';
                objDetails.startDate = '10/18/2019';
            }else{
                objDetails.location = 'FLORIDA';
                objDetails.endDate = '10/20/2019';
                objDetails.startDate = '10/25/2019';
            }
            objDetails.primaryPhone = '513 233 4567';
            objDetails.secondaryPhone = '513 233 4568';
            objDetails.primaryCardholderOnly = true;
            objDetails.includeDebitCard = false;
            objTravelDetailsList.add(objDetails);
        }
        return objTravelDetailsList;
    }
    
    
     @AuraEnabled
    public static List<TravelNotificationDetails> getTravelNotifications2(String cardNumber){
        system.debug(' in map');
        List<TravelNotificationDetails> travelMap = new List<TravelNotificationDetails>();
        TravelNotificationDetails obj = new TravelNotificationDetails();
        obj.location = 'INDIA1';
        obj.startDate = '145';
        obj.endDate = '444';
        obj.cardNumber = '145';   
        travelMap.add(obj);
        system.debug(' return map');
        
        TravelNotificationDetails obj1 = new TravelNotificationDetails();
        obj1.location = 'JAPAN1';
        obj1.startDate = '1452';
        obj1.endDate = '4442';
        obj1.cardNumber = '142225';   
        travelMap.add(obj1);
        
        return travelMap;
    }
    
    @AuraEnabled
    public static String addTravelNotification(String cardNumber){
        return null;
    }
    
    @AuraEnabled
    public static String editTravelNotification(String cardNumber,String startDate){
        return null;
    }
    
    @AuraEnabled
    public static String deleteTravelNotification(String cardNumber, String startDate){
        return null;
    }
}