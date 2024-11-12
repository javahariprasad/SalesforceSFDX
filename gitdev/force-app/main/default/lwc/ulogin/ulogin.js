import { LightningElement } from 'lwc';

export default class Ulogin extends LightningElement {
    email;
    validRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
   
    handleUserNameChange(event) {

        this.email = event.target.value;
        const validateEmail = (email) => {
            return String(email)
                .toLowerCase()
                .match(
                    /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
                );
        };

        console.log(' validateEmail    ' + validateEmail);    
    }

    handlePasswordChange(event) {
        
        this.password = event.target.value;
    }

   

}