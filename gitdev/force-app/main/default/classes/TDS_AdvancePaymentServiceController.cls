global class TDS_AdvancePaymentServiceController {
    
    @AuraEnabled
    global static AdvancePaymentResponse postAdvancePayment(String orderId) {
        
       
    UserAppInfo userAppInfo = [SELECT Id, AppDefinitionId FROM UserAppInfo WHERE UserId = :UserInfo.getUserId() LIMIT 1];
    AppDefinition appDefinition = [SELECT Id, DurableId, Label FROM AppDefinition Where DurableId = :userAppInfo.AppDefinitionId LIMIT 1];
    system.debug(appDefinition.Label+' '+appDefinition.DurableId);

        
        /* Order objOrder = [SELECT Id, vlocity_cmt_AccountRecordTypec, Advanced_Payment_Amountc, vlocity_cmtDefaultBillingAccountIdc, vlocity_cmtDefaultServiceAccountId_c, 
vlocity_cmt__DefaultBillingAccountId__r.Id, vlocity_cmt_DefaultServiceAccountIdr.Address_UUID_c, vlocity_cmt__DefaultServiceAccountId__r.Id,
vlocity_cmt__DefaultBillingAccountId__r.Name, vlocity_cmt__DefaultServiceAccountId__r.Name, vlocity_cmt__DefaultBillingAccountId__r.TDS_Printed_Billing_Name_c,
vlocity_cmt__DefaultServiceAccountId__r.ShippingAddress, vlocity_cmtDefaultServiceAccountId_r.ShippingStreet, vlocity_cmtDefaultServiceAccountId_r.ShippingCity, 
vlocity_cmt__DefaultServiceAccountId__r.ShippingState, vlocity_cmt__DefaultServiceAccountId__r.ShippingPostalcode, vlocity_cmtDefaultServiceAccountId_r.ShippingCountry,
vlocity_cmt__DefaultBillingAccountId__r.BillingAddress, vlocity_cmt__DefaultBillingAccountId__r.BillingStreet, vlocity_cmt__DefaultBillingAccountId__r.BillingCity, 
vlocity_cmt__DefaultBillingAccountId__r.BillingState, vlocity_cmt__DefaultBillingAccountId__r.BillingPostalcode, vlocity_cmt__DefaultBillingAccountId__r.BillingCountry
FROM Order
WHERE Id=: orderId];*/
        
        AdvancePaymentRequest apr = populateRequestParams();
        String requestBody = JSON.serialize(apr, false);
        System.debug(' Request Body is '+requestBody);
        
        HTTP http = new HTTP();
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('callout:');
        req.setMethod('POST');
        req.setBody(requestBody);
        req.setTimeout(120000);
        
        HTTPResponse response = http.send(req);
        System.debug('responsecode..!'+response.getStatusCode());
        System.debug('body..!'+response.getBody());
        
        AdvancePaymentResponse apResponse = new AdvancePaymentResponse();
        apResponse.billing_id = '44544';
        if(response.getStatusCode() == 200){
            apResponse= (AdvancePaymentResponse)JSON.deserialize(response.getBody(),AdvancePaymentResponse.class);
        }else{
            system.debug('Error raised');
        }
        
        return apResponse;
        
    }
    
    global  class AdvancePaymentRequest {
        
        Public string crm_order_id;
        Public String user_id;
        Public String crm_account_type;
        Public Double adv_pmt_quoted_amt;
        Public List<CRM_Account> crm_accounts = new List<CRM_Account>();
    }
    
    global class CRM_Account{
        Public String crm_account_type;
        Public String crm_id;
        Public String crm_parent_id;
        Public String registry_uuid;
        Public String address_registry_uuid;
        Public String account_name;
        Public String printed_billing_name;
        Public String street_address;
        Public String city;
        Public String state;
        Public String postal_code;
    }
    
    
    global class AdvancepaymentResponse
    {
        
        @AuraEnabled global Boolean isError;
        @AuraEnabled global String billing_id;
        @AuraEnabled global String errMsg;       
        
    }
    /*
    public AdvancePaymentRequest populateRequestParams(Order objOrder){
        AdvancePaymentRequest apr = new AdvancePaymentRequest();
        apr.crm_order_id = objOrder.Id;
        apr.crm_account_type = objOrder.vlocity_cmt_AccountRecordType_c;
        //apr.adv_pmt_quoted_amt = objOrder.Advanced_Payment_Amount__c;
        List<CRM_Account> crm_accounts = new List<CRM_Account>();
        
        if(objOrder.vlocity_cmtDefaultServiceAccountId_c=null){
        CRM_Account crmAccount = new CRM_Account();
        crmAccount.crm_account_type = 'SERVICE';            
        crmAccount.crm_id = objOrder.vlocity_cmt__DefaultServiceAccountId__r.Id;
        //crmAccount.crm_parent_id = objOrder.
        //crmAccount.registry_uuid  = objOrder.vlocity_cmt_DefaultServiceAccountIdr.Address_UUID_c
        crmAccount.address_registry_uuid  = objOrder.vlocity_cmt_DefaultServiceAccountIdr.Address_UUID_c;
        crmAccount.account_name  = objOrder.vlocity_cmt__DefaultServiceAccountId__r.Name;
        crmAccount.street_address  = objOrder.vlocity_cmtDefaultServiceAccountId_r.ShippingStreet;
        crmAccount.city  = objOrder.vlocity_cmt__DefaultServiceAccountId__r.BillingCity;
        crmAccount.state  = objOrder.vlocity_cmt__DefaultServiceAccountId__r.BillingState;
        crmAccount.postal_code = objOrder.vlocity_cmt__DefaultServiceAccountId__r.ShippingPostalcode;
        
        }else if(objOrder.vlocity_cmt__DefaultBillingAccountId__r=null){  
        CRM_Account crmAccount = new CRM_Account();
        crmAccount.crm_account_type = 'SERVICE';            
        crmAccount.crm_id = objOrder.vlocity_cmt__DefaultBillingAccountId__r.Id;
        //crmAccount.crm_parent_id = objOrder.
        //crmAccount.registry_uuid  = objOrder.vlocity_cmt__DefaultBillingAccountId__r.Address_UUID_c;
        crmAccount.account_name  = objOrder.vlocity_cmt__DefaultBillingAccountId__r.Name;
        crmAccount.printed_billing_name  = objOrder.
        crmAccount.street_address  = objOrder.vlocity_cmt__DefaultBillingAccountId__r.BillingStreet;
        crmAccount.city  = objOrder.vlocity_cmt__DefaultBillingAccountId__r.BillingCity;
        crmAccount.state  = objOrder.vlocity_cmt__DefaultBillingAccountId__r.BillingState;
        crmAccount.postal_code = objOrder.vlocity_cmt__DefaultBillingAccountId__r.BillingPostalcode;
        }
        return apr;
        }
    */
    
    public static AdvancePaymentRequest populateRequestParams(){
        AdvancePaymentRequest apr = new AdvancePaymentRequest();
        apr.crm_order_id = 'objOrder.Id';
        apr.crm_account_type = 'objOrder.vlocity_cmt_AccountRecordType_c';
        apr.adv_pmt_quoted_amt = 200;
        List<CRM_Account> crm_accounts = apr.crm_accounts;
        String acct= 'acd';
        if(acct!=null){
            CRM_Account crmAccount = new CRM_Account();
            crmAccount.crm_account_type = 'SERVICE';            
            crmAccount.crm_id = 'objOrder.vlocity_cmt__DefaultServiceAccountId__r.Id';
            //crmAccount.crm_parent_id = objOrder.
            crmAccount.registry_uuid  = 'objOrder.vlocity_cmt_DefaultServiceAccountIdr.Address_UUID_c';
            crmAccount.address_registry_uuid  = 'objOrder.vlocity_cmt_DefaultServiceAccountIdr.Address_UUID_c';
            crmAccount.account_name  = 'objOrder.vlocity_cmt__DefaultServiceAccountId__r.Name';
            crmAccount.street_address  = 'objOrder.vlocity_cmtDefaultServiceAccountId_r.ShippingStreet';
            crmAccount.city  = 'objOrder.vlocity_cmt__DefaultServiceAccountId__r.BillingCity';
            crmAccount.state  = 'objOrder.vlocity_cmt__DefaultServiceAccountId__r.BillingState';
            crmAccount.postal_code = 'objOrder.vlocity_cmt__DefaultServiceAccountId__r.ShippingPostalcode';
            crm_accounts.add(crmAccount);
            
        }else if(acct!=null){  
            CRM_Account crmAccount = new CRM_Account();
            crmAccount.crm_account_type = 'BILLING';            
            crmAccount.crm_id = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.Id';
            //crmAccount.crm_parent_id = objOrder.
            crmAccount.registry_uuid  = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.Address_UUID_c';
            crmAccount.account_name  = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.Name';
            crmAccount.printed_billing_name  = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.TDS_Printed_Billing_Name_c';
            crmAccount.street_address  = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.ShippingStreet';
            crmAccount.city  = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.BillingCity';
            crmAccount.state  = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.BillingState';
            crmAccount.postal_code = 'objOrder.vlocity_cmt__DefaultBillingAccountId__r.ShippingPostalcode';
            crm_accounts.add(crmAccount);
        }
        //apr.crm_accounts = crm_accounts;
        return apr;
    }
}