import { LightningElement,api,track } from 'lwc';
import ACCOUNT from '@salesforce/schema/Account';
import NAME from '@salesforce/schema/Account.Name';
import INDUSTRY from '@salesforce/schema/Account.Industry';
import PHONE from '@salesforce/schema/Account.Phone';

export default class Lwc_2308_eg4_lds extends LightningElement 
{
    abc=ACCOUNT;
    myField=[NAME,INDUSTRY,PHONE];
}