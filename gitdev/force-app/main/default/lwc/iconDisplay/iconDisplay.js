import { LightningElement , api } from 'lwc';

export default class IconDisplay extends LightningElement {
    @api iconType;
    @api iconName;
    @api iconSize;
    @api iconText;
    @api foregroundColor;
    @api backgroundColor;

    get iconTypeName(){
        return this.iconType + ":" + this.iconName;
    }

    get myIconClass(){
        //return !this.foregroundColor || !this.backgroundColor ? '' : 'my-icon'
    }
    //both foregroundColor and backgroundColor are required to set custom color. 

    renderedCallback() { 
        console.log(' iconType  ->'+this.iconType);
        console.log(' iconName  ->'+this.iconName);
        //this.initCSSVariables();
    }

    initCSSVariables() {
        this.template.querySelector('.my-icon').style.setProperty('--backgroundColor', this.backgroundColor);
        this.template.querySelector('.my-icon').style.setProperty('--foregroundColor', this.foregroundColor);
    }
}