package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.AdminModel;
 

public class AdminDAO {

		public AdminDAO() {
			
		}
	
	protected Connection getConnection() throws SQLException {
		Connection connection = null;

		new org.sqlite.JDBC();

		String jdbcURL = "jdbc:sqlite:D:\\sqlite\\miniproject.db";
		connection = DriverManager.getConnection(jdbcURL);

		System.out.println("Connection to SQLite has been established.");
		return connection;
	}

	public AdminModel checklogin(String username, String password) {
		
		try(Connection connection = getConnection();
				 PreparedStatement ps = connection.prepareStatement("SELECT * FROM admins  WHERE username = ? and password = ? ")){
				 ps.setString(1,username);
				 ps.setString(2, password);
				 
				 ResultSet rs  = ps.executeQuery();
				 AdminModel admin = null ;
				 
				   if (rs.next()) {
					   admin = new AdminModel();
			            
					   admin.setId(rs.getString("id"));
					   admin.setUsername(rs.getString("username"));
					   admin.setPassword(rs.getString("password"));
			        }
				   	
				 
					return admin;
				  
			}catch(SQLException e) {
				printSQLException(e);
			}
	
		return null;
		 
	}
	
	
	
	
	
	private void printSQLException(SQLException ex) {
		for (Throwable e1 : ex) {
			if (e1 instanceof SQLException) {
				e1.printStackTrace(System.err);
				System.err.println("SQLState: " + ((SQLException) e1).getSQLState());
				System.err.println("Error Code: " + ((SQLException) e1).getErrorCode());
				System.err.println("Message: " + e1.getMessage());
				Throwable t = ex.getCause();
				while (t != null) {
					System.out.println("Cause: " + t);
					t = t.getCause();
				}
			}
		}

	}


	
}
