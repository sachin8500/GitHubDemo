public class EmpSalaryCalculator {

    public string empName;
    public integer empSalary;
    
    public void increametalSalary(string name, integer salary){
    
    this.empName = name; 
    this.empSalary= salary;
    
        if (salary>=10000){
            this.empSalary= calculateSalary(salary,10);
                }else{
                    this.empSalary= calculateSalary(salary,5);
                }
    System.debug('Total Salary ' + this.empName + '=>>'+ this.empSalary);
    }  
    
    public integer calculateSalary(integer salary, integer percentage)
        
    {
       integer perSalary=(salary*percentage)/100;
       salary = salary+perSalary;
        return salary;
              
    }

}