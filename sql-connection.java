package makedatabaseconnection;

import java.sql.*;
import javax.swing.JOptionPane;
public class FirstConnection {

        public static void main(String[] args) throws ClassNotFoundException, SQLException{
            
        int number;
        int currentCount;
        int aCount = 0;
        int bCount = 0;
        int cCount = 0;
        int dCount = 0;
        int fCount = 0;
        int totalCount = 0;
        String currentGrade;
        
        System.out.println("Creating connection to database...");
        
        Class.forName("oracle.jdbc.OracleDriver");
        Connection c = DriverManager.getConnection("jdbc:oracle:thin:@140.192.30.237:1521:def", "jgonz149", "");
        PreparedStatement gradeCount = c.prepareStatement("SELECT  GRADE, COUNT(*) FROM GRADING WHERE STUDENTID = ? GROUP BY GRADE");

            number = Integer.parseInt(JOptionPane.showInputDialog("Enter 7 digit student ID number: "));
            if (number != 0){
                System.out.println("Got " + number);
                gradeCount.setInt(1, number);
                ResultSet gCount;
                
                System.out.println("Issuing prepared statement... ");
                gCount = gradeCount.executeQuery();
                System.out.println("Statement issued.");
                System.out.println("Querying the resulted table... ");
                System.out.println("Student " + number +":");
                System.out.println("---------");
                
                
                while (gCount.next()){
                    currentGrade = gCount.getString(1);
                    currentCount = gCount.getInt(2);
                    
                    if(currentGrade.equalsIgnoreCase("A")){
                        aCount = currentCount;
                        totalCount+=currentCount;
                    }
                    else if(currentGrade.equalsIgnoreCase("B")){
                        bCount = currentCount;
                        totalCount+=currentCount;
                    }
                    else if(currentGrade.equalsIgnoreCase("C")){
                        cCount = currentCount;
                        totalCount+=currentCount;
                    }
                    else if(currentGrade.equalsIgnoreCase("D")){
                        dCount = currentCount;
                        totalCount+=currentCount;
                    }
                    else {
                        fCount = currentCount;
                        totalCount+=currentCount;
                    }
                }
                System.out.printf("A's %d\n", aCount);
                System.out.printf("B's %d\n", bCount);
                System.out.printf("C's %d\n", cCount);
                System.out.printf("D's %d\n", dCount);
                System.out.printf("F's %d\n", fCount);
                System.out.println("Total grades: "+totalCount);
            }

        c.close();
        System.out.println("Done!");
        }
}
