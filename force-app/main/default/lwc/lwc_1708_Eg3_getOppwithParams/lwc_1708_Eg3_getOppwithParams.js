import { LightningElement, track,wire,api } from 'lwc';
import getOPP from '@salesforce/apex/CL_1708_Eg3_getOppwithParams.getOPP'
export default class Lwc_1708_Eg3_getOppwithParams extends LightningElement 

{   @track searchKey='';
    @track showData;
    @wire(getOPP,{name:'$searchKey'})
    getData({error,data})
    {
        if(data){
            this.showData = data;
        }
        else if(error)
        {
            console.log('Erporrrr',error);
        }
    }
    callme(event){
        this.searchKey=event.target.value;
    }
}