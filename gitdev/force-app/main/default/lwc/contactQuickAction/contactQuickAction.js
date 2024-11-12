import { LightningElement, api, wire } from 'lwc';
import updateCont from '@salesforce/apex/ContactActionController.updateCont';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { CloseActionScreenEvent } from 'lightning/actions';
export default class ContactQuickAction extends LightningElement {
    @api recordId;
    updateRecordView(recordId) {
        updateRecord({fields: { Id: recordId }});
    }
    
   @api invoke() {
        console.log("recordId for Notiy ", this.recordId);
        updateCont({ recordId: this.recordId })
            .then((result) => {
                getRecordNotifyChange([{recordId: this.recordId}]);
                console.log(" updateRecordView recordId", this.recordId);
            })
            .catch((error) => {
                this.error = error;
                this.contacts = undefined;
            });
   }
   closeQuickAction() {
    this.dispatchEvent(new CloseActionScreenEvent());
   }
   
    connectedCallback() {
        console.log('connected===============');
        console.log(this.recordId + ' is null');
    }

    renderedCallback() {
        console.log('rendered------------');
        console.log(this.recordId + ' is provided');
    }

      
}