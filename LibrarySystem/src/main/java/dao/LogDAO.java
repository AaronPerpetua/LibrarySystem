package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

 
import model.LogModel;
 

public class LogDAO {
	
	
	public LogDAO() {
		
	}
	
	protected Connection getConnection() throws SQLException {
		Connection connection = null;

		new org.sqlite.JDBC();

		String jdbcURL = "jdbc:sqlite:D:\\sqlite\\miniproject.db";
		connection = DriverManager.getConnection(jdbcURL);

		System.out.println("Connection to SQLite has been established.");
		return connection;
	}

	public List<LogModel> getAllLogs() {
		
	List<LogModel> allLogs = new ArrayList<>();
		
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("select logs.id,logs.book_id, logs.book_title, logs.status, logs.transaction_date, users.id as user_id ,users.username, users.firstname, users.lastname from logs left join users on logs.user_id = users.id"))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				LogModel log = new LogModel();

				log.setId(rs.getString("id"));
				log.setBook_id(rs.getString("book_id"));
				log.setBook_title(rs.getString("book_title"));
				log.setUsername(rs.getString("username"));
				log.setFirstname(rs.getString("firstname"));
				log.setLastname(rs.getString("lastname"));
				log.setUser_id(rs.getString("user_id"));
				log.setStatus(rs.getString("status"));
				log.setTransaction_date(rs.getString("transaction_date"));
			 
				

				allLogs.add(log);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return allLogs;
	}
	
	
	public List<LogModel> getToBorrowBook() {
		
			List<LogModel> getToBorrowBook = new ArrayList<>();
		
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("select logs.id,logs.book_id, logs.book_title, logs.status, logs.transaction_date, users.id as user_id ,users.username, users.firstname, users.lastname from logs left join users on logs.user_id = users.id WHERE status = 'For Confirmation'"))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				LogModel log = new LogModel();

				log.setId(rs.getString("id"));
				log.setBook_id(rs.getString("book_id"));
				log.setBook_title(rs.getString("book_title"));
				log.setUser_id(rs.getString("user_id"));
				log.setUsername(rs.getString("username"));
				log.setFirstname(rs.getString("firstname"));
				log.setLastname(rs.getString("lastname"));
				log.setStatus(rs.getString("status"));
				log.setTransaction_date(rs.getString("transaction_date"));
			 
				

				getToBorrowBook.add(log);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return getToBorrowBook;
	}

	public List<LogModel> getBorrowedBook() {

		List<LogModel> getBorrowedBook = new ArrayList<>();
	
	try (Connection conn = getConnection();
			PreparedStatement ps = conn.prepareStatement("select logs.id,logs.book_id, logs.book_title, logs.status, logs.transaction_date, users.id as user_id ,users.username, users.firstname, users.lastname from logs left join users on logs.user_id = users.id WHERE status = 'Borrowed'"))

	{
		ResultSet rs = ps.executeQuery();

		while (rs.next()) {

			LogModel log = new LogModel();

			log.setId(rs.getString("id"));
			log.setBook_id(rs.getString("book_id"));
			log.setBook_title(rs.getString("book_title"));
			log.setUser_id(rs.getString("user_id"));
			log.setUsername(rs.getString("username"));
			log.setFirstname(rs.getString("firstname"));
			log.setLastname(rs.getString("lastname"));
			log.setStatus(rs.getString("status"));
			log.setTransaction_date(rs.getString("transaction_date"));
		 
			

			getBorrowedBook.add(log);
		}

	} catch (SQLException e) {
		printSQLException(e);
	}
	
	return getBorrowedBook;
	}

 
	public void updateLog(LogModel updateLog) {
		 
		try (Connection connection = getConnection();
				PreparedStatement ps = connection
						.prepareStatement("UPDATE logs SET status=?, transaction_date = ? WHERE id = ?");) {

			ps.setString(1, updateLog.getStatus());
			ps.setString(2, updateLog.getTransaction_date());
			ps.setString(3, updateLog.getId());
	 

			ps.executeUpdate();

		} catch (SQLException e) {
			printSQLException(e);

		}
	}
	
	public void createLog(LogModel newLog) {
		
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement(
						"INSERT INTO logs (book_id,book_title,user_id,status,transaction_date) VALUES (?,?,?,?,?)")) {
			// title,author,publisher,description,page_total,status
			ps.setString(1, newLog.getBook_id());
			ps.setString(2, newLog.getBook_title());
			ps.setString(3, newLog.getUser_id());
			ps.setString(4, newLog.getStatus());
			ps.setString(5, newLog.getTransaction_date());

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		 
		
	}

	


	public List<LogModel> getBorrowBooks(String user_id) {
		
	List<LogModel> getBorrowBooks = new ArrayList<>();
	
	
		
		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("select logs.id,logs.book_id, logs.book_title, logs.status, logs.transaction_date, users.id as user_id ,users.username, users.firstname, users.lastname from logs left join users on logs.user_id = users.id where user_id = "+user_id ))

		{
		 
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				LogModel log = new LogModel();

				log.setId(rs.getString("id"));
				log.setBook_id(rs.getString("book_id"));
				log.setBook_title(rs.getString("book_title"));
				log.setUser_id(rs.getString("user_id"));
				log.setUsername(rs.getString("username"));;
				log.setStatus(rs.getString("status"));
				log.setTransaction_date(rs.getString("transaction_date"));
			 
				

				getBorrowBooks.add(log);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		
		return getBorrowBooks;
		 
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
