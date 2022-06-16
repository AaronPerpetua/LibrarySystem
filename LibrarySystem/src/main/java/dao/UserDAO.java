package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

 
import model.UserModel;

public class UserDAO {
	
	public UserDAO() {
		
	}
	
	protected Connection getConnection() throws SQLException {
		Connection connection = null;

		new org.sqlite.JDBC();

		String jdbcURL = "jdbc:sqlite:D:\\sqlite\\miniproject.db";
		connection = DriverManager.getConnection(jdbcURL);

		System.out.println("Connection to SQLite has been established.");
		return connection;
	}

	public List<UserModel> getAllUsers() {
		 
		List<UserModel> allUsers = new ArrayList<>();
		
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM users"))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				UserModel user = new UserModel();

				user.setId(rs.getString("id"));
				user.setUsername(rs.getString("username"));
				user.setFirstname(rs.getString("firstname"));
				user.setLastname(rs.getString("lastname"));
				user.setEmail(rs.getString("email"));
				user.setGender(rs.getString("gender"));
				user.setContact_number(rs.getString("contact_number"));
				

				allUsers.add(user);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return allUsers;
	}

	
	public void createUser(UserModel newUser) {
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement(
						"INSERT INTO users (username,password,email,firstname,lastname,gender,age,contact_number,address,created_at) VALUES (?,?,?,?,?,?,?,?,?,?)")) {
			// title,author,publisher,description,page_total,status
			ps.setString(1, newUser.getUsername());
			ps.setString(2, newUser.getPassword());
			ps.setString(3, newUser.getEmail());
			ps.setString(4, newUser.getFirstname());
			ps.setString(5, newUser.getLastname());
			ps.setString(6, newUser.getGender());
			ps.setString(7, newUser.getAge());
			ps.setString(8, newUser.getContact_number());
			ps.setString(9, newUser.getAddress());
			ps.setString(10, newUser.getCreated_at());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public void updateUserProfile(UserModel updateUser) {
		try (Connection connection = getConnection();
				PreparedStatement ps = connection
						.prepareStatement("UPDATE users SET username = ?, password=?, email=?, firstname=?, lastname=?, gender=?, age=?, contact_number=?, address=? WHERE id =?")) {
			// title,author,publisher,description,page_total,status
			ps.setString(1, updateUser.getUsername());
			ps.setString(2, updateUser.getPassword());
			ps.setString(3, updateUser.getEmail());
			ps.setString(4, updateUser.getFirstname());
			ps.setString(5, updateUser.getLastname());
			ps.setString(6, updateUser.getGender());
			ps.setString(7, updateUser.getAge());
			ps.setString(8, updateUser.getContact_number());
			ps.setString(9, updateUser.getAddress());
			ps.setString(10, updateUser.getId());
		
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	
	public UserModel getSingleUser(String id) {
		
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("SELECT * FROM users WHERE id = ?")) {
			ps.setString(1, id);

			ResultSet rs = ps.executeQuery();

			UserModel user = null;

			if (rs.next()) {
				user = new UserModel();

				user.setId(rs.getString("id"));
				user.setUsername(rs.getString("username"));
				user.setPassword(rs.getString("password"));
				user.setEmail(rs.getString("email"));
				user.setFirstname(rs.getString("firstname"));
				user.setLastname(rs.getString("lastname"));
				user.setGender(rs.getString("gender"));
				user.setAge(rs.getString("age"));
				user.setContact_number(rs.getString("contact_number"));
				user.setAddress(rs.getString("address"));
				user.setCreated_at(rs.getString("created_at"));

			}

			return user;

		} catch (SQLException e) {
			printSQLException(e);
		}

		return null;
	}

	public boolean deleteSingleUser(String id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("DELETE FROM users WHERE id = ?");) {
			ps.setString(1, id);
			rowDeleted = ps.executeUpdate() > 0;
		}
		return rowDeleted;
	}

	public UserModel checklogin(String username, String password) {
		try(Connection connection = getConnection();
				 PreparedStatement ps = connection.prepareStatement("SELECT * FROM users WHERE username = ? and password = ? ")){
				 ps.setString(1,username);
				 ps.setString(2,password);
				 
				 ResultSet rs  = ps.executeQuery();
				 UserModel user = null ;
				 
				   if (rs.next()) {
			            user = new UserModel();
			            
			            user.setId(rs.getString("id"));
			            user.setFirstname(rs.getString("username"));
			            user.setPassword(rs.getString("password"));
			        }
				   	
				 
					return user;
				  
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
