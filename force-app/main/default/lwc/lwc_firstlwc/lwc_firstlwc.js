import { LightningElement, track } from 'lwc';

export default class Lwc_firstlwc extends LightningElement 
{
   @track resvalue;

   num1;
   num2;

   callme(event){

    const evt=event.target.name;

    if(evt=='aval'){
        this.num1=event.target.value;
    }
    if(evt=='bval'){
        this.num2=event.target.value;
    }

   }
   addme()
   { 
    const a = parseInt(this.num1);
    const b = parseInt(this.num2);
    this.resvalue = 'sum ' +(a+b);

   }
   sub()
   { 
    const a = parseInt(this.num1);
    const b = parseInt(this.num2);
    this.resvalue = 'sub ' +(a-b);
   }
   mul()
   { 
    const a = parseInt(this.num1);
    const b = parseInt(this.num2);
    this.resvalue = 'mul ' +(a*b);
   }
}