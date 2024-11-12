public class ApexExample1 {    
  
    private String prop1 {get;set;}
    
    public ApexExample1(String prop1){
        this.prop1= prop1;
        System.debug(' this.prop1   222 '+this.prop1);
    }
    
    public ApexExample1(){}
    
    
    public void getObjectValue(SObject sobj, String type){
        if(type =='c'){
            Case c =(Case)sobj;
            system.debug(' Case Id '+c.Id);
            
        }else{
            Account a =(Account)sobj;  
            system.debug(' account  Id '+a.Id);
        }
        
        
    }
    
    public void generalMethod(String cId){
        
        
        
        List<Account> acc= [select id from account where name = 'abc898d'];
        
        //list<string> statuss =new list<string>{'New','Closed'};
         list<string> sfield =new list<string>();
        sfield.add('New');
        
        //List<>Account> 
        list<case> cases = [select id from case where Id =: cId and status in :sfield];
        
        for(case c : cases){
            
        }
        for(case c: [select id from case where Id =: cId and status in :sfield]){
        
        
        }
        
        
        insert acc;
        
        Database.insert(acc);
        
        system.debug( 'casess '+cases.size());
        
        
       // getObjectValue(acc, 'a');
       // getObjectValue(c, 'c');
        
    }
    
    
    public void getObjectValue2(Account sobj){ }
    
    
    public static void expList(){
        
       /* List<String> listS = new List<String>();
        listS.add('1'); - > //0 pos
        listS.add('2'); - > //1 pos
            
            Set<String> sets - new Set<String>();
        setS.add('1');
        sets.add('2');
        Map<Id,list<SObject>> mapForContact = new Map<Id,List<SObject>>();
        List<Case> cases = mapForContact.get('011'); */
        
        List<Case> cases = [select id, caseNumber from Case];
        System.debug(' Cases   '+cases);
        List<Case> listCase = new List<Case>();
        Set<Id> acctSet= new Set<Id>();
        for(Case c : cases){ // 10
            acctSet.add(c.AccountId);
            //Account acc = [Select id from Account where id = c.AccountId];
            
            Case uCase = new Case(id=c.Id,Subject='abcd');
            //istCase.add(uCase); 
            //update  uCase;
        }
        List<Account> acc = [Select id from Account where id in: acctSet];
       // Account acc = [Select id from Account where id = 'assss'];
                              
        //update listCase; 
        
        Map<Id,Case> mapCases = new Map<Id,Case>([select id, caseNumber from Case]);
        System.debug(' mapCases   '+mapCases); 
        
        
        
        
        
        
        
            
    }
    
    
   
        public static void sendEmail()
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setTargetObjectId(UserInfo.getUserId()); 
            //Change with Template ID
            mail.setTemplateId('00XKi000000LxwbMAC'); 
            
            //Record ID for which letter will be generated
            mail.setWhatId('500Ki0000032qjEIAQ'); 
            String[] toaddresses = new String[] {'user1@example.com'}; 
             mail.setToAddresses(toAddresses);
            mail.setBccSender(false); 
            mail.setUseSignature(false); 
            mail.setSenderDisplayName('Card Division'); 
            mail.setSaveAsActivity(false); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            
            /*
             * Messaging.SingleEmailMessage mymail = new Messaging.SingleEmailMessage();
String[] toaddresses = new String[] {'user1@example.com'}; 
String[] ccaddresses = new String[] {'user2@example.com'};
String[] bccaddresses = new String[] {'user3@example.com’};

mymail.setToAddresses(toAddresses);
mymail.setCcAddresses(ccAddresses);
mymail.setBccAddresses(bccAddresses);*/
        }

    
}