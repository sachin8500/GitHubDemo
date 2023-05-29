import { LightningElement,track } from 'lwc';

export default class Lwc_2808_eg1_eventwithparamparent extends LightningElement 
{
    vol=0;
    @track controlnnn;
    increasevol(event)
    {   if(this.vol<10)
        {
            const v = event.detail;  //get params/attribute from event.
            this.controlnnn = v;
            this.vol=this.vol+1;
        }
        
    }

    decreasevol(event)
    {
        if(this.vol>0)
        {   
            const v = event.detail;  //get params/attribute from event.
            this.controlnnn = v;
            this.vol=this.vol-1;
        }
    }
}