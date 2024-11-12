import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Rating';

export default class multiSelectPicklistDemo extends LightningElement {

    picklistValues;
    error;
    @wire(getPicklistValues, { 
        recordTypeId: '0121U000000bFSVQA2', fieldApiName: INDUSTRY_FIELD 
    })
    wiredPicklist({ error, data }){
        
        if(data){
            this.picklistValues = data.values;
            console.log(' data ', data.values);
            this.error = undefined;
        }
        if(error){
            this.picklistValues = undefined;
            this.error = error;
        }
    }

    handleValueChange(event){
        console.log(JSON.stringify(event.detail));
    }
}