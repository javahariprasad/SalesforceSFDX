public class SearchAndReplace implements Database.Batchable<sObject>{

   public final String Query;
   public final String Entity;
   public final String Field;
   public final String Value;

   public SearchAndReplace(){

      
   }

   public Database.QueryLocator start(Database.BatchableContext bc){
       System.debug(' Batch is started');
       
      return Database.getQueryLocator([select id from Case]);
   }

   public void execute(Database.BatchableContext bc, List<sObject> scope){
       
       System.debug(' scope size '+scope.size());
    
    }

   public void finish(Database.BatchableContext bc){
       
       System.debug(' Batch is finised');
   }
}