import { LightningElement } from 'lwc';

export default class Lwc_2808_eg1_eventchild extends LightningElement 
{   
    

    callIncrease()
    {   
        const inc=new CustomEvent('incre');//Step1 - create Event
        this.dispatchEvent(inc); //Step2- disptch Event
    }

    callDecrease()
    {
       
            //const dec = new CustomEvent('decre');
            //this.dispatchEvent(dec);

            this.dispatchEvent(new CustomEvent('decre'));
            
        
    }
}