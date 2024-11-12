import { LightningElement } from 'lwc';

import login from "@salesforce/apex/SAW_LoginController.login";
//import communityURL from "@salesforce/label/c.SAW_Community_Url";
export default class Login extends LightningElement {
    //allegis_logo = resourceName + "/img/allegis_logo.png";
    email;
    password;
    validRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    emailErrormsg;
    pwdErrormsg;
    loginErrorMsg = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaa  dccdd dddv                      ad]]]]]]]]]]] asddd';
    forgotpwdURL= 'https://sawconnect-allegishrmatters.cs41.force.com/SafeatWorkCommunity/s/cforgotpassword';
    communityURL= 'https://sawconnect-allegishrmatters.cs41.force.com/SafeatWorkCommunity/s';
   
    handleUserNameChange(event) {
        this.emailErrormsg = '';    
        this.email = event.target.value;
        if (!this.email) {
            this.emailErrormsg = 'please enter Username';
        } 

    }

    handlePasswordChange(event) {
        this.password = event.target.value;
        this.pwdErrormsg = '';
        if (!this.password) {
            this.pwdErrormsg = 'Please enter a Password';
        } 
    }

   
    doLogin(event) {
        this.loginErrorMsg = '';
        var bError = false;
        if (!this.email) {
            this.emailErrormsg = 'Please enter a valid username';
            bError = true;
        } 
        if (!this.password) {
            this.pwdErrormsg = 'Please enter a Password';
            bError = true;
        } 
        console.log('  bError ****' + bError);

        if (!bError) {          
        
        login({        
            username: this.email,
            password: this.password,
            startUrl: this.communityURL 
          })
          .then((data) => {
            console.log("Success-->", data);
            this.navigateToHomePage(data);
          })
          .catch((error) => {
            console.log("Error-->" + JSON.stringify(error.body.message));            
            var msg = JSON.stringify(error.body.message);              
              this.loginErrorMsg = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  dccdd dddv                      ad]]]]]]]]]]] asddd';
          });
      }
    }

    navigateToHomePage(strURL) {
        const domainURL = strURL.split('?')[0];
        console.log('domainURL'+domainURL);
        const url = new URL(strURL);
        const params = new URLSearchParams(url.search);
        const sid = params.get('sid');
        console.log('sid'+sid);
        //var retURL = domainURL;
        //retURL = retURL.replace('secur/frontdoor.jsp', 'employeeportal/s/');
        var retURL ='https://sawconnect-allegishrmatters.cs41.force.com/SafeatWorkCommunity/s';
        var finalURL =  domainURL+'?sid=' + sid + '&retURL='+retURL;
        console.log('finalURL'+finalURL);
        /*const config = {
                type: 'standard__webPage',
                attributes: {
                    url: finalURL
            }
            };
       this[NavigationMixin.Navigate](config, true);*/
            
        window.location.replace(finalURL);
    }

}