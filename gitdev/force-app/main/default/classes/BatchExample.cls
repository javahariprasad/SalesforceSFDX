global class BatchExample implements Database.Batchable<SObject>, System.Schedulable{
     global BatchExample() {

    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator([select id , CaseNumber from case where lastmodifiedDate = Last_N_Days:5]); // 100
        
    }
    global void execute(Database.BatchableContext BC, List<Case> scope) {
        
        for(Case c :scope){
            System.debug(' c number '+c.CaseNumber);
        }
        InvokeFuture();
    }
    global void finish(Database.BatchableContext BC) {
        
        System.debug(' Finish method executed ');

    }
    
    global void execute(System.SchedulableContext sc) {
        
        
        BatchExample be = new BatchExample();
         database.executebatch(be);
        
    }
    
    @future
    public static void InvokeFuture(){
        System.debug(' this is Sync ');
        if(!System.isBatch())
          InvokeFuture2();
    }
    
    
    @future
    public static void InvokeFuture2(){
        System.debug(' this is Sync ');
        
    }

}