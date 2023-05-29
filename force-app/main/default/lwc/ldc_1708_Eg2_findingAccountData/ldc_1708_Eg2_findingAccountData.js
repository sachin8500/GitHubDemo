import { LightningElement,track,wire,api } from 'lwc';
import getAccountRecords from '@salesforce/apex/Cl_1708_Eg2_findingAccountData.getAccountRecords'
export default class Ldc_1708_Eg2_findingAccountData extends LightningElement 

{   @track viewData;
    @wire(getAccountRecords)
    showAccounts({error,data}){

        if(data){
            
            this.viewData= data;
        }
        else if(error)
        {
            console.log('Errorrrr',error);
        }
    }
}