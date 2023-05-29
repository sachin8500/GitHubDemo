import { LightningElement,track } from 'lwc';

export default class Lwc_2308_eg2_cssexample extends LightningElement 
{
    @track Name;

    calme(event)
    {
        this.Name=event.target.value;
    }


}