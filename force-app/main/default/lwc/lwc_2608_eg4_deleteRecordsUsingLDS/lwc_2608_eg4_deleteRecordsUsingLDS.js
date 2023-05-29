import { LightningElement,api} from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

export default class MyCustomElement extends NavigationMixin(LightningElement)
{  
    @api recordId;
   delme(event)
   {
        deleteRecord(this.recordId).then(response=>{
           this.showToast('Record Deleted','Record Deleted successfully','success','dismissable');
            this.navigateToContactHome();
        }).catch(errorrr=>{
           this.showToast('Record not Deleted','Record Deleted failed','error','dismissable');
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

navigateToContactHome() {
    // Navigate to the Account home page
    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            objectApiName: 'Contact',
            actionName: 'home',
        },
    });
}
}