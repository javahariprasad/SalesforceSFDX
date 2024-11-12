public class MockCaptchaController {
    
    @AuraEnabled
    public static String verifyCaptcha(String captchaResp){
        String verifyResp='';
         String url = 'https://www.google.com/recaptcha/api/siteverify';
         String secret='6LeAQJ8UAAAAAD99Hyc3P99vXyJOoD5AxfPm3vVR';
	    String USER_AGENT = 'Mozilla/5.0';
        String postParams = 'secret=' + secret + '&response='
				+ captchaResp;
        HttpResponse r = makeRequest(url,postParams);
        if(r!=null){
            verifyResp= r.getBody();
        }
      /*  if ( r!= null )
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
        }*/
        
        return verifyResp;
    }

/* Helper methods */
    private static HttpResponse makeRequest(string url, string body) 
    {
        System.debug('reCAPTCHA Body: ' + body);
        HttpResponse response = null;
        HttpRequest req = new HttpRequest(); 
        //req.setHeader('User-Agent', 'Mozilla/5.0');
        //req.setHeader('Accept-Language', 'en-US,en;q=0.5');
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
}