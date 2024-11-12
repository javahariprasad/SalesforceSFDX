public class  Captcha
{
public boolean checkCurrentValue{get;set;
}
public String challenge{get;set;
}
public String response{get;set;
}
public String publicKey {get;set;
}
private static String privateKey = '6LeAQJ8UAAAAAD99Hyc3P99vXyJOoD5AxfPm3vVR';// change this key to the key
// which we you have  generated after click on server side integration which is “secret”
    private static String baseUrl = 'https://www.google.com/recaptcha/api/challenge';
    public String myName { get; set; }
    public String myEmail { get; set; }
    public Boolean verified { get; private set; }
    public Captcha()
    {
     
        publicKey = '6LeAQJ8UAAAAALRb4veFmfIwmonYsMBYwQPwlvs-';
        System.debug('publicKey  '+publickey);
// we can get this key when we click on client site integration with
 //“data-sitekey=”6LcqayMUAAAAAO3g81Dlwb6jjLmahE0gurJyy7zv”
        this.verified = false; 
        checkCurrentValue=false;
  		challenge = ApexPages.currentPage().getParameters().get('recaptcha_challenge_field');
  		response =  ApexPages.currentPage().getParameters().get('recaptcha_response_field');
    }
    public PageReference verify()
    {
        System.debug('reCAPTCHA verification attempt');
        // On first page load, form is empty, so no request to make yet
        if ( challenge == null || response == null )
        {
            System.debug('reCAPTCHA verification attempt with empty form');
            return null;
        }
        System.debug('Response : ' + privateKey + '&remoteip='  + remoteHost + '&challenge=' + challenge + '&response='  + response);
        HttpResponse r = makeRequest(baseUrl,'privatekey=' + privateKey + '&remoteip='  + remoteHost + '&challenge=' + challenge + '&response='  + response);
        if ( r!= null )
        {
            this.verified = (r.getBody().startsWithIgnoreCase('true'));
        }
        if(this.verified)
        {
            // If they pass verification, you might do something interesting here
            // Or simply return a PageReference to the “next” page
            return null;
        }
        else
        {
            // stay on page to re-try reCAPTCHA
            return null;
        }
    }
    public PageReference reset()
    {
        return null;
    }  
    /* Helper methods */
    private static HttpResponse makeRequest(string url, string body) 
    {
        System.debug('reCAPTCHA Body: ' + body);
        HttpResponse response = null;
        HttpRequest req = new HttpRequest();  
        req.setEndpoint(url); req.setMethod('POST'); req.setBody (body);
        try
        {
            Http http = new Http();
            response = http.send(req);
            System.debug('reCAPTCHA response: ' + response);
            System.debug('reCAPTCHA body: ' + response.getBody());
        }
        catch(System.Exception e)
        {
            System.debug('ERROR: ' + e);
        }
        return response;
    }
    //
    private String remoteHost
    {
        get {
            String ret = 'haritcs-dev-ed--c.visualforce.com';
            // also could use x-original-remote-host
            Map<String, String> hdrs = ApexPages.currentPage().getHeaders();
            if (hdrs.get('x-original-remote-addr')!= null)
                ret =  hdrs.get('x-original-remote-addr');
            else if (hdrs.get('X-Salesforce-SIP')!= null)
                ret =  hdrs.get('X-Salesforce-SIP');
            return ret;
        }
    } 
}