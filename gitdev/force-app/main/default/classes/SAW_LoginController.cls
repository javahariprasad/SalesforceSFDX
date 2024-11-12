public without sharing class SAW_LoginController {
    
    @AuraEnabled
    public static String login(String username, String password, String startURL){
        
        System.debug(' Network login URL '+NetWork.getLoginUrl(NetWork.getNetworkId()));
        
        system.debug(' user Name '+username+' wd '+password);
        
        startUrl = 'https://haritcs-dev-ed.my.salesforce.com/home/home.jsp?sdtd=1';
        
        //String sstartUrl = System.currentPageReference().getParameters().get('startURL');
        //System.debug('sstartUrl   '+sstartUrl);
        PageReference p = Site.login(username, password, startUrl);
        System.debug(' p '+p);
        
        return p.getUrl();
        
        //PageReference p = Site.login(username,password,startURL);        
        //return 'ss';
        
    }

}