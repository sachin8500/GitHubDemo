import { LightningElement, track } from 'lwc';

export default class Myfirstpage extends LightningElement 

{
    @track msg;
    
    callme(event)
    {
        this.msg='Hi, How are you???';

    }
}