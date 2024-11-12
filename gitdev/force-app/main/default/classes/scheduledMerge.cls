global class scheduledMerge implements Schedulable {
   Id caseId = null;
   Id conId = null;
    
    public scheduledMerge(Id caseId, Id conId){
    this.caseId = caseId;
    this.conId = conId;
        
        
    }
    
   global void execute(SchedulableContext SC) {
       
        System.debug(' scheduledMerge executed '+caseId  + '             '+conId);      
       
        Case  c =  [Select Id from case where  Id = :caseId];
             
        ContentVersion cv = [Select Id from ContentVersion where  Id = :conId];
        
        c.OwnerId = '0051U000002FLoPQAW';
        cv.OwnerId = '0051U000002FLoPQAW';
       
        update c;
        update cv;
     System.debug(' scheduledMerge executed ');
   }
}