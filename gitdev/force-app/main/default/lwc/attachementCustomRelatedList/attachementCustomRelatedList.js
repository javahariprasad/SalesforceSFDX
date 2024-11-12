import { LightningElement, api, wire, track } from 'lwc'
import fetchRecords from '@salesforce/apex/CustomRelatedListController.fetchFiles';
//import fetchRecords2 from '@salesforce/apex/CustomRelatedListController.fetchRecords2';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import NAME_FIELD from "@salesforce/schema/Case.ContactId";

export default class AttachmentCustomRelatedList extends NavigationMixin(LightningElement) {
    objectName = 'Case';
    @api recordId;
    @api strTitle;
    @track listRecords;
    @track titleWithCount;
    @track countBool = true;
    
    recordTypeId;

    connectedCallback() {
       console.log(' record id in related List '+this.recordId);    
    }
 
    
  
    @wire(fetchRecords, { recordId: '$recordId' }) 
    accountData( { error, data } ) {
        if ( data ) {
           console.log('data is old '+data);
           this.listRecords = data.listRecords;
          //let dataParse;
          //this.listRecords = [...data].map(record => ({...record})).forEach(record => record.docURL = record.ContentDocumentId);
           //this.listRecords = [...data].map(record => ({...record})).forEach(record => record.docURL = '/'+record.ContentDocumentId);
            
           //console.log(' records kkk  '+this.listRecords[0].ContentDocument.Title);
           this.listRecords.forEach(job =>{
            console.log('JOB Case Number for '+job.ContentDocument.Title);
            //dataParse = Object.assign({},  job);
            //dataParse.docURL = '/'+job.ContentDocumentId; 
            //this.listRecords.push(dataParse);         
            });
            
            this.recordTypeId = data.recordTypeId;

            if ( data.recordCount ) {
               
                if ( data.recordCount > 3 ) {

                    this.titleWithCount = this.strTitle + '(3+)';
                    this.countBool = true;
               
                } else {

                    this.countBool = true;
                    this.titleWithCount = this.strTitle + '(' + data.recordCount + ')';

                }
            }

        }

    }

    createNew() {
     console.log('to br ***')
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: this.objectName,
                actionName: 'new'
            },
            state: {
               recordTypeId: this.recordTypeId
            }
        });
    }

    navigateToRelatedList() {
       
        /*
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: "Account",
                relationshipApiName: 'Cases',
                actionName: 'view'
            }
        });*/
        console.log(' redirected to tab view rec ew attachement '+this.recordId);
        this[NavigationMixin.Navigate]({
            type: "standard__navItemPage",
            attributes: {
                apiName: "Attachments",
                recId: this.recordId
            },
            state: {
                c__rId: this.recordId                
            }
        });

    }

    handleClick(event){
        const recordId = event.target.dataset.oppid;
        console.log(' recordId  '+recordId);
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                "recordId":recordId,
                "objectApiName":"Case",
                "actionName": "view"
            }
        });
    }
    get name() {
        return getFieldValue(this.account.data, NAME_FIELD);
      }

}