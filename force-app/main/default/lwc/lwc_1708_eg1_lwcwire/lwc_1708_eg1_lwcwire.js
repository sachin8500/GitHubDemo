import { LightningElement,wire,api,track} from 'lwc';
import getContactData from '@salesforce/apex/CL_1708_eg1_lwcwire.getContactData'
export default class Lwc_1708_eg1_lwcwire extends LightningElement 
{   @track viewData;
     @wire(getContactData)
     showContacts({error,data})
     {
        if(data)
        {
            this.viewData = data;
        }
        else if (error)
        {
            console.log('Errorrrr',error);
        }
     }
}