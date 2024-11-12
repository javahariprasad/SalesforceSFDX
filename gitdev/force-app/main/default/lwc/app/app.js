import { LightningElement, track,api } from 'lwc';
import getMonitoringFrequency from "@salesforce/apex/AppMultiPick.getMonitoringFrequency";
import fetchSimpleMap from '@salesforce/apex/AppMultiPick.fetchSimpleMap';
export default class App extends LightningElement {
    mapData;
    isRender = false;
    @api msOptions;
    simpleMapStr;
    simpleMap = [];
    connectedCallback(){
        this.handleLoadSimpleMap();
        console.log('map data connectedCallback 3');
        this.msOptions =  [{'key':1,'value':'Jaipur'}];
        
    }
    renderedCallback(){
        console.log('map data renderedCallback ');
    }

  

    handleLoadSimpleMap() {
        fetchSimpleMap().then((result) => {
            console.log('result', result);
            this.simpleMap = [];
            for (var key in result) {
                this.simpleMap.push({ 'key': key, 'value': result[key] });
                //this.simpleMap.push({ key: key, value: result[key] });
                //console.log('key is ', key, result[key]);
            }
            this.simpleMapStr = JSON.stringify(result, null, 2);
            this.isRender = true;
         
        }).catch((error) => {
            console.log(error);
        });
    }

   

   

    @track
    state = {
        title: 'Welcome to Lightning Web Components Playground!',
    };

    @track yourSelectedValues;
    get options() {
        return [
            {
                label: 'supports',
                value: 'supports',
            },
            {
                label: 'has ability to show',
                value: 'shows',
            },
        ];
    }

    /*get msOptions () {
        return [{'key':1,'value':'Jaipur'},
                       {'key':2,'value':'Pune', 'selected' : true},
                       {'key':3,'value':'Hyderabad'},
                       {'key':4,'value':'Banglore'},
                       {'key':5,'value':'Gurgaon'},
                       {'key':6,'value':'Mumbai'},
                       {'key':7,'value':'Chennai'},
                       {'key':8,'value':'Noida'},                      
                       {'key':9,'value':'Delhi'}];
    } */

    getSelectedItems () {
        this.yourSelectedValues = '';
        let self = this;
        this.template.querySelector ('c-multi-pick-list').getSelectedItems().forEach (function (eachItem) {
                console.log (eachItem.value);
                self.yourSelectedValues += eachItem.value + ', ';
        });
    }

    handleOnItemSelected (event) {
        if (event.detail) {
            this.yourSelectedValues = '';
            let self = this;
            
            event.detail.forEach (function (eachItem) {
                    console.log (eachItem.value);
                    self.yourSelectedValues += eachItem.value + ', ';
            });
        }
        if(this.yourSelectedValues){
            console.log(' selected ');
            this.template.querySelector("div[data-name=diverror]").style.display='none';
        }
    }
    save() { 
        if(!this.yourSelectedValues){
            this.template.querySelector("div[data-name=diverror]").style.display='block';
        }
    }

}