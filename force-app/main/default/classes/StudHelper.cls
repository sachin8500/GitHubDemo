public class StudHelper {
    								
    public Decimal calculatePercentage(Integer total_marks, Integer actual_score) {
        Decimal percentage = (actual_score * 100) / total_marks;
        return percentage;
    }
    
    public String calculateGrade(Decimal percentage) {
        String result;
        if( percentage >= 75 ) {
            result = 'Distinction';
        } else if( percentage < 75 && percentage >= 60 ) {
            result = 'First Class';
        } else if( percentage < 60 && percentage >= 35 ) {
            result = 'Second Class';
        } else {
            result = 'Failed';
        }
        return result;
    }

}