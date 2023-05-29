import { LightningElement,api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';


export default class Lwc_2108_eg1_customFields extends LightningElement 
{
    @api recordId;
    @api objectApiName;
    fields = [NAME_FIELD, PHONE_FIELD];
}