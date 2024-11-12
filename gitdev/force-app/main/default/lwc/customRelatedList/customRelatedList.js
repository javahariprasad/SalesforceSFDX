import { LightningElement, api, wire, track } from 'lwc'
import fetchRecords from '@salesforce/apex/CustomRelatedListController.fetchRecords';
//import fetchRecords2 from '@salesforce/apex/CustomRelatedListController.fetchRecords2';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import NAME_FIELD from "@salesforce/schema/Case.ContactId";

export default class CustomRelatedList extends NavigationMixin(LightningElement) {
    objectName = 'Case';
    @api recordId;
    @api strTitle;
    @track listRecords;
    @track titleWithCount;
    @track countBool = false;
    recordTypeId;

    @track contentVersionIds =[];
    @track contentVersionIdsDelete=[];
    caseId;
    @track filesUploaded = [];

    connectedCallback() {
       console.log(' record id in related List '+this.recordId);    
    }
 
    
  
    @wire(fetchRecords, { recordId: '$recordId' }) 
    accountData( { error, data } ) {
        if ( data ) {
           console.log('data is old '+data);
           this.listRecords = data.listRecords;
           console.log(' records kkk  '+this.listRecords[0].CaseNumber);
           this.listRecords.forEach(job =>{
            console.log('JOB Case Number for '+job.CaseNumber);
            
            });
            
            this.recordTypeId = data.recordTypeId;

            if ( data.recordCount ) {
               
                if ( data.recordCount > 3 ) {

                    this.titleWithCount = this.strTitle + '(3+)';
                    this.countBool = true;
               
                } else {

                    this.countBool = false;
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
        console.log(' redirected to tab view rec ew  '+this.recordId);
        this[NavigationMixin.Navigate]({
            type: "standard__navItemPage",
            attributes: {
                apiName: "Job_History",
                recId: this.recordId
            },
            state: {
                c__rId: this.recordId                
            }
        });

    }

    get acceptedFormats() {
        return ['.pdf', '.png','.doc','.docx','.jpg','.jpeg','.txt','.xls','.xlsx','.mp4','.msg'];
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

      handleUploadFinished(event) {
        console.log(' handleUploadFinished  not finished');
        if (event.detail.files.length>0){
           // this.isReqFileUpload = false;
        }
    const uploadedFiles = event.detail.files;
    //console.log('uploadedFiles---'+JSON.stringify(uploadedFiles));
    uploadedFiles.map(res=>{
    this.filesUploaded.push({name:res.name ,contentVersionId:res.contentVersionId});
    this.contentVersionIds.push(res.contentVersionId);
    });
    }

}