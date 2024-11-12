public with sharing class ReCaptcha_Controller {
    
    public static string vfPageURL{get; set;}
    public static string ltPageURL{get; set;}
    public static string siteKey{get; set;}
    
    public static String pg;
    
    public ReCaptcha_Controller(){
        siteKey = '6LeXk58UAAAAAMXlmJOhlJC-nPB7QTSpXkqEFpTI';
        
    }
    
    
   @AuraEnabled
    public static String getVFPageDomainFromLgtComp(){
       
        //String insName = [select InstanceName from Organization limit 1].InstanceName; 
        //insName = insName.toLowerCase();
        
        ltPageURL = 'hello';
        
        //vfPageURL=all;
        return vfPageURL.toLowerCase();
        
    }
    
    public PageReference getDomainURL()
    {        
        String urlInstance=URL.getSalesforceBaseUrl().toExternalForm();
        String remove = urlInstance.substring(urlInstance.indexOf('--c'),urlInstance.length());
        ltPageURL = urlInstance.removeEndIgnoreCase(remove)+'.lightning.force.com';
        
        return null;
    }
    
   
    

}