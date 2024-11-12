@RestResource(urlMapping='/myserviceendpoint/*')
global with sharing class MyRestService  {

    @HttpGet
    global static void doGet() {
        String result = '';
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringAfter( '/myserviceendpoint/' );
        List<Account> accs = [Select Id , Name from Account where Id = :accountId LIMIT 1];
        if( accs.size() > 0 ) {
            Account acc = accs[0];
            Map<String,String> resultMap = new Map<String,String> {
                'accountId' => acc.Id,
                'accountStatus' => acc.Name
            };

            result = JSON.serialize( resultMap );
        } else {
            result = 'Account with ID ' + accountId + ' not found!';
        }

        RestContext.response.addHeader('Content-Type','application/json');
        RestContext.response.responseBody = Blob.valueOf(result);
    }

    @HttpPost
    global static void doPost() {
        // Add your logic here if you want implement POST method.
    }    
}