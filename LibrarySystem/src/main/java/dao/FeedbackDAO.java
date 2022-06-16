package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.FeedbackModel;
 
 

public class FeedbackDAO {
	
	public FeedbackDAO() {
		
	}
	
	protected Connection getConnection() throws SQLException {
		Connection connection = null;

		new org.sqlite.JDBC();

		String jdbcURL = "jdbc:sqlite:D:\\sqlite\\miniproject.db";
		connection = DriverManager.getConnection(jdbcURL);

		System.out.println("Connection to SQLite has been established.");
		return connection;
	}

	public List<FeedbackModel> getAllFeedback(String user_id) {
		
	List<FeedbackModel> allFeedback = new ArrayList<>();
		
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM feedback WHERE user_id = "+user_id))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				FeedbackModel feedback = new FeedbackModel();

				feedback.setId(rs.getString("id"));
				feedback.setUser_id(rs.getString("user_id"));
				feedback.setUsername(rs.getString("username"));
				feedback.setMessage(rs.getString("message"));
				feedback.setCreated_at(rs.getString("created_at"));
			 
				allFeedback.add(feedback);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return allFeedback;
	}
	
	public List<FeedbackModel> getAllUsersFeedback() {
			List<FeedbackModel> allFeedback = new ArrayList<>();
		
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM feedback  "))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				FeedbackModel feedback = new FeedbackModel();

				feedback.setId(rs.getString("id"));
				feedback.setUser_id(rs.getString("user_id"));
				feedback.setUsername(rs.getString("username"));
				feedback.setMessage(rs.getString("message"));
				feedback.setCreated_at(rs.getString("created_at"));
			 
				allFeedback.add(feedback);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return allFeedback;
	}

	
	public FeedbackModel getSingleFeedback(String id) {
	
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("SELECT * FROM feedback WHERE id = ?")) {
			ps.setString(1, id);

			ResultSet rs = ps.executeQuery();

			FeedbackModel feedback = null;

			if (rs.next()) {
				feedback = new FeedbackModel();

				feedback.setId(rs.getString("id"));
		
				feedback.setMessage(rs.getString("message"));
				feedback.setCreated_at(rs.getString("created_at"));
			 

			}

			return feedback;

		} catch (SQLException e) {
			printSQLException(e);
		}

		return null;
	}
	
	public boolean deleteSingleUser(String id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("DELETE FROM feedback WHERE id = ?");) {
			ps.setString(1, id);
			rowDeleted = ps.executeUpdate() > 0;
		}
		return rowDeleted;
	}


	public void createFeedback(FeedbackModel newFeedback) {
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement(
						"INSERT INTO feedback (user_id,username,message,created_at) VALUES (?,?,?,?)")) {
		 
			ps.setString(1, newFeedback.getUser_id());
			ps.setString(2, newFeedback.getUsername());
			ps.setString(3, newFeedback.getMessage());
			ps.setString(4, newFeedback.getCreated_at());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
