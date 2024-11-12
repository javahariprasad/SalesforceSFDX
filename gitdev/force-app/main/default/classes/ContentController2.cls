public class ContentController2{
    public Transient blob file { get; set; }
    public String fileName{ get;set;}
    public String contentType{ get;set;}

    public PageReference upload() {
        /*ContentVersion v = new ContentVersion();
        v.versionData = file;
        v.title = 'testing upload';
        v.pathOnClient ='/somepath.txt';
        insert v;
        return new PageReference('/' + v.id);
        */
        System.debug('Upload action'+file.size());
    ContentVersion contentVersion =new ContentVersion(); 
        
    contentVersion.Title =fileName; 
    contentVersion.VersionData=file;
    contentVersion.PathOnClient='/' + fileName;
    //contentVersion.IsMajorVersion = false;
    insert contentVersion; 
    system.debug('testContentInsert.id '+ contentVersion.id);  
        return null;
    }
}