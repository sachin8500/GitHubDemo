import { LightningElement,wire } from 'lwc';

import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext
} from 'lightning/messageService';
import viewAccountContactsChannel from '@salesforce/messageChannel/viewAccountContactsChannel__c';
import getAccountContats from '@salesforce/apex/LWCAccountController.getAccountContats';
import{deleteRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LightningConfirm from 'lightning/confirm';
export default class AccountContacts extends LightningElement {
    subscription=null;
    accountId='';
    @wire(MessageContext)
    messageContext;
    contacts=[];
    title='Contacts';
    editableContactId='';
    isShowModelPopup= false; 

    connectedCallback(){

        this.subscribeToMessageChannel();
    }

    get isAccountSelected(){
        return this.accountId? true : false;
    }

    get hasContacts(){
        return this.contacts?.length>0; 
    }
    async getContacts(){
        const data= await getAccountContats({accountId:this.accountId});
        this.contacts=data;
    }
    // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                viewAccountContactsChannel,
                (data) => this.handleAccountSelection(data),
                { scope: APPLICATION_SCOPE }
            );
        } 
    }

    handleAccountSelection(data){
        this.accountId=data.accountId;
        this.title=`${data.accountName}'s Contacts`
        this.getContacts();
    }
    disconnectedCallback(){
        this.unsubscribeToMessageChannel();
    }
    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    editContactHandler(event){
        this.editableContactId=event.target.dataset.contactId;
        this.isShowModelPopup=true;
    }
    async deleteContactHandler(event){
        let contactId=event.target.dataset.contactId;
        const result = await LightningConfirm.open({
            message: 'Are you sure you want to delete this Contact?',
            variant: 'headerless',
            label: 'Confirmation',
            // setting theme would have no effect
        });
        if(result){
           // let contactId=event.target.dataset.contactId;
            let deleteResult= await deleteRecord(contactId);
            this.showToast('Contact Deleted','Contact Deleted Successufully','Success');
            this.getContacts();
        }
    }

    popCloseHandler(event){
        this.isShowModelPopup=false;
        this.editableContactId=null;
    }

    sucessHandler(){
        this.popCloseHandler();
        this.getContacts();
    }

    addContactHandler(){
        this.isShowModelPopup=true;
    }
    showToast(title,message,variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
                
        });
        this.dispatchEvent(event);
    }

}