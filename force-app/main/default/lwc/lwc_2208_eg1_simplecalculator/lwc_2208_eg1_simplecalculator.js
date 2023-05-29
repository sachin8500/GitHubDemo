import { LightningElement, track } from 'lwc';

export default class Lwc_2208_eg1_simplecalculator extends LightningElement 
{
    
    @track firstnumber=0;
    @track secondnumber=0;
    @track res=0;

    calme(event)
    {
        if(event.target.name==="fnum"){
            this.firstnumber=event.target.value;
        }
        if(event.target.name==="snum"){
            this.firstnumber=event.target.value;
        }

        this.res=parseInt(this.firstnumber)+parseInt(this.secondnumber);
        
    }

    
}