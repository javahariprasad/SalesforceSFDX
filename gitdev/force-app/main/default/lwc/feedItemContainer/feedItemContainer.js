import { LightningElement, track, wire,api } from 'lwc'; 
import getFeedItemList from '@salesforce/apex/FeedItemController.getFeedItemList';
import { updateRecord } from 'lightning/uiRecordApi';
import FeedItem_Body from '@salesforce/schema/FeedItem.Body';
import FeedItem_Id from '@salesforce/schema/FeedItem.Id';
import FeedItem_Status from '@salesforce/schema/FeedItem.Status';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import {refreshApex} from '@salesforce/apex';
const actions = [
    { label: 'View', name: 'View' },
];
const columns=[
    {label: 'Body', fieldName: 'Body'},  
    {label: 'Created Date', fieldName: 'CreatedDate',type: 'date',
      typeAttributes:{day:'numeric',month:'short',year:'numeric',
      hour:'2-digit',minute:'2-digit',second:'2-digit',hour12:true} },
    {  type: 'action',  typeAttributes: { rowActions: actions }, },  
    ];

export default class FeedItemContainer extends LightningElement {
    @track error;
    @track columns = columns;
    @track actions = actions;
    @track accList;
    @track isShowModal = false;
    @track isEditRecord = false;
    @track recordIdToEdit;
    @track showLoadingSpinner = false;
    draftValues = [];
    refreshTable;
    @track listRecords;
    fBody;
    fAck;
    rBody;
    rChk;
    jsonMap;
    @api loginUserId;


   /* @wire(getFeedItemList, { loginUserId: '$loginUserId' }) 
    feedItemData( { error, data } ) {
        if ( data ) {
           console.log('data is old '+data);
           this.accList = data.listRecords;

           console.log(' records kkk  '+this.accList[0].Status);
           this.accList.forEach(job =>{

           console.log('JOB Case Number for');
            
            });

        }

    }*/

    connectedCallback(){
        console.log('  login user id '+this.loginUserId);
        let uid = this.loginUserId;
        console.log(' this uid .. '+uid);

        getFeedItemList({ loginUserId: uid })
            .then(result => {
                this.accList = result.listRecords;
                this.error = undefined;
            })
		.catch(error => {
			this.error = uid+'dd';
			this.accList = undefined;
		})
	} 

    
    

    
  /*  handleChange(event) {
        console.log('Handle change invoked -> '+event.target.name);
        console.log('Handle change invoked -> '+event.target.value);
        let name = event.target.name;
        let value = event.target.value;
        if(value == '')
            value = null;
        const dataAssign = Object.assign({[name]: value});
        this.addelementsToJson(dataAssign,name);
    }*/
  

    /*
    @wire (getAccountList) accList(result)
    {   console.log(' feed data '); 
        this.refreshTable = result;
        if(result.data)
        {
            console.log(' feed data 2'); 
           
          //  this.refreshTable = accParsedData;
            this.accList = accParsedData;
        }
        else if(result.error)
        {
            this.error = result.error;
        }
    } */

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        console.log('action Name is '+row.Id);      
        switch (actionName) {
            case 'View':
                this.editRecord(row);
                break;
            default:
        }
    }

    handleRowAction1(event) {
        const data = event.currentTarget.data;        
    }

    handleTodoChange(event) {
        this.value = event.target.checked;  
        const label = event.target.label;
       
        const id = event.currentTarget.id  
        console.log('Id  => ', id);
        console.log('label  => ', label);
        console.log("Todo 1: " + event.target.checked);
        console.log("Todo 2: " + this.fBody);
        console.log("Todo 3: " + this.Id);
        
        if(label == 'Acknowledge' && event.target.checked){
            this.fAck = true;
            /*let obj1 = { body: this.fBody };
            let obj2 = { ack: this.fAck};
            let obj3 = { rep: this.rChk };
            let new_obj = Object.assign({}, obj1, obj2, obj3);
            const dataAssign = Object.assign({[this.Id]: new_obj});
            this.addelementsToJson(dataAssign,this.Id);*/
            this.prepareJson(this.fBody,this.fAck,this.rChk,this.Id);
        }else if(label == 'Reply' && event.target.checked){
            this.rChk = true;
            this.prepareJson(this.fBody,this.fAck,this.rChk,this.Id);
            /*let obj1 = { body: this.fBody };
            let obj2 = { ack: this.fAck };
            let obj3 = { rep: this.rChk };
            let new_obj = Object.assign({}, obj1, obj2, obj3);
            const dataAssign = Object.assign({[this.Id]: new_obj});
            this.addelementsToJson(dataAssign,this.Id);*/
        }else if(label == 'Acknowledge' && event.target.checked == false){
            this.fAck = false;
            this.prepareJson(this.fBody,this.fAck,this.rChk,this.Id);
            /*let obj1 = { body: this.fBody };
            let obj2 = { ack: this.fAck };
            let obj3 = { rep: this.rChk };
            let new_obj = Object.assign({}, obj1, obj2, obj3);
            const dataAssign = Object.assign({[this.Id]: new_obj});
            this.addelementsToJson(dataAssign,this.Id);*/
        }else if(label == 'Reply' && event.target.checked == false){
            this.rChk = false;
            this.prepareJson(this.fBody,this.fAck,this.rChk,this.Id);
        }


    }
    prepareJson(body,fAck,rChk,fId){
        let obj1 = { body: body};
        let obj2 = { ack: fAck };
        let obj3 = { rep: rChk };
        let new_obj = Object.assign({}, obj1, obj2, obj3);
        const dataAssign = Object.assign({[fId]: new_obj});
        this.addelementsToJson(dataAssign,fId);
    }

    editRecord(recordIdDetail) {
        this.isShowModal = true;
        this.isEditRecord = true;
        this.fBody = recordIdDetail.Body;
        this.Id= recordIdDetail.Id;

        let keyFound =false;
        for (var key in this.jsonMap) {
            console.log(' Key ' +key);
            var objJ = this.jsonMap[key];
            console.log('Value '+objJ);
            if(recordIdDetail.Id == key){
                for (var key2 in objJ) {
                    console.log(' key2 ' +key2);
                    console.log(' Value2 '+objJ[key2]);
                    if(key2 == 'ack'){
                        this.fAck = objJ[key2];
                        console.log(' this.fAck  ' +this.fAck);
                    }
                    if(key2 == 'rep'){
                        this.rChk = objJ[key2];
                        console.log(' this.rChk  ' +this.rChk);
                    }
                }
                keyFound = true;
            }
        }
        if(keyFound == false){
            this.fAck = false;
            this.rChk = false;
        }
      
    }
    addelementsToJson(dataAssign,name){
        console.log('Json map is 1'+this.jsonMap);
        this.jsonMap ={ ...this.jsonMap, ...dataAssign};
        let finalJsonMap =  JSON.stringify(this.jsonMap);
        console.log('Json map is 3'+finalJsonMap);
        

        }

    hideModalBox() { 
        this.isShowModal = false;
    }

    /*handleSubmit(event){  
        this.isShowModal = false;
        const evt = new ShowToastEvent({
            title: 'Success Message',
            message: 'Record Updated successfully ',
            variant: 'success',
            mode:'dismissible'
        });
        this.dispatchEvent(evt);
    }

    handleSuccess(event){
        return refreshApex(this.refreshTable); 
    }*/
}