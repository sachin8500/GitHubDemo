public class Student {   
    
    public void calculateResult(Integer total_marks, Integer actual_score) {
        
        StudHelper obj = new StudHelper();
        Decimal percentage = obj.calculatePercentage(total_marks, actual_score);
        System.debug('percentage => ' + percentage);
        String result = obj.calculateGrade(percentage);
        System.debug('result => ' + result);
        
    }
    
}