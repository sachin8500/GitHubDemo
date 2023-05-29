import { LightningElement,track,api } from 'lwc';

export default class Lwc_2308_eg2_lds extends LightningElement 
{
    @api recordId="0035g00000DlEV9AAN";
    @track lwcInputFields;

    clearme(event)
    {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field');

            inputFields.forEach(field => 
            {
                field.reset();
            });
        }
}