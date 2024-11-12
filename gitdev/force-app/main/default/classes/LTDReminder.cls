public class LTDReminder {
    
    @InvocableMethod(label='LTDReminder' description='LTD Reminder after 90 days')
    public static List<LTDReminderResponse> sendLTDReminder(List<LTDReminderRequest> request) {
        List<LTDReminderResponse> responseList = new List<LTDReminderResponse>();
        if(!request.isEmpty()){
            responseList= sendEmail(request);
        }
        return responseList;
    }
    
    public static List<LTDReminderResponse> sendEmail(List<LTDReminderRequest> requests){
        
        EmailTemplate eTemplate = [Select Id from EmailTemplate where Name = 'SampleEmailTemplate'];
        Map<Id,LTDReminderRequest> mapOfCases = new  Map<Id,LTDReminderRequest>();
        for(LTDReminderRequest lr : requests ){
            mapOfCases.put(lr.caseId, lr);
        }
        System.debug('mapOfCases ss   '+mapOfCases);
        /*Map<Id,User> userMap = new Map<Id,User>([SELECT Id, IsActive, Email FROM User WHERE IsActive = true]);
        Map<Id,Id> mapOfQueue = new Map<Id,Id>();
        Map<Id, Set<String>> caseEmails = new Map<Id, Set<String>>(); 
        
        for(Task t : [Select Id , whatId, OwnerId   from Task where whatId in: mapOfCases.keySet()]){
            if(String.valueOf(t.OwnerId).StartsWith('005')){
                User u = userMap.get(t.OwnerId);
                caseEmails.put(t.whatId, new Set<String>{u.Email});
            }
            else if(String.valueOf(t.OwnerId).StartsWith('00G')){
                mapOfQueue.put(t.OwnerId,t.WhatId);  
            }
        }
        
        System.debug('mapOfQueue ss   '+mapOfQueue);
        Map<Id,Group> maingroupMap = new Map<Id,Group>([SELECT Id, DeveloperName, DoesIncludeBosses, Type, RelatedId, (SELECT UserOrGroupId FROM GroupMembers) FROM Group]);
        Map<Id,Group> groupMap = new Map<Id,Group>([SELECT Id, DeveloperName, Type, RelatedId, (SELECT UserOrGroupId FROM GroupMembers) FROM Group where Id in: mapOfQueue.keySet() ]);
        for (Group g : groupMap.values()) {
            caseEmails.put(mapOfQueue.get(g.Id),getGroupUsers(g, maingroupMap, userMap));
        } */
        //System.debug('caseEmails ss   '+caseEmails);
        
        List<LTDReminderResponse> responses = new List<LTDReminderResponse>();
        List<Messaging.Email> listOfEmails = new List<Messaging.SingleEmailMessage>();
        for(LTDReminderRequest req : requests){
            LTDReminderResponse response = new LTDReminderResponse();
            response.bResponse =true;
            List<String> listAddress = new List<String>();
            
            /*if(String.isNotBlank(req.contactEmail)){
            	listAddress.add(req.contactEmail);
            }
            
            if(String.isNotBlank(req.supervisorEmail)){
            	listAddress.add(req.supervisorEmail);
            }*/
            listAddress.add('javahariprasad@gmail.com');
            Messaging.SingleEmailMessage mail = Messaging.renderStoredEmailTemplate(eTemplate.Id,null, req.caseId);
            //mail.setToAddresses(new List<String>('javahariprasad@gmail.com'));
            mail.setSaveAsActivity(false);
            mail.setSenderDisplayName('Admin');            
            responses.add(response);
            
            listOfEmails.add(mail);
            
           /* System.debug(' listAddress    :'+listAddress);
            for(String s : listAddress){
                System.debug(' Emails '+s);
            }*/
        }
        
        if(!listOfEmails.isEmpty()){
            Messaging.sendEmail(listOfEmails);
        }
        
        return responses;
    }
    
    
    public class LTDReminderRequest {
        @InvocableVariable
        public Id caseId;
        
        @InvocableVariable
        public String contactEmail;
        
        @InvocableVariable
        public String supervisorEmail;
    }
    
    public class LTDReminderResponse {
        @InvocableVariable
        public Boolean bResponse;
    }
    
    
    public static Set<String> getGroupUsers(Group g, Map<Id,Group> groupMap, Map<Id,User> userMap) {
        Set<String> usersForThisGroup = new Set<String>();
        for (GroupMember gm : g.GroupMembers) {
            String sobjectType = gm.UserOrGroupId.getSObjectType().getDescribe().getName();
            if (sobjectType == 'User') {
                User u = userMap.get(gm.UserOrGroupId);
                if (u != null) {
                    usersForThisGroup.add(u.Email);
                }
            } else {
                //recurse down the group tree
                Group gp =groupmap.get(gm.UserOrGroupId);
                if(gp !=null){
                	usersForThisGroup.addAll(getGroupUsers(gp, groupMap, userMap));
                }
            }
        }
        return usersForThisGroup;
    }
    
    public static void findUsers(){
        Id qId = '00G6A000000vVDqUAM';
        Map<Id,User> userMap = new Map<Id,User>([SELECT Id, IsActive,UserRoleId, Email FROM User WHERE IsActive = true]);
        Map<Id,Group> maingroupMap = new Map<Id,Group>([SELECT Id, DeveloperName, DoesIncludeBosses, Type, RelatedId, (SELECT UserOrGroupId FROM GroupMembers) FROM Group]);
        Map<Id,Group> groupMap = new Map<Id,Group>([SELECT Id, DeveloperName, Type, RelatedId, (SELECT UserOrGroupId FROM GroupMembers) FROM Group where Id =:qId ]);
        for (Group g : groupMap.values()) {
            System.debug('USers   '+getGroupUsers(g, maingroupMap, userMap));
        }
    }
}