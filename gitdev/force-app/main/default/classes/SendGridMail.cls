public class SendGridMail {
    
    public void sendNotify(){
       
       SendGrid sendgrid = new SendGrid('javahariprasad@gmail.com', 'AakashAakash@2023');

        SendGrid.email email = new SendGrid.Email();
        email.addTo('javahariprasad@gmail.com');
        email.setFrom('prasad027@hotmail.com');
        email.setSubject('Subject goes here');
        email.setText('Hello World!');
        
     	sendgrid.send(email);
        
    }

}