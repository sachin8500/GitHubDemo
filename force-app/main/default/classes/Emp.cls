public class Emp {
    
   public String empName;
   public Integer empSalary;
   
    public void increamentalSalary (String name, Integer salary){
        
        This.empName = name;
        This.empSalary = salary;
        
        if (salary >= 10000) {
            This.empSalary = calculateSalary(salary,20);
            This.empSalary = calculateSalary(salary,10);
        }
        System.debug('Total Salary : ' + this.empName + ' => ' + this.empSalary);
    }
    
    public Integer calculateSalary(Integer salary, Integer percentage) {
        Integer perSalary = (salary * percentage) / 100;
        salary = salary + perSalary;
        return salary;
    }
    
}

/*
Emp obj = new Emp();
obj.increamentSalary('XYZ', 10000);
obj.increamentSalary('PQR', 5000);
*/