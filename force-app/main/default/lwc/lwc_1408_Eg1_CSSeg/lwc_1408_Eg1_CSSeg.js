import { LightningElement, track } from 'lwc';

export default class Lwc_1408_Eg1_CSSeg extends LightningElement 
{
    @track name;

    saveme(event)
    {
        this.name=event.target.value;
    }
}