global class SampleEmailService2 implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        String responseBody= email.htmlBody;
         Account acct = new Account();
        system.debug('response body '+responseBody);
        if(responseBody.indexOf('Requestor:')!=-1){ // outside table -Account
            String ss = responseBody.substringBetween('Requestor:', '</');
        }
        
        Pattern myPattern = Pattern.compile('Test apex(.*?)Sdasd');
        Matcher m = myPattern.matcher(responseBody);
        System.debug('matcher '+m.matches());
        //Set<String> tableHeader = new Set<String>{'Factory','Order#','Department','Description','Email'};            
        List<Contact> listContact= new List<Contact>();
        boolean header = true;
        
        
        while(m.find())
        {
            System.debug(' group ... '+m.group());
            String row = m.group();
            Contact c= new Contact();
           
			string result = row.replaceAll('<br/>', '\n');
			result = result.replaceAll('<br />', '\n');
            String mrow= result;
            Matcher match =  Pattern.compile('<.*?>').matcher(result);
            while(match.find()){
                String s=    match.group();
                if(s != '</td>'){   
                    mrow= mrow.replace(s,' '); 
                }
            }
            populateContact(mrow.split('</td>'),c,acct);
            if(!header){
                listContact.add(c);
            }
            header = false;
        }
        system.debug(' Contacts '+listContact);
        // insert acct;
        //saveEmailBody(acct,email.subject,email.htmlBody,acct);
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        return result;
    }
    
    public void populateContact(List<String> cols ,Contact c,Account acct){
        System.debug('cols   '+cols);
       // acct.Department = cols[0];
        //acct.Department = cols[1];
        c.Department = cols[2];
        c.Description = cols[3];
        c.Email = cols[4];        
    }
    
    public void saveEmailBody(Account acctId, String sub, String body){
        Attachment attachment = new Attachment();
        attachment.ParentId = acctId.Id;
        attachment.Name = sub;
        attachment.Body = Blob.valueOf(body);
        insert attachment;
        
    }
    
}