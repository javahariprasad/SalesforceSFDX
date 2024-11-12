import { LightningElement } from 'lwc';
import usericon from '@salesforce/resourceUrl/usericon';

export default class Login extends LightningElement {
    email;
    password;
    validRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    emailErrormsg;
    pwdErrormsg;
    forgotpwdURL;

    handleUserNameChange(event) {
        this.emailErrormsg = '';    
        this.email = event.target.value;
        if (!this.validateEmail(this.email)) {
            this.emailErrormsg = 'Please enter a valid email';
        } 

    }

    handlePasswordChange(event) {
        this.password = event.target.value;
        this.pwdErrormsg = '';
        if (!this.password) {
            this.pwdErrormsg = 'Please enter a Password';
        } 
    }

    handleLogin(event) {
        var bError = false;
        if (!this.validateEmail(this.email)) {
            this.emailErrormsg = 'Please enter a valid email';
            bError = true;
        } 
        if (!this.password) {
            this.pwdErrormsg = 'Please enter a Password';
            bError = true;
        } 

        if (!bError) {
            
        }

    }
    validateEmail(email) {
       return String(email).match(this.validRegex);
    }    

}