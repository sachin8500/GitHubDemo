import { LightningElement,track } from 'lwc';

export default class Lwc_1708_eg1_lwcform extends LightningElement 

{
name;
email;
password;


callme(event)
{
    const res=event.target.name
    if(res=='name'){
        this.name=event.target.value
    }
    if(res=='email'){
        this.email=event.target.value
    }
    if(res=='password'){
        this.password=event.target.value
    }

}
showres=false;

clickme(){
    this.showres=true;
}
    
}