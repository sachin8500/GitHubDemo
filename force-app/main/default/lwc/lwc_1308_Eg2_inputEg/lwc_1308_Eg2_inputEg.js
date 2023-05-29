import { LightningElement, track } from 'lwc';

export default class Lwc_1308_Eg2_inputEg extends LightningElement {

name='Sachin';
phone="999999";
@track salary=5;
dob;
@track finalsal;

    showme(){
        const a= this.salary;
        this.finalsal=a*2;

    }

}