import { LightningElement } from 'lwc';
import getRelatedContacts from '@salesforce/apex/DataTableDemoLWC.getRelatedContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    {label:'Name', fieldName:'Name'},
    {label:'Phone', fieldName:'Phone'},
    {label:'Account Id', fieldName:'AccountId'},
];
export default class ShowContacts extends LightningElement {

    buttonLabel = 'Show Contacts';
    recordId;
    contactData;
    columns=columns;
    isDataTableVisible=false;
    searchKey='';


    connectedCallback() {
       getRelatedContacts({
            accountRecordId: this.recordId, searchValue: this.searchKey})
            .then(result =>
            {this.contactData = result;
                console.log('result : '+JSON.stringify(result))
            })
            .catch(error =>{
                console.log('Error : '+JSON.stringify(error))
            })
    }
    handleClick(event){
        const label = event.target.label;
        console.log('label '+JSON.stringify(label));
        if(label=='Show Contacts'){
            this.buttonLabel='Hide Contacts';
            this.isDataTableVisible=true;   
        }
        else{
            this.buttonLabel='Show Contacts';
            this.isDataTableVisible=false; 
        }
    }
    handleChange(event){
        this.searchKey = event.target.value;
        console.log('searchKey '+ JSON.stringify(this.searchKey));

        getRelatedContacts({
            accountRecordId: this.recordId, searchValue: this.searchKey})
            .then(result =>
            {this.contactData = result;
                console.log('result : '+JSON.stringify(result))
            })
            .catch(error =>{
                console.log('Error : '+JSON.stringify(error))
            })
    }

    handleSelectedRow(event){
      const selectedRow = event.detail.selectedRows;
      console.log('selectedRow '+ JSON.stringify(selectedRow));
    } 

    
}