import { LightningElement,api } from 'lwc';
import LightningModal from 'lightning/modal';
export default class MyModelColorsPicker extends LightningModal {

    @api color;

    handleSelect(){
        this.close('color');
    }
}