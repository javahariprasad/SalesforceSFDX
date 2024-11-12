public class LACPD_OdysseyDataNotification {
    
    public static void getOdysseyData(){
        Integer iOdyDataCrtCount =0;
        Integer iOdyDataUpdCount =0;
        Map<String,CountWrapper> countWrapper = new Map<String,CountWrapper>();
        countOfOdyPrcessData('Case',countWrapper);
        sendNootification(countWrapper);
    }
    
    public static void countOfOdyPrcessData(String objectName,Map<String,CountWrapper> countWrapper){
        List<SObject> listSobject = new List<SObject>();
        DateTime  todaysDt =  Date.today()-1;
        DateTime  todayeDt =  Date.today()-1;
        todayeDt = todayeDt.addHours(23);
        todayeDt= todayeDt.addMinutes(59);
        todayeDt= todayeDt.addSeconds(59);
        List <sObject> slist = Database.query('SELECT Id , CreatedDate,LastModifiedDate  FROM '+ objectName+' WHERE CreatedDate >= :todaysDt OR (LastModifiedDate >=:todaysDt AND LastModifiedDate <=:todayeDt)' );
        CountWrapper cWrap = new CountWrapper();
        for(sObject sObj : slist){
            DateTime cDate = (DateTime)sObj.get('CreatedDate');
            DateTime mDate = (DateTime)sObj.get('LastModifiedDate');
            if(cDate == mDate){
                cWrap.iCreateCnt++;     
            }else if(cDate < mDate){
                cWrap.iUpdCnt++;
                cWrap.iCreateCnt++;
            }
        }
        countWrapper.put(objectName,cWrap);
    }
    
    public class CountWrapper{
        public Integer iCreateCnt = 0;
        public Integer iUpdCnt = 0 ;        
    }
    
    public static void sendNootification(Map<String,CountWrapper> countWrapper){
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {'javahariprasad@gmail.com'});
        email.setSubject('Odyssey Prcess Data Count - '+system.today().format()); 
        string htmlbody = 'Following Cases are not Processed in the last 10 minutes of their Creation.<br/><br/>';
        htmlbody = htmlbody + '<table border="1">';
        for(String s : countWrapper.keySet()){
            CountWrapper cWrap  = countWrapper.get(s);
            htmlbody += '<tr><td>'+s+': </td><td></td></tr>';           
            htmlbody += '<tr><td> Created Count: </td><td>'+cWrap.iCreateCnt+'</td></tr>';
            htmlbody += '<tr><td> Updated Count: </td><td>'+cWrap.iUpdCnt+'</td></tr>';
        }
        htmlbody += '</table>';
        email.setHtmlBody(htmlbody);
        List<Messaging.SendEmailResult> listResukt = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
        system.debug('   listResukt   ->'+listResukt);
    }
    
}