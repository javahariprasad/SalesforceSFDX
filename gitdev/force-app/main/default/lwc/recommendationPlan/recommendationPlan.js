import { LightningElement, api, wire, track } from 'lwc';

//import approveApplicationForm from "@salesforce/apex/ApproveController.approveApplicationForm";
//import loadApplicationForm from "@salesforce/apex/ApproveController.loadApplicationForm";
//import EvaluateLbl from '@salesforce/label/c.EvaluateLbl';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class RecommendationPlan extends LightningElement {

    activeSectionMessage = '';
    @api rec;
    @track inputValue;
    

    handleToggleSection(event) {
        this.activeSectionMessage =
            'Open section name:  ' + event.detail.openSections;
        console.log('record id' + this.rec);
    }

    handleSetActiveSectionC() {
        const accordion = this.template.querySelector('.example-accordion');

        accordion.activeSectionName = 'C';
    }

    
  // initialize component
    connectedCallback() {
       

      //this.inputValue = rec;
        console.log(' loaded value  ******' + this.rec);
     /*   
        loadApplicationForm({
            recordId: this.rec
          })  
          .then(data => {
              console.log('success ', data);              
          }).catch(error => {  
              console.log('error ', error);  
              
          });
*/
  }
    
    approveHandler() {
  /*
        approveApplicationForm({
            recordId: this.rec
          })  
          .then(data => {
              console.log('success approve', data); 
              this.showNotification('success', 'Successully Evaluated', 'SUCCESS');
              this.closeQuickAction();
          }).catch(error => {  
              console.log('error ', error);  
              
          });
    */
        }

    closeQuickAction() {
        const closeQA = new CustomEvent('close');
        // Dispatches the event.
        this.dispatchEvent(closeQA);
    }

    showNotification(variantOption, msg, title) {
        console.log('hello'); 
        const evt = new ShowToastEvent({
            title: title,
            message: msg,
            variant: variantOption,
        });
        this.dispatchEvent(evt);
        }
    
}