import { LightningElement,wire,track,api } from 'lwc';
import bringContactList from '@salesforce/apex/Cl_2308_eg2_ssc_class.bringContactList';
import { updateRecord } from 'lightning/uiRecordApi';
import { refreshApex }  from 'lightning/uiRecordApi';
import { showToastEvent } from 'lightning/platformShowToastEvent';

import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ID_FIELD from '@salesforce/schema/Contact.Id'; 

const COLLLL=[  {label:'Contact First Name', fieldName:'FirstName',editable:true},
                {label:'Contact Last Name', fieldName:'LastName',editable:true},
                {label:'Contact Email', fieldName:'Email', type:"email"},
                {label:'Contact Phone', fieldName:'Phone', type:"phone"}
            ]
export default class Lwc_2308_eg2_ssc_class extends LightningElement  
{
    @track col=COLLLL;
    @track draftValues;
    @track error;
    @wire(bringContactList)contact;
   

    handelSave(event)
    {
        
        const fields={};

        fields[ID_FIELD.fieldApiName]=event.detail.draftValues[0].Id;
        fields[FIRSTNAME_FIELD.fieldApiName]=event.detail.draftValues[0].FirstName;
        fields[LASTNAME_FIELD.fieldApiName]=event.detail.draftValues[0].LastName;

        const recordInputs={fields};
        
        updateRecord(recordInputs)
        .then(()=>{
            alert("records saved!!!");
            this.draftValues=[];
            return refreshApex(this.contact);
         

        }).catch(error =>{
            alert("Errorrrrr");
           /* this.dispatchEvent(
                new showToastEvent({
                    title:'Error saving Record',
                    message:error.body.message,
                    variant:'error'
                })
            );*/
        });
    }
}