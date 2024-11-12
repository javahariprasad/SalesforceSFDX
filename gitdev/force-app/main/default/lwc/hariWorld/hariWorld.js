import { LightningElement ,track} from 'lwc';
export default class HariWorld extends LightningElement {
  greeting = 'World';
  changeHandler(event) {
    this.greeting = event.target.value;
  }
   x;

    initDate() {
        this.x = new Date();
    }

  updateDate() {
    this.x.setHours(7);
  }
}