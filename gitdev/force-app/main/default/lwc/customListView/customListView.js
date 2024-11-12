import { LightningElement, wire, api  } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { CurrentPageReference } from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import getJobHistories from "@salesforce/apex/CustomRelatedListController.getJobHistories";
import searchJobHistory from "@salesforce/apex/CustomRelatedListController.searchJobHistory";
import deleteJobHistories from "@salesforce/apex/CustomRelatedListController.deleteJobHistories";
import {
    IsConsoleNavigation,
    getFocusedTabInfo,
    setTabLabel
} from 'lightning/platformWorkspaceApi';
const ACTIONS = [{label: 'Delete', name: 'delete'}]
const COLS = [{label: 'Name', fieldName: 'link', type: 'url', typeAttributes: {label: {fieldName: 'FullName'}}}
]
export default class CustomListView extends NavigationMixin(LightningElement) {
    cols =COLS;
    jobHistoriesData;
    wiredJobHistories;
    selectedJobHistories;
    baseData;
    @api recId;
    @api recordId;
    @api rId;

    @wire(IsConsoleNavigation) isConsoleNavigation;

    async setTabLabel() {
       /* if (!this.isConsoleNavigation) {
            return;
        }*/
        var tabinfo = await getFocusedTabInfo();+
        console.log(' json sring fy is '+JSON.stringify(tabinfo));
        var {isSubtab} = tabinfo;

        console.log('   get json value '+this.findValueByKey(tabinfo,'apiName'));
        if(!isSubtab) {

            var {subtabs} =  tabinfo;

            console.log(' subtabs json sring fy is '+JSON.stringify(subtabs));

          
            const { pageReference } =subtabs[0];
            const { tabId } =subtabs[0];
            console.log(' pageReference json sring fy is '+JSON.stringify(pageReference));

            var {attributes} = pageReference;
            var {apiName} = attributes;
            console.log(' attributes name is ... '+apiName);
        
        }

       
       
     
         
        if(apiName == 'Job_History') 
            setTabLabel(tabId, 'oooo');
    }

    findValueByKey(obj, key) {
        for (const prop in obj) {
          if (prop === key) {
            return obj[prop];
          } else if (typeof obj[prop] === "object") {
            const result = this.findValueByKey(obj[prop], key);
            if (result !== undefined) {
              return result;
            }
          }
        }
        return undefined;
      }

    @wire(CurrentPageReference)
    getPageReferenceParameters(currentPageReference) {
       if (currentPageReference) {
          console.log(currentPageReference);
          this.recordId = currentPageReference.attributes.recId || null;
          let attributes = currentPageReference.attributes;
          let states = currentPageReference.state;
          let type = currentPageReference.type;
          console.log(' this.recordId ' +this.recordId );
          this.rId = currentPageReference.state?.c__rId;
          console.log(' currentPageReference state  ss  ' +this.rId );
       }
    }

    connectedCallback() {
        this.setTabLabel();
     }

    @wire(getJobHistories,{ recordId: '$recordId' })
    JobHistoriessWire(result){
        console.log(' record id in List view 2 '+this.recordId); 
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
    }

    mapContacts(row){
        var accountName = '';
        var accountLink = '';
        
       
        return {...row,
            FullName: `${row.FirstName} ${row.LastName}`,
            link: `/${row.Id}`,
            accountLink: accountLink,
            AccountName: accountName
        };
    }

    handleRowSelection(event){
        this.selectedJobHistories = event.detail.selectedRows;
    }

    async handleSearch(event){
        if(event.target.value == ""){
            this.contacts = this.baseData
        }else if(event.target.value.length > 1){
            const searchContacts = await searchJobHistory({searchString: event.target.value})

            this.contacts = searchContacts.map(row => {
                return this.mapContacts(row);
            })
        }
    }

    navigateToNewRecordPage() {

        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'new'
            }
        });
    }

    handleRowAction(event) {
        deleteJobHistories({contactIds : [event.detail.row.Id]}).then(() => {
            refreshApex(this.wiredJobHistories);
        })
    }

    get selectedJHLen() {
        if(this.selectedJobHistories == undefined) return 0;
        return this.selectedJobHistories.length
    }

    deleteSelectedJobHistories(){
        const idList = this.selectedJobHistories.map( row => { return row.Id })
        deleteJobHistories({contactIds : idList}).then( () => {
            refreshApex(this.wiredJobHistories);
        })
        this.template.querySelector('lightning-datatable').selectedRows = [];
        this.selectedJobHistories = undefined;
    }
}