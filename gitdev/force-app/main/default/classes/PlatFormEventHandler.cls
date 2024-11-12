public class PlatFormEventHandler {
    
    public static void firePlatFormEvent(){
        List<TDSEvent__e> listtds = new list<TDSEvent__e>();
        
        TDSEvent__e  td1 = new TDSEvent__e ();
    	td1.acctId__c = '1';
        listtds.add(td1);
        TDSEvent__e  td2 = new TDSEvent__e ();
    	td2.acctId__c = '2';
        listtds.add(td2);
        TDSEvent__e  td3 = new TDSEvent__e ();
    	td3.acctId__c = '3';
        listtds.add(td3);
        TDSEvent__e  td4 = new TDSEvent__e ();
    	td4.acctId__c = '4';
        listtds.add(td4);
        EventBus.publish(listtds);

        
    }
    
  @InvocableMethod
  public static List<Results> execute (List<Requests> requestList) {
    List<Results> results = new List<Results>();
    for (Requests request : requestList) {
     
        
      String outputMember = request.inputCollection;
      
      //Create a Results object to hold the return values
      Results result = new Results();
      
      //Add the return values to the Results object
      result.outputMember = outputMember;
      
      //Add Result to the results List at the same position as the request is in the requests List
      results.add(result);
    }
    return results;
  }

  public class Requests {
    @InvocableVariable(label='Records for Input' description='yourDescription' required=true)
    public String inputCollection;
  }

  public class Results {
    @InvocableVariable(label='Records for Output' description='yourDescription' required=true)
    public String outputMember;
  }

}