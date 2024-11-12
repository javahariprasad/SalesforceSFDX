public class ReadStatic {
    
    public static void read(){
        StaticResource sr = [SELECT ID, body FROM StaticResource WHERE Name = 'timediff2' LIMIT 1];
        String csvData = sr.body.toString();
        String[] filelines = csvData.split('\n');
        String concantenatedStr;
        Integer count=0;
        for(String s : filelines){
            if(count>0){
            List<String> line = s.split(',');
                 DateTime resultDateTime1 = DateTime.ValueofGmt(line[1].replace('T', ' ')); 
                 DateTime resultDateTime2 = DateTime.ValueofGmt(line[2].replace('T', ' '));
                // DateTime resultDateTime3 = DateTime.ValueofGmt(line[2].replace('T', ' '));
                 Long customFieldLong = resultDateTime1.getTime();
                 Long currentDTLong = resultDateTime2.getTime();
                 Long milliseconds = currentDTLong - customFieldLong;
                 Long seconds = milliseconds / 1000;
                 System.debug('seconds  *********** '+seconds);
                 concantenatedStr  = concantenatedStr+''+seconds + '\n'; //add new line
            }
            count++;
            
        }
         System.debug('Number of lines '+concantenatedStr);
        //createFile(concantenatedStr,'Timediff.csv');
       
        
    }
public static void createFile(String versionData, String title) {
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S'; //denotes it resides on Salesforce
        cv.Title = title; //title of the file
        cv.PathOnClient = title; // full path within Salesforce this can just be the name of file to be in the library
        cv.VersionData = Blob.valueOf(versionData); //file data
        insert cv;
    }
}