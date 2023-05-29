import { LightningElement } from 'lwc';

export default class Lwc_2808_eg2_eventparent extends LightningElement 
{   
    vol=0;
    increasevol(event)
    {   if(this.vol<10)
        {
            this.vol=this.vol+1;
        }
        
    }

    decreasevol(event)
    {
        if(this.vol>0)
        {
            this.vol=this.vol-1;
        }
    }
}