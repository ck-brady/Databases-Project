import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.Scanner;

public class Control {
	
	private static final String url = "jdbc:postgresql://csi2132.postgres.database.azure.com:5432/Project 2132 Prod";
	private static final String username = "postgres@CSI2132";
	private static final String password = "CSI2132proj";
	
	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		
		Connection conn = DriverManager.getConnection(url, username, password);
		
		System.out.println("Welcome to the database control system");
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("Please enter your account type: \n"
				+ "1. Guest\n"
				+ "2. Host\n"
				+ "3. Employee\n"
				+ "4. Admin\n");
		
		int accountType = scanner.nextInt();
		
		while (accountType < 1 || accountType > 4) {
			System.out.println("Invalid input, please try again:\n");
			accountType = scanner.nextInt();
		}
		
		System.out.println("Please enter your account ID: ");
		String accountID = scanner.next();
		//consume \n char
		scanner.nextLine();
		
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM Person WHERE Account_ID = " + accountID);
		if (!rs.isBeforeFirst()) 
			throw new IllegalStateException("No account related to ID " + accountID);
		
		System.out.println("Your account information:");
		printRS(rs);
		
		//for UI menus
		int opType;
		int propID;
		//Guest
		if (accountType == 1) {
			rs = st.executeQuery("SELECT * FROM Guest WHERE Account_ID = " + accountID);
			if (!rs.isBeforeFirst()) 
				throw new IllegalStateException("Account linked to " + accountID + " is not a guest.");
			System.out.println("Your guest information:");
			printRS(rs);
			
			System.out.println("Enter a city-country tuple (ex. Berlin, Germany) for the city you wish to check for listings in: ");
			String location = scanner.nextLine();
			System.out.println("Searching for properties in " + location + "...");
			rs = st.executeQuery("SELECT * FROM listing NATURAL JOIN property WHERE address = '" + location + "'");
			if (!rs.isBeforeFirst())
				System.out.println("No results found.");
			else
				printRS(rs);
		}
		//Host
		if (accountType == 2) {
			rs = st.executeQuery("SELECT * FROM Host WHERE Account_ID = " + accountID);
			if (!rs.isBeforeFirst()) 
				throw new IllegalStateException("Account linked to " + accountID + " is not a host.");
			System.out.println("Your host information:");
			printRS(rs);
			System.out.println();
			
			System.out.println("To begin uploading a listing, please enter your property ID:");
			propID = scanner.nextInt();
			//consume \n char
			scanner.nextLine();
			System.out.println("Enter a name for your listing: ");
			String listingName = scanner.nextLine();
			System.out.println("Enter a description for your listing: ");
			String listingDesc = scanner.nextLine();
			System.out.println("Enter a start date for your listing: ");
			String listingStart = scanner.nextLine();
			System.out.println("Enter an end date for your listing: ");
			String listingEnd = scanner.nextLine();
			System.out.println("Enter a rental rate for your listing: ");
			int paymentRate = scanner.nextInt();
			scanner.nextLine();
			System.out.println("Enter a cleaning fee for your listing: ");
			int cleaningFee = scanner.nextInt();
			scanner.nextLine();
			System.out.println("Enter a deposit amount for your listing: ");
			int depositFee = scanner.nextInt();
			scanner.nextLine();
			
			String listingUpdate = "INSERT INTO listing (property_id, listing_name, description, start_date, end_date) "
					+ "VALUES (" + propID + ", '" + listingName + "', '" + listingDesc + "', '" + listingStart + "', '" + listingEnd + "'); "
					+ "INSERT INTO pricing (property_id, rental_rate, cleaning_fee, deposit) "
					+ "VALUES (" + propID + ", " + paymentRate + ", " + cleaningFee + ", " + depositFee + ")";
			
			int updateOutput = st.executeUpdate(listingUpdate);
			System.out.println("Update status: " + updateOutput);
			
		}
		//Employee
		if (accountType == 3) {
			rs = st.executeQuery("SELECT * FROM Employee NATURAL FULL OUTER JOIN Manager WHERE Account_ID = " + accountID);
			if (!rs.isBeforeFirst()) 
				throw new IllegalStateException("Account linked to " + accountID + " is not an employee or a manager.");
			System.out.println("Your employee information:");
			printRS(rs);
			System.out.println();
			System.out.print("Your area of operation: ");
			rs = st.executeQuery("SELECT branch FROM manager WHERE manager_id = (SELECT manager_id from employee WHERE account_id = " + accountID + ")");
			String opArea = getRSasString(rs);
			String opAreaPattern = "'%" + opArea + "'";
			System.out.println(opArea);
			System.out.println();
			
			System.out.println("Select the operation type you wish to make:\n"
					+ "1. View all rental agreements\n"
					+ "2. View all listings\n"
					+ "3. View all occupancies\n"
					+ "4. Seach property by ID\n"
					+ "5. Search person by ID");
			opType = scanner.nextInt();
			while (opType < 1 || opType > 5) {
				System.out.println("Invalid input, please try again:\n");
				opType = scanner.nextInt();
			}
			if (opType == 1) {
				rs = st.executeQuery("SELECT rental_agreement.* FROM rental_agreement "
						+ "JOIN listing ON listing.listing_id = rental_agreement.listing_id "
						+ "JOIN property on property.property_id = listing.property_id "
						+ "WHERE address LIKE " + opAreaPattern);
			} else if (opType == 2) {
				rs = st.executeQuery("SELECT listing.* FROM listing "
						+ "JOIN property on property.property_id = listing.property_id "
						+ "WHERE address LIKE " + opAreaPattern);
			} else if (opType == 3) {
				rs = st.executeQuery("SELECT listing.property_id, listing.listing_id, rental_agreement.ra_id, rental_agreement.start_date, rental_agreement.end_date "
						+ "FROM listing NATURAL JOIN property "
						+ "JOIN rental_agreement ON rental_agreement.listing_id = listing.listing_id "
						+ "WHERE address LIKE " + opAreaPattern);
			} else if (opType ==4) {
				System.out.println("Enter the ID of the property you wish to find:");
				propID = scanner.nextInt();
				rs = st.executeQuery("SELECT * FROM property WHERE property_id = " + propID);
			} else {
				System.out.println("Enter the ID of the person you wish to find:");
				int personID = scanner.nextInt();
				rs = st.executeQuery("SELECT * FROM person WHERE account_id = " + personID);
			}
			if (!rs.isBeforeFirst())
				System.out.println("No results found.");
			else
				printRS(rs);
		}
		//Admin
		if (accountType == 4) {
			System.out.println("Please enter database password: ");
			String pass = scanner.next();
			if (!pass.equals(password))
				throw new IllegalStateException("Invalid password; Aborting.");
			
			while (true) {
				System.out.println("Select the operation type you wish to make:\n"
						+ "1. Query\n"
						+ "2. Update\n");
				opType = scanner.nextInt();
				while (opType < 1 || opType > 2) {
					System.out.println("Invalid input, please try again:\n");
					opType = scanner.nextInt();
				}
				//consume \n char
				scanner.nextLine();
				
				System.out.println("Enter SQL code here: ");
				String op = scanner.nextLine();
				int status;
				try {
					if (opType == 1) {
						rs = st.executeQuery(op);
						printRS(rs);
					} else {
						status = st.executeUpdate(op);
						System.out.println(status);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private static void printRS(ResultSet rs) throws SQLException {
		while (rs.next()) {
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			for (int i = 1; i <= columnsNumber; i++) {
				String columnValue = rs.getString(i);
				System.out.println(rsmd.getColumnName(i) + ": " + columnValue);
			}
			System.out.println();
		}
	}
	
	private static String getRSasString(ResultSet rs) throws SQLException {
		String rsString = "";
		while (rs.next()) {
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();
			for (int i = 1; i <= columnsNumber; i++) {
				String columnValue = rs.getString(i);
				rsString = rsString + (columnValue);
			}
		}
		return rsString;
	}
}
