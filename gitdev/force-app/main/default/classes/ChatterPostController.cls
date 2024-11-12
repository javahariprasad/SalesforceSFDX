public class ChatterPostController {
    
    public String detail { get; set;}
  
    public String message { get; set; }
    
    public String redurl { get; set; }
    

    // indicator that the post is successful
    public Boolean posted {get; set;}
    //public void ChatterPostController() {    }

    public ChatterPostController() {
        // get this value from a Custom Setting
        redurl = 'https://haritcs-dev-ed.lightning.force.com/lightning/page/chatter';

        posted=false;
    }

    public PageReference doPost() {
        
        posted=true;
        return null;  // refresh the page
    }

}