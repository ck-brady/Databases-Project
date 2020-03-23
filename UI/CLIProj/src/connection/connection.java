package connection;

import java.util.*; 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;


public class connection {
	public static void main() {
		try {
			Class.forName("org.postgresql.Driver");
			String url="";
			String username="";
			String password="";
			Connection db = DriverManager.getConnection(url, username, password);
		
		
			System.out.println("Welcome to the application");
			System.out.println("Are you a 1.Guest, 2. Employee or 3. Admin 4. Host");
		
			Scanner sc=new Scanner(System.in); 
			int a= sc.nextInt();
			if (a == 1) {
				System.out.println("What is the account ID?");
				int guestID= sc.nextInt();
				
				Statement st = db.createStatement(); 
				ResultSet rs = st.executeQuery("SELECT * FROM Guest wherer Account_ID = " + guestID);
				System.out.println(rs);
				
				System.out.println("loggedin");
			
				System.out.print("Where do you want to book the place?");
				String address= sc.nextLine();
				rs = st.executeQuery("SELECT * FROM property wherer address = " + address);
				System.out.println(rs);
				
			
			}
			else if (a == 2) {
				System.out.println("What is the account ID?");
				int employeeID = sc.nextInt();
				Statement st = db.createStatement();
				ResultSet rs = st.executeQuery("SELECT * FROM Employee wherer Account_ID = " + employeeID);
				System.out.println(rs);
				
				System.out.println("loggedin");
				
			
			}
			else if (a ==3) {
				System.out.println("please input the sql in the next line: ");
				String sql= sc.nextLine();
				Statement st = db.createStatement(); 
				ResultSet rs = st.executeQuery(sql);
			}
			else if (a == 4) {
				System.out.println("What is your ID: ");
				int HostID = sc.nextInt();
				Statement st = db.createStatement();
				ResultSet rs = st.executeQuery("SELECT * FROM Host wherer Account_ID = " + HostID);
				System.out.println("What is your Property ID: ");
				int PropertyID = sc.nextInt();
				rs = st.executeQuery("SELECT * FROM Property wherer Property_ID = " + PropertyID);
				System.out.println(rs);
			}
			else {
				System.out.println("Error: Invalid response!");
			}
		}catch(Exception e) {
			System.out.println("Error");
			System.out.println(e.getMessage());
		}
		
	}
	
	

}
