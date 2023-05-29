import { LightningElement,track,api,wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Lwc_2608_eg3_createConRecordsUsinglds extends LightningElement 
{
    @track nm;
    @track em;

    name1(event){
        this.nm=event.target.value;
    }
    email1(event){
        this.em=event.target.value;
    }

    
    saveme(event){

        const fields={
                        'LastName':this.nm,
                        'Email':this.em
                    }
        const recordData={apiName:'Contact',fields}
        createRecord(recordData).then(response=>
            {
                this.showToast('Record Created','Record Created Successfully','success','dismissable');
            })
            .catch(errorr=>
            {
                this.showToast('Record Created','Record Created Successfully','success','dismissable');
            });
    }

    showToast(ti,mes,va,mo) {
        const event = new ShowToastEvent({
            title: ti,
            message: mes,
            variant: va,
            mode: mo
        });
        this.dispatchEvent(event);
    }
}