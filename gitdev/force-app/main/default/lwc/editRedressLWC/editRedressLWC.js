import { LightningElement,api ,wire,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import getRedressRecord from  '@salesforce/apex/EditRedressController.getRedressRecord';
//import getTransXForFaceRefNumber from  '@salesforce/apex/EditRedressController.getTransXForFaceRefNumber';
//import updateRedress from  '@salesforce/apex/EditRedressController.updateRedress';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
//import REDNESS_OBJECT from '@salesforce/schema/Redress__c';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
//import CURRENCY_FIELD from '@salesforce/schema/Redress__c.Redress_Face_Fee_Receive_Currency__c';
//import REDRESS_TYPE_FIELD from '@salesforce/schema/Redress__c.Type_of_Redress_Required__c';
import { NavigationMixin } from 'lightning/navigation';
//import customCSS from '@salesforce/resourceUrl/ResourceToastMsgML';
import { loadStyle } from 'lightning/platformResourceLoader';
import { CloseActionScreeEvent } from 'lightning/actions';
export default class EditRedressLWC extends NavigationMixin(LightningElement) {

    @api recordId;

    //param - used to freeze screen while invoking apex methods
    redressRec;    
    
    //param for holding modified values - used to send apex method
    jsonMap;

    //param - used to freeze screen while invoking apex methods
    isLoading = false;

    //params for dropdown options
    currencyOptions = [{ value: null, label: '--None--',selected : true}];
    redressTypeyOptions = [{ value: null, label: '--None--', selected : true}];
    
    //params Face Reference;
    FaceFeAmtLCVal =null; rFaceFeRecCurVal = null; rType = null;
    //params Good Reference ;
    rGoodAmtUSDVal; rIntAmtUSDVal; rGoodAmtLCUSDVal; rIntAmtLCUSDVal; rGoodIntRecCurVal = null; rGoodIntAmtLCUSDVal;

    screenType = true;
    caseid ='0011U000007Ah1GQAS';

    @track isCSSLoaded = false;

    renderedCallback() {

        if (this.isCSSLoaded) return;
        this.isCSSLoaded = true;
        loadStyle(this, customCSS).then(() => {
            console.log('css loaded successfully');
        }).catch(error => {
            console.log('error to load css');
        });
    }

    connectedCallback(){
        console.log('connected Callback loaded '+this.recordId);
        console.log('connected Callback caseid '+this.caseid);

        const params = new Proxy(new URLSearchParams(window.location.search), {
            get: (searchParams, prop) => searchParams.get(prop)
        });
        let inContextOfRef = params.inContextOfRef;
        console.log('inContextOfRef  is '+inContextOfRef);
        if (inContextOfRef.startsWith("1\.")) { inContextOfRef = inContextOfRef.substring(2); }
        var addressableContext = JSON.parse(window.atob(inContextOfRef));
        console.log(' record id is  &&& .. '+addressableContext.attributes.recordId);

        /*if(this.recordId == null || this.recordId == undefined){
            this.setRedressValuesToJson('Case_Number__c',this.caseid);
            this.screenType = false;
            
        }
        
        this.isLoading = true;
        getRedressRecord({recordId : this.recordId })
        .then(result => {
            this.redressRec = result;
            this.setRedressValuesToJson('Id',result.Id);
            this.setFaceApexValuesToHtml(result);
            this.setGoodApexValuesToHtml(result);
            console.log(JSON.stringify(result));
            this.isLoading = false;    
        })
        .catch(error => {
            this.error = error.message;
            this.isLoading = false;
        });
        //this.setCaseId();
        */
    }
    /* 
    @wire(getObjectInfo, { objectApiName: REDNESS_OBJECT })
    rednessinfo;

    @wire(getPicklistValues, { recordTypeId: '$rednessinfo.data.defaultRecordTypeId', fieldApiName: CURRENCY_FIELD })
    currencyValues({ data, error }) {
        if (data) {
            data.values.forEach(val => {
                this.currencyOptions = [...this.currencyOptions, { value: val.value, label: val.label }];
            });
        }
        else if (error) {
            this.processErrorMessage(error);
        }
    } 

    @wire(getPicklistValues, { recordTypeId: '$rednessinfo.data.defaultRecordTypeId', fieldApiName: REDRESS_TYPE_FIELD })
    redressTypeyValues({ data, error }) {
        if (data) {
            data.values.forEach(val => {
                this.redressTypeyOptions = [...this.redressTypeyOptions, { value: val.value, label: val.label }];
            });
            console.log('redressTypeyValues  are pushed');
        }
        else if (error) {
            this.processErrorMessage(error);
        }
    } 
    
    getTransXForRefNumberJS(refNumber,refTypeVal){

        console.log('Good refNumber  is '+refNumber+' refTypeVal :'+refTypeVal);
        this.isLoading = true;
        getTransXForFaceRefNumber({setTXRefNumber : refNumber, refType : refTypeVal })
            .then(result => {

                if(refTypeVal == 'Face'){    
                    this.setFaceApexValuesToHtml(result);
                } else{
                    this.setGoodApexValuesToHtml(result);
                }
                console.log(JSON.stringify(result));
                this.isLoading = false;
            })
            .catch(error => {
                this.error = error.message;
                this.isLoading = false;
                console.log('this.error  is '+this.error);
            });
    }
 */
        get rName() {
            return this.redressRec?.Name;
        }    
        get rCaseName() {
            return this.redressRec?.Case_Number__r.CaseNumber;
        }
        get rDate() {            
            return this.redressRec?.Redress_Date__c;
        }
        get rFaceRef() {
            return this.redressRec?.Redress_Face_Fee_Reference_Number__c;
        }
        get rGoodRef() {
            return this.redressRec?.Redress_Goodwill_Interest_Ref_Number__c;
        }
        get rFaceAmtUSD() {
            return this.redressRec?.Redress_Face_Amount_in_USD__c;
        }
        get rFeeAmtUSD() {
            return this.redressRec?.Redress_Fee_Amount_in_USD__c;
        }
        get rFaceFeeAmtUSD() {
            return this.redressRec?.NFRedress_Face_Fee_Total_Amount_in_USD__c;
        }
        get rGoodIntAmtUSD() {
            return this.redressRec?.NFRedress_Goodwill_Interest_Total_in_USD__c;
        }
        get rFaceAmtLCUSD() {
            return this.redressRec?.Redress_Face_Amount_in_Local_Currency__c;
        }
        get rFeeAmtLCUSD() {
            return this.redressRec?.Redress_Fee_Amount_in_Local_Currency__c;
        }
        get rFaceFeePOENum() {
            return this.redressRec?.Red_Face_Fee_POE_Num_Read_Only__c;
        }
        get rGoodIntPOENum() {
            return this.redressRec?.Red_Gwill_Int_POE_Num_Read_Only__c;
        }
        get rFaceFeeREFNum() {
            return this.redressRec?.Red_Face_Fee_REF_Num_Read_Only__c;
        }
        get rGoodIntREFNum() {
            return this.redressRec?.Red_Gwill_Int_REF_Num_Read_Only__c;
        }

        onReferenceNumberChnage(event) {
            console.log(' onReferenceNumberChnage target reportValidity ');
            if(event.target.reportValidity()){ 
                console.log(' onReferenceNumberChnage target cmp '+event.target);
                if(event.target.value != null && event.target.value != ''){
                    if(event.target.name == 'Redress_Face_Fee_Reference_Number__c')
                        this.getTransXForRefNumberJS(event.target.value,'Face');
                    else
                        this.getTransXForRefNumberJS(event.target.value,'Good');
                }
            }
        }

        handleNavigate() {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.redressRec?.Case_Number__c,
                    objectApiName: 'Case',
                    actionName: 'view'
                }
            });
        }

        handleChange(event) {
            console.log('Handle change invoked -> '+event.target.name);
            console.log('Handle change invoked -> '+event.target.value);
            let name = event.target.name;
            let value = event.target.value;
            if(value == '')
                value = null;
            const dataAssign = Object.assign({[name]: value});
            this.addelementsToJson(dataAssign,name);
        }

        lookupHandleChange(event) {
         this.setRedressValuesToJson('Case_Number__c',event.target.value);          
        }

        addelementsToJson(dataAssign,name){
            this.jsonMap ={ ...this.jsonMap, ...dataAssign};
        }

        setRedressValuesToJson(name,val){
            const dataAssign = Object.assign({[name]: val});
            this.addelementsToJson(dataAssign,name);
        }

        setFaceApexValuesToHtml(redressObj){
            //console.log(' setFaceApexValuesToHtml  is invokde '+redressObj);
           0/* this.FaceFeAmtLCVal = redressObj.Redress_Face_Fee_Amt_in_Local_Currency__c;
            if(redressObj.Redress_Face_Fee_Receive_Currency__c == '' || 
                redressObj.Redress_Face_Fee_Receive_Currency__c == undefined)
                this.rFaceFeRecCurVal = null;
            else  
                this.rFaceFeRecCurVal = redressObj.Redress_Face_Fee_Receive_Currency__c;
            if(redressObj.Type_of_Redress_Required__c == '' || redressObj.Type_of_Redress_Required__c == undefined)
                this.rType = null;
            else  
                this.rType = redressObj.Type_of_Redress_Required__c;
            this.setRedressValuesToJson('Redress_Face_Fee_Amt_in_Local_Currency__c',this.FaceFeAmtLCVal);
            this.setRedressValuesToJson('Redress_Face_Fee_Receive_Currency__c',this.rFaceFeRecCurVal);   
            */         
        }

        setGoodApexValuesToHtml(redressObj){
            //console.log(' setGoodApexValuesToHtml  is invoked *** '+redressObj);
           // console.log(' Redress_Interest_Amount_in_USD__c  hree  *** '+redressObj.Redress_Interest_Amount_in_USD__c);
            /*this.rGoodAmtUSDVal = redressObj.Redress_Goodwill_Amount_in_USD__c;
            this.rIntAmtUSDVal = redressObj.Redress_Interest_Amount_in_USD__c;
            this.rGoodAmtLCUSDVal = redressObj.Redress_Goodwill_Amt_in_Local_Currency__c;
            this.rIntAmtLCUSDVal = redressObj.Redress_Interest_Amt_in_Local_Currency__c;
            this.rGoodIntAmtLCUSDVal = redressObj.Redress_Gdwill_Int_Amt_in_Loc_Currency__c;
            //console.log(' rIntAmtUSDVal  is invoked *** '+this.rIntAmtUSDVal);

            if(redressObj.Redress_Goodwill_Int_Receive_Currency__c == '' || 
                redressObj.Redress_Goodwill_Int_Receive_Currency__c == undefined)
                this.rGoodIntRecCurVal = null;
            else  
                this.rGoodIntRecCurVal = redressObj.Redress_Goodwill_Int_Receive_Currency__c;
            
            this.setRedressValuesToJson('Redress_Goodwill_Amount_in_USD__c',this.rGoodAmtUSDVal);
            this.setRedressValuesToJson('Redress_Interest_Amount_in_USD__c',this.rIntAmtUSDVal);
            this.setRedressValuesToJson('Redress_Goodwill_Amt_in_Local_Currency__c',this.rGoodAmtLCUSDVal);
            this.setRedressValuesToJson('Redress_Interest_Amt_in_Local_Currency__c',this.rIntAmtLCUSDVal);
            this.setRedressValuesToJson('Redress_Goodwill_Int_Receive_Currency__c',this.rGoodIntRecCurVal);
            this.setRedressValuesToJson('Redress_Gdwill_Int_Amt_in_Loc_Currency__c',this.rGoodIntAmtLCUSDVal);
              */    
        }

        save() { 
           
            let isError = false;
            let faceRefval = this.template.querySelector('lightning-input[data-id=FaceRef]').value;
            let goodRefval = this.template.querySelector('lightning-input[data-id=GoodRef]').value;
            let FaceFeRecCurVal = this.template.querySelector('lightning-combobox[data-id=FaceFeRecCur]').value;
            let GoodIntRecCurVal = this.template.querySelector('lightning-combobox[data-id=GoodIntRecCur]').value;
            var msg = 'Salesforce was unable to prefill following fields from transaction details. Please update these fields manually:';
            //console.log('currency is   '+GoodIntRecCurVal);
            if(faceRefval !='' && (FaceFeRecCurVal == '' || FaceFeRecCurVal == undefined)){
                msg += '\n Redress Face & Fee Receive Currency';
                isError = true;
            }
            if(goodRefval !='' && (GoodIntRecCurVal == '' || GoodIntRecCurVal == undefined)){
                msg += '\n Redress Goodwill & Int Receive Currency';
                isError = true;
            }
           
            var inp=this.template.querySelectorAll("lightning-input");
            inp.forEach(function(element){

                let name = element.name;
                let value = element.value;

                if( (faceRefval !=''  && faceRefval != null) && name == 'Redress_Face_Fee_Amt_in_Local_Currency__c' && (value =='' || value == null)){
                    msg += '\n Redress Face & Fee Amt in Local Currency';
                    isError = true;
                }

                if(goodRefval !='' && goodRefval != null){
                    if(GoodIntRecCurVal == 'USD' && name == 'Redress_Goodwill_Amount_in_USD__c' && (value =='' || value == null)) {
                        msg += '\n Redress Goodwill Amount in USD';
                        isError = true;
                    }
                    if(GoodIntRecCurVal == 'USD' && name == 'Redress_Interest_Amount_in_USD__c' && (value =='' || value ==null)){
                        msg += '\n Redress Interest Amount in USD';
                        isError = true;
                    }
                    if(GoodIntRecCurVal != 'USD' && name == 'Redress_Goodwill_Amt_in_Local_Currency__c' && (value =='' || value ==null)){
                        msg += '\n RRedress Goodwill Amt in Local Currency';
                        isError = true;
                    }
                    if(GoodIntRecCurVal != 'USD' && name == 'Redress_Interest_Amt_in_Local_Currency__c' && (value =='' || value == null)){
                        msg += '\n Redress Interest Amt in Local Currency';
                        isError = true;
                    }
                    if(name == 'Redress_Gdwill_Int_Amt_in_Loc_Currency__c' && (value =='' || value ==null)){
                        msg += '\n Redress Gdwill & Int Amt in Loc Currency';
                        isError = true;               
                    }                   
                }             
            },this);
            if(!isError) {
                this.isLoading =true;
                let finalJsonMap =  JSON.stringify(this.jsonMap);
                console.log('final json to sent to apex -> ', finalJsonMap);
                updateRedress({jsonRedressObj : finalJsonMap })
                    .then(result => {
                    console.log(JSON.stringify(result));
                    this.recordId = result;
                    this.isLoading = false;
                    this.closeQuickAction(this.recordId);
                    //this.navigateToRecordPage();
                    //this.closeQuickAction();
                    console.log('refresh is invoked 11');
                    //this.refreshPage();                 
                    })
                    .catch(error => {
                        console.log(' this error is from body'+error.body.message);
                        this.isLoading = false;
                        console.log('this.error  is '+error.message);
                        this.handleToastMsg(error.body.message);
                    });
            }else{
                this.handleToastMsg(msg);
            }
            
        }

        handleToastMsg(msg) {
            const evt = new ShowToastEvent({
                title: 'Toast Success',
                message: msg,
                variant: 'Error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        }

        
        navigateToRecordPage() {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.recordId,
                    objectApiName: 'Redress__c',
                    actionName: 'view'
                }
            });
    }
        closeQuickAction(recId) {
            
            const closeQA = new CustomEvent("save", {
                detail: { recId }
              });
            this.dispatchEvent(closeQA);        
        }
        
        cancelAction() {
            const cancelQA= new CustomEvent("cancel", {
                detail: { }
              });
             
            this.dispatchEvent(cancelQA);        
        }   
}