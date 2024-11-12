import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateToPage extends NavigationMixin(LightningElement) {
    connectedCallback() {
       this.navigateToChatter();
    }
    
    navigateToChatter() {
     console.log('navigate chatter');

     
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'chatter'
            },
        });
    }
}