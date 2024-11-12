public class XMLToJson {
    public static String rootElementName;
    public void convert(){
        StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'xmlconverter' LIMIT 1];
        String body = sr.Body.toString();
        Dom.Document doc = new Dom.Document();
        doc.load(body);
        Dom.XMLNode root = doc.getRootElement();
        String data = formatJson(parse(root, false));
        
        System.debug('JSON_DATA is '+data);
        APIDataWrapper wrapper = APIDataWrapper.parse(data);
        System.debug('wrapper is '+wrapper);
        populateCaseInfo(wrapper);
        
    }
    
    public void populateCaseInfo(APIDataWrapper wrapper){
        System.debug('  Case Number '+wrapper.CaseInformation.CaseNumber);        
    }
    
    public String formatJson(String data){
        data = data.replace('"CaseFlags": {', '"CaseFlagsSingle":{');
        data = data.replace('"CaseCrossReferences": {', '"CaseCrossReferencesSingle":{');
        data = data.replace('"Parties": {', '"PartiesSingle":{');
        data = data.replace('"CaseParties": {', '"CasePartiesSingle": {');
        data = data.replace('"Charges": {', '"ChargesSingle":{');
        data = data.replace('"CaseEvents": {', '"CaseEventsSingle":{');
        data = data.replace('"Hearings": {', '"HearingsSingle":{');
        data = data.replace('"Pleas": {', '"PleasSingle":{');
        data = data.replace('"BondSettings": {', '"BondSettingsSingle":{');
        data = data.replace('"StatisticalClosures": {', '"StatisticalClosuresSingle":{');
        data = data.replace('"Dispositions": {', '"DispositionsSingle":{');
        data = data.replace('"SentenceEvents": {', '"SentenceEventsSingle":{');
        data = data.replace('"Settings": {', '"SettingsSingle":{');
        data = data.replace('"SettingResources": {', '"SettingResourcesSingle":{');
        data = data.replace('"ChargeStages": {', '"ChargeStagesSingle":{');
        data = data.replace('"Vehicles": {', '"VehiclesSingle":{');
        data = data.replace('"PresentParties": {', '"PresentPartiesSingle":{').replace('"Date"','"DateF"');
        data = data.replace('"CaseFlags": {', '"CaseFlagsSingle": {');
        data = data.replace('"Parties": {', '"PartiesSingle": {');
        data = data.replace('"AKAs": {', '"AKAsSingle": {');
        
        return data;
    }
    
     public static String parse(Dom.XMLNode node, Boolean isChild){
        String json = '';
        Boolean isArray = false;
        if ( rootElementName == null ) {
            rootElementName = node.getName();
        }
        if ( node.getNodeType() == Dom.XmlNodeType.ELEMENT ){
            Map<String, List<String>> MapOfJSON = new Map<String, List<String>>();
            List<String> listOfJSON = new List<String>();
            List<Dom.XMLNode> json_CHILDREN = node.getChildElements();
            if ( json_CHILDREN.size() > 0 ){
                for ( Dom.XMLNode child : json_CHILDREN ){
                    String tmp = parse( child, true );
                    if( tmp != '' ) {
                        if ( !MapOfJSON.containsKey( child.getName() ) ){
                            MapOfJSON.put( child.getName(), new List<String>() );
                        }
                        MapOfJSON.get( child.getName() ).add( tmp );  
                    }
                }
                for ( String key : MapOfJSON.keySet() ){
                    if ( MapOfJSON.get(key).size() > 1 ){
                        if(isChild) {
                            listOfJSON.add( '[' + String.join(MapOfJSON.get(key), ', ') + ']' );  
                        }
                        else {
                            listOfJSON.add( '"' + key + '": [' + String.join(MapOfJSON.get(key), ', ') + ']' );   
                        }
                        isArray = true;
                    }
                    else {  
                        listOfJSON.add( '"' + key + '": ' + MapOfJSON.get(key)[0] );  
                    }
                }
            }
            List<String> last_Value = new List<String>( listOfJSON );
            for ( Integer i=0; i<node.getAttributeCount(); i++){
                String key = node.getAttributeKeyAt( i );
                String value = node.getAttribute( key, '' );
                last_Value.add( '"' + key + '": "' + value + '"' );   
            }
            String textContent = node.getText();
            if ( textContent != null && textContent.trim() != '' ) {
                textContent = textContent.replace( '"', '\\"' );
                last_Value.add( '"ele_text": "' + textContent + '"' );   
            }
            if ( !isChild ){ 
                if(!isArray) {
                    json = '"' + node.getName() + '": {' + String.join(last_Value, ', ') + '}';   
                }
                else {
                    json = ' {' + String.join(last_Value, ', ') + '}';
                }
            }
            else {
                if ( last_Value.size() == 1 && textContent != null && textContent.trim() != '' ){    
                    json = '"' + textContent + '"';  
                }
                else {
                    if(!isArray) { 
                        if( last_Value.size() > 0 ){  
                            json = '{' + String.join(last_Value, ', ') + '}';   
                        } 
                    }
                    else {
                        json = String.join(last_Value, ', '); 
                    }
                }
            }
        }
        if ( rootElementName == node.getName() ) {
            if(!isArray) { 
                json = '{' + json + '}';    
            }
            else {
                json = '{"' + node.getName() + '" : ' + json + '}';   
            } 
        }
        return json;
    }
}