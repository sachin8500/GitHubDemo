import { api, LightningElement } from 'lwc';

export default class Lwc_1508_eg2_ldseditform extends LightningElement 
{
    @api recordId;

    clearme(event)
    {
        const inputField=this.template.querySelectorAll('lightning-input-field');
        inputField.forEach(
            field => {field.reset();}

        );
    }
}