import { LightningElement, track, wire } from 'lwc';
import getContactList from '@salesforce/apex/Cl_1508_eg5_datatable1.getContactList'

const COLSSSS=[ {label:'Contact First Name', FieldName:'FirstName'},
                {label:'Contact Last Name', FieldName:'LastName'},
                {label:'Contact Email', FieldName:'Email'},
                {label:'Contact Phone', FieldName:'Phone'}
            ];

export default class Lwc_1508_eg5_datatable1 extends LightningElement 
{
    @track col =COLSSSS;
    @wire(getContactList) contact;

}