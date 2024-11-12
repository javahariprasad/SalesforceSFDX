import { LightningElement, wire, api , track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';
//import { refreshApex } from '@salesforce/apex';
//import getJobHistories from "@salesforce/apex/CustomRelatedListController.getAttachments";
import getAttachments2 from "@salesforce/apex/CustomRelatedListController.getAttachments2";
import searchJobHistory from "@salesforce/apex/CustomRelatedListController.searchJobHistory";
import deleteAttachments from "@salesforce/apex/CustomRelatedListController.deleteAttachments";
import { IsConsoleNavigation, getFocusedTabInfo,setTabLabel} from 'lightning/platformWorkspaceApi';
const ACTIONS = [{label: 'View', name: 'View'},{label: 'Download', name: 'Download'}]
const COLS = [{label: 'Name', fieldName: 'link', type: 'url', typeAttributes: {label: {fieldName: 'FullName'}}},
{ label: 'Last Modified By', fieldName: 'LastModBy',typeAttributes: {label: {fieldName: 'LastModBy'}} },
{label: 'Last Modified Date', fieldName: 'Datetimefield',type: 'date',
 typeAttributes:{day:'numeric',month:'short',year:'numeric', hour:'2-digit',minute:'2-digit',second:'2-digit',hour12:true}},
{label: '', type: 'action', initialWidth:'50px', 
        typeAttributes: { rowActions: ACTIONS }
    }  
]
export default class AttachmentCustomListView extends NavigationMixin(LightningElement) {
    cols =COLS;
    jobHistoriesData;
    wiredJobHistories;
    selectedJobHistories;
    baseData;
    @api recId;
    @api recordId;
    @api rId;

    @track openModal = false;
    showModal() {
        this.openModal = true;
    }
    closeModal() {
        //this.fetchRecs();
        this.openModal = false;
       

    }
    get acceptedFormats() {
        return ['.pdf', '.png'];
    }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        this.fetchRecs();
        //refreshApex(this.wiredJobHistories);
        //alert('No. of files uploaded : ' + uploadedFiles.length);
        this.openModal = false;
    }

    fetchRecs(){
        console.log('helo');
        getAttachments2({recordId : this.recordId}).then(result => {
            this.wiredJobHistories = result;
            console.log('helo 22');
            if(result){
                this.jobHistoriesData = result.map((row) => {
                    return this.mapContacts(row);
                })
                this.baseData = this.jobHistoriesData;
            }
            if(result.error){
                console.error(result.error);
            }
        })
    }

    @wire(CurrentPageReference)
    getPageReferenceParameters(currentPageReference) {
       if (currentPageReference) {
          console.log('111'+currentPageReference);
          this.recordId = currentPageReference.attributes.recId || null;
          let attributes = currentPageReference.attributes;
          let states = currentPageReference.state;
          let type = currentPageReference.type;
          console.log(' this.recordId ' +this.recordId );
          this.rId = currentPageReference.state?.c__rId;
          if(this.recordId == null){
            this.recordId =  this.rId;
          }
          console.log(' 111 currentPageReference state  ss  ' +this.rId );
       }
    }

    connectedCallback() {
        this.fetchRecs();
     }

    /*@wire(getJobHistories,{ recordId: '$recordId' })
    JobHistoriessWire(result){
        console.log(' record id in List view 4 '+this.recordId); 
        this.wiredJobHistories = result;
        if(result.data){
            this.jobHistoriesData = result.data.map((row) => {
                return this.mapContacts(row);
            })
            this.baseData = this.jobHistoriesData;
        }
        if(result.error){
            console.error(result.error);
        }
    }*/

    mapContacts(row){
        var accountName = '';
        var accountLink = '';
        
        console.log(' added name');
        return {...row,
            FullName: `${row.ContentDocument.Title}`,
            link: `/${row.ContentDocumentId}`,
            LastModBy:`${row.ContentDocument.CreatedBy.Name}`,
            Datetimefield:`${row.ContentDocument.LastModifiedDate}`,
            //accountLink: accountLink,
            //AccountName: accountName
        };
    }

    handleRowSelection(event){
        this.selectedJobHistories = event.detail.selectedRows;
    }

    /*async handleSearch(event){
        if(event.target.value == ""){
            this.contacts = this.baseData
        }else if(event.target.value.length > 1){
            const searchContacts = await searchJobHistory({searchString: event.target.value})

            this.contacts = searchContacts.map(row => {
                return this.mapContacts(row);
            })
        }
    }
    */

   

    navigateToNewRecordPage() {

       /* this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            }
        });
        */
       this.showModal();
    }

    handleRowAction(event) {
        console.log('selected document id 22'+event.detail.row.ContentDocumentId);
        deleteAttachments({contactIds : [event.detail.row.ContentDocumentId]}).then(() => {
            //refreshApex(this.wiredJobHistories);
        })

        const actionName = event.detail.action.name;
        console.log('action name is '+actionName);
        const row = event.detail.row;
        switch (actionName) {
            case 'View':
                this[NavigationMixin.Navigate]({
                    type: 'standard__recordPage',
                    attributes: {
                        recordId: row.ContentDocumentId,
                        actionName: 'view'
                    }
                });
                break;
            case 'Download':
                let filesDownloadUrl = '/sfc/servlet.shepherd/version/download/'+row.ContentDocument.LatestPublishedVersionId;
                this[NavigationMixin.Navigate]({
                    type: 'standard__webPage',
                    attributes: {
                        url: filesDownloadUrl
                    }
                },false);
                break;
            default:
        }
    }

    get selectedJHLen() {
        if(this.selectedJobHistories == undefined) return 0;
        return this.selectedJobHistories.length
    }

    deleteSelectedJobHistories(){
        const idList = this.selectedJobHistories.map( row => { return row.ContentDocumentId })
        deleteAttachments({docIds : idList}).then(result => {
            console.log(' delete attached invoked 2');
            this.fetchRecs();
            //refreshApex(this.wiredJobHistories);
        })
        this.template.querySelector('lightning-datatable').selectedRows = [];
        this.selectedJobHistories = undefined;
    }

    downloadSelectedJobHistories(){
        let filesDownloadUrl = '/sfc/servlet.shepherd/version/download';
        this.selectedJobHistories.map( row => { 
            filesDownloadUrl += '/' + row.ContentDocument.LatestPublishedVersionId
        })
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: filesDownloadUrl
            }
        },false);
        
       
    }
}