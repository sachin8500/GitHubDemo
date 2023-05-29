import { LightningElement, track,api,wire} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Lwc_2508_Eg1_createRecordsbylds extends LightningElement 
{
    
    //declaire the variable for input method
    @track nm;
    @track ph;
    
    // intiate event on onchange method
    name1(event)
    {
        this.nm=event.target.value;
    }

    phone(event)
    {
        this.ph=event.target.value;
    }
    //for button need to us createrecords method
    Saveme(event)
    {   
        
        const fields={'Name':this.nm,
                        'Phone':this.ph}

        const recordData={apiName:'Account',fields};
        createRecord(recordData).then(response=>
            {
                
            this.showToast('Records Created','Record created sucessfully','success','dismissable');
        
            }).catch(errorrr=>{
                this.showToast('Record failed','Record created failed','error','dismissable');
        
            });

        
    } 

    showToast(tit,mes,var1,mode1) {
        const evt = new ShowToastEvent({
            title: tit,
            message: mes,
            variant: var1,
            mode:mode1
        });
        this.dispatchEvent(evt); 
}
}