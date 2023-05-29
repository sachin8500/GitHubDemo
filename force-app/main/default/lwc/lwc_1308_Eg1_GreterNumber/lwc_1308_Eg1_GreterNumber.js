import { LightningElement, track } from 'lwc';

export default class Lwc_1308_Eg1_GreterNumber extends LightningElement {

    @track num1;
    @track num3;
    @track num2;
    @track result;
    callme(event)
    {
        let n1=parseInt(this.num1);
        let n2=parseInt(this.num2);
        let n3=parseInt(this.num3);

        if(n1>n2 && (n1>n3)){

            this.result=n1;
        }else if(n2>n1 && n2>n3){

            this.result=n2;
        }else{
            this.result=n3;
        }

    }
    fn1(event){
        this.num1=event.target.value;       
    }
    fn2(event){
        this.num2=event.target.value;
    }
    fn3(event){
        this.num3=event.target.value;
    }
}