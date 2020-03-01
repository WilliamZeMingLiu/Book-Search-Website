package liu994_CSCI201L_Assignment3;

import java.sql.*;
import java.util.ArrayList;

public class JDBC_Driver{
	static Connection conn = null;
	static PreparedStatement ps = null;
	static ResultSet rs = null;
	
	public static void connect() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			final String credential = "jdbc:mysql://google/Assignment3?cloudSqlInstance=phonic-agility-255419:us-central1:assignment3&socketFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=liu994@usc.edu&password=Soccer95"; 
			conn = DriverManager.getConnection(credential);
		} catch (SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public static void close() {
		try {
			if(rs != null) {rs.close();}
			
			if(ps != null) {ps.close();}
			
			if(conn != null) {conn.close();}
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public static boolean checkUser(String username) {
		boolean check = false;
		try {
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps.setString(1, username);
			rs = ps.executeQuery();
			check = rs.next();
			return check;
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return check;
		
	}
	
	public static boolean checkPassword(String username, String password) {
		boolean check = false;
		try {
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=? AND password=?");
			ps.setString(1, username);
			ps.setString(2, password);
			rs = ps.executeQuery();
			check = rs.next();
			return check;
			
		} catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return check;
	}
	
	public static void addUser(String username, String password) {
		try {
			if(!JDBC_Driver.checkUser(username)) {
				ps = conn.prepareStatement("INSERT INTO User (username, password) VALUES (?, ?)");
				ps.setString(1, username);
				ps.setString(2, password);
				ps.executeUpdate();
			}	
		}catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public static boolean checkFavorite(String username, String bookID) {
		boolean check = false;
		try {
			ps = conn.prepareStatement("SELECT f.orderID FROM Favorites f, User u WHERE f.userID=u.userID AND u.username=? AND f.bookID=?");
			ps.setString(1, username);
			ps.setString(2, bookID);
			rs = ps.executeQuery();
			check = rs.next();
			return check;
		}catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return check;
		
	}
	public static void addFavorite(String username, String bookID) {
		try {
			if(!JDBC_Driver.checkFavorite(username, bookID)) {
				ps = conn.prepareStatement("INSERT INTO Favorites (userID, bookID) VALUES ((SELECT userID FROM User WHERE username=?) , ?)");
				ps.setString(1, username);
				ps.setString(2, bookID);
				ps.executeUpdate();
			}
			
		}catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public static void removeFavorite(String username, String bookID) {
		try {
			if(JDBC_Driver.checkFavorite(username, bookID)) {
				ps = conn.prepareStatement("DELETE FROM Favorites WHERE userID=(SELECT userID from User WHERE username=?) AND bookID=? ");
				ps.setString(1, username);
				ps.setString(2, bookID);
				ps.executeUpdate();
			}
			
		}catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
	}
	
	public static ArrayList<String> printFavorite(String username) {
		ArrayList<String> array = new ArrayList<String>();
		try {
			ps = conn.prepareStatement("SELECT * FROM Favorites f, User u WHERE f.userID=u.userID AND u.username=? ORDER BY f.orderID");
			ps.setString(1, username);
			rs = ps.executeQuery();
			while(rs.next()) {
				String check = rs.getString("bookID");
				array.add(check);
			}
			rs.close();
			return array;
			
		}catch(SQLException sqle) {
			System.out.println(sqle.getMessage());
		}
		return array;
	}
	
	
}
