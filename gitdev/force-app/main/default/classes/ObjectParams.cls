public class ObjectParams {
    
    @AuraEnabled @InvocableVariable
    public List<ObjectParam> listObjectParam = new List<ObjectParam>();
    
    public ObjectParams(){
         listObjectParam = new List<ObjectParam>();
    }

}