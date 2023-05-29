import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    sampleText='Hello World!!!'

    employee={

        Name:'Sachin',
        Age:38,
        Salary: 120000,
    }

    employeeList=[
        {
            Code:'001',
            Name:'Sachin',
            Age:30,
            Salary: 120000,
        },
        {
            Code:'002',
            Name:'Satish',
            Age:38,
            Salary: 150000,
        },
        {
            Code:'003',
            Name:'Akash',
            Age:35,
            Salary: 120000,
        },
        {
            Code:'004',
            Name:'Jay',
            Age:37,
            Salary: 20000,
        }


    ]
        
    

    get getEmpBand(){
        const Band = this.employee.Salary <= 30000? 'B1' : this.employee.Salary<=60000?'B2':'B3';
        return Band;
    }
}