import { LightningElement,track,api,wire } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Lwc_2608_eg2_createOpprecordUsingLDS extends LightningElement 
{
    @track nm;
    @track cd;
    @track sn;
    
    name1(event){
        
        this.nm=event.target.value;
    }
    clod(event){
       this.cd= event.target.value;
    }
    stagen(event){
        this.sn=event.target.value;
    }

    saveme(event){
        
        const fields={
                     'Name':this.nm,
                     'StageName':this.sn,
                     'CloseDate':this.cd   
                    }
                    alert('came here');
        const recordData={apiName:'Opportunity',fields};

        createRecord(recordData).then(response=>{
            this.showToast('Record Created','Record Created Sucessfully','success','dismissable');

        }).catch(errorr=>{
            this.showToast('Record falied','Record Creation failed','error','dismissable');

        });
    }
    
    showToast(tit,mes,var1,mode1) {
        
        const event = new ShowToastEvent({
            title: tit,
            message: mes,
            variant: var1,
            mode: mode1
        });
        this.dispatchEvent(event);
    }
}