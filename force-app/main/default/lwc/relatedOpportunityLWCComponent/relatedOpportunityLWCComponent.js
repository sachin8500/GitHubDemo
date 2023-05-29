import { LightningElement,track,api } from 'lwc';
import getOpp from '@salesforce/apex/RelatedOppLWCComp.getOpp';

const columns= [
    {label:'Name' , fieldName:'Name'},
    {label:'Account Id', fieldName:'AccountId'}
    ];

export default class RelatedOpportunityLWCComponent extends LightningElement {

    buttonLabel='Show Opportunities';
    columns=columns;
    @api recordId;
    dataList;
    isDatatableVisible = false;
    searchKey='';

    connectedCallback() {
        getOpp({accountRecordId : this.recordId, searchValue:this.searchKey})
        .then(result=>{
            this.dataList=result;
        })
        .catch(error=>{
            console.log('Error '+ JSON.stringify(error));
        })
    } 
 
   handleClick(event){        
        const label = event.target.label;
        console.log(label);
        if(label=='Show Opportunities'){
            this.buttonLabel='Hide Opportunities';
            this.isDatatableVisible = true;
        }else{
            this.buttonLabel='Show Opportunities';
            this.isDatatableVisible = false;
        }

    }

      handleChange(event){
        this.searchKey = event.target.value;

        console.log('searchKey' + JSON.stringify(this.searchKey));

        getOpp({accountRecordId : this.recordId, searchValue:this.searchKey})
        .then(result=>{
            this.dataList=result;
        })
        .catch(error=>{
            console.log('Error '+ JSON.stringify(error));
        })
    }

    handleSelectedRow(event){
        const selectedRow = event.detail.selectedRows;
        console.log('Selected Row ' + JSON.stringify(selectedRow));        
    }
}