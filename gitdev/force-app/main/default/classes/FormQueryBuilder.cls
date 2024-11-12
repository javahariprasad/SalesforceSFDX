public class FormQueryBuilder {
    
    static final Pattern doubleQuoteWrapped = Pattern.compile('("[^"]*")');    
    static final String cond = ' AND ';    
    String SQUOTE = '\'';
    static final String EXPLIKE = ' like ';
    static final String EXP_PAR_COMMA = '\\), '; 
    
    public String getConditionQuery(String formula){
        List<QueryObject> listQ = getQueryObject(formula);
        String strQuery = getCondition(listQ);
        return strQuery;
    }
        
    static List<String> getFieldValue(String input)
    {
        Matcher m = doubleQuoteWrapped.matcher(input);
        List<String> output = new List<String>();
        while (m.find()) {            
        	output.add(m.group());
        }
        return output;
    }
    public List<QueryObject> getQueryObject(String formula){
        
       List<String> fields = formula.split(EXP_PAR_COMMA);
       List<QueryObject> listO = new List<QueryObject>();
       if(fields.IsEmpty()){
           listO.add(setQueryObjectParams(formula));  
        }else{
            for(String row : fields){
                listO.add(setQueryObjectParams(row));               
            } 
         }        
        System.debug(' query Object is '+listO);
        
        return listO;
    }
    
    public String getCondition(List<QueryObject> listQO){
        String query = ' WHERE ';
        
        for(QueryObject objQO :listQO ){
          
            System.debug(' Operator is '+objQO.operator+ ' Type '+objQO.operatorType); 
            
            SQUOTE = 'DATETIME'.equals(objQO.operatorType) ? '' : '\'';
            
            System.debug(' SQUOTE'+SQUOTE); 
            
            switch on objQO.operator {
                
                when 'CONTAINS' { 
                   query = query + objQO.fName + EXPLIKE+SQUOTE+'%'+objQO.fValue+'%'+SQUOTE+ cond;
                }   
                when 'LEFT' {     
                    query = query + objQO.fName + EXPLIKE+ SQUOTE+ objQO.fValue +'%'+SQUOTE+ cond;
                }
                when 'RIGHT' {    
                    query = query + objQO.fName + EXPLIKE + SQUOTE+'%' +objQO.fValue+SQUOTE+ cond;
                }
                when '!=', '<=',  '>=', '>', '<', '=' {    
                    query = query + objQO.fName + objQO.operator + SQUOTE + objQO.fValue +SQUOTE+ cond;
                }
                when else {
                    query = query + objQO.fName +'='+SQUOTE+ objQO.fValue+ SQUOTE+ cond;
                }
        }
        }
        query = query.removeEnd(' AND ');
        
        return query;
    }
    
    public String getFieldName(String fieldString){
        Pattern mPattern = pattern.compile('(?<!")[$!{]{1,2}[A-z_.]*[}]{0,}');
        Matcher mMatcher = mPattern.matcher(fieldString);
         while (mMatcher.find()) {
            String fieldName = mMatcher.group(0);
            List<String> splitedValue = fieldName.replace('$', '').replace('{!', '').replace('}', '').split('[.]', 2); 
            return(splitedValue[1]);
        }
        return null;
    }
    
    public string getOperator(String operatedString){
        
        if(operatedString.contains('CONTAINS(')){
            return  'CONTAINS';
        }
        if(operatedString.contains('LEFT(')){
            return  'LEFT';
        }
        else if(operatedString.contains('RIGHT(')){
            return  'RIGHT';
        }
        else if(operatedString.contains('!=')){
            return  '!=';
        }
        else if(operatedString.contains('<=')){
            return  '<=';
        }
        else if(operatedString.contains('>=')){
            return  '>=';
        }
        else if(operatedString.contains('>')){
            return  '>';
        }
        else if(operatedString.contains('<')){
            return  '<';
        }
        return '=';
    }
    
    public QueryObject setQueryObjectParams(String formula){
            QueryObject objQO = new QueryObject(); 
            objQO.operator 	 = getOperator(formula);
            objQO.fName  = getFieldName(formula);
            objQO.fValue = getFieldValue(formula).get(0).replace('"','');
            if(formula.contains('DATETIME(') || formula.contains('DATE(')){
               objQO.operatorType = 'DATETIME'; 
            }
        return objQO;
        
    }

}