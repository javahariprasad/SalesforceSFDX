trigger ShareAndDeleteFiles on ContentDocumentLink (before insert) {
    
     If(trigger.IsInsert && trigger.IsBefore){
        System.debug('Calling Share files Method'+ trigger.new);
         for(ContentDocumentLink cdl : trigger.new){
             if(cdl.Visibility == 'allusers') {
             //cdl.ShareType = 'C';
             }
         }
       
    }

}