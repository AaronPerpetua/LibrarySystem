package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.BookModel;
 

public class BookDAO {

	public BookDAO() {

	}

	protected Connection getConnection() throws SQLException {
		Connection connection = null;

		new org.sqlite.JDBC();

		String jdbcURL = "jdbc:sqlite:D:\\sqlite\\miniproject.db";
		connection = DriverManager.getConnection(jdbcURL);

		System.out.println("Connection to SQLite has been established.");
		return connection;
	}

	public List<BookModel> getAllBooks() {

		List<BookModel> allBooks = new ArrayList<>();

		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM books "))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				BookModel book = new BookModel();

				book.setId(rs.getString("id"));
				book.setCategory(rs.getString("category"));
				book.setTitle(rs.getString("title"));
				book.setDescription(rs.getString("description"));
				book.setAuthor(rs.getString("author"));
				book.setPublisher(rs.getString("publisher"));
				book.setPage_total(rs.getString("page_total"));
				book.setStatus(rs.getString("status"));
				book.setCreated_at(rs.getString("created_at"));

				allBooks.add(book);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		return allBooks;

	}
	
	public List<BookModel> getAvailableBook() {
		List<BookModel> getAvailableBook = new ArrayList<>();

		try (Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE status = 'Available'"))

		{
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				BookModel book = new BookModel();

				book.setId(rs.getString("id"));
				book.setTitle(rs.getString("title"));
				book.setDescription(rs.getString("description"));
				book.setAuthor(rs.getString("author"));
				book.setPublisher(rs.getString("publisher"));
				book.setPage_total(rs.getString("page_total"));
				book.setStatus(rs.getString("status"));
				book.setCreated_at(rs.getString("created_at"));

				getAvailableBook.add(book);
			}

		} catch (SQLException e) {
			printSQLException(e);
		}
		return getAvailableBook;
	}


	public BookModel getSingleBook(String id) {
		
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("select * from books where id = ?")) {
			
			ps.setString(1, id);

			ResultSet rs = ps.executeQuery();

			BookModel book = null;

			if (rs.next()) {
				book = new BookModel();

				book.setId(rs.getString("id"));
				book.setCategory(rs.getString("category"));
				book.setTitle(rs.getString("title"));
				book.setDescription(rs.getString("description"));
				book.setAuthor(rs.getString("author"));
				book.setPublisher(rs.getString("publisher"));
				book.setPage_total(rs.getString("page_total"));
				book.setStatus(rs.getString("status"));
				book.setCreated_at(rs.getString("created_at"));

			}

			return book;

		} catch (SQLException e) {
			printSQLException(e);
		}

		return null;

	}
	
	public BookModel viewBorrowBookStatus(String id) {
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("select books.author, books.id as book_id, books.publisher, books.created_at, books.page_total, books.description, books.category, books.title,logs.status from books left join logs on books.id = logs.book_id where logs.id = ? ")) {
			
			ps.setString(1, id);

			ResultSet rs = ps.executeQuery();

			BookModel book = null;

			if (rs.next()) {
				book = new BookModel();

				book.setId(rs.getString("book_id"));
				book.setCategory(rs.getString("category"));
				book.setTitle(rs.getString("title"));
				book.setDescription(rs.getString("description"));
				book.setAuthor(rs.getString("author"));
				book.setPublisher(rs.getString("publisher"));
				book.setPage_total(rs.getString("page_total"));
				book.setStatus(rs.getString("status"));
				book.setCreated_at(rs.getString("created_at"));

			}

			return book;

		} catch (SQLException e) {
			printSQLException(e);
		}

		return null;
	}

	public void createBook(BookModel newBook) {
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement(
						"INSERT INTO books (category,title,author,publisher,description,page_total,status,created_at) VALUES (?,?,?,?,?,?,?,?)")) {
			// title,author,publisher,description,page_total,status
			
			ps.setString(1, newBook.getCategory());
			ps.setString(2, newBook.getTitle());
			ps.setString(3, newBook.getAuthor());
			ps.setString(4, newBook.getPublisher());
			ps.setString(5, newBook.getDescription());
			ps.setString(6, newBook.getPage_total());
			ps.setString(7, newBook.getStatus());
			ps.setString(8, newBook.getCreated_at());
			

			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateSingleBook(BookModel updatedBook) {

		try (Connection connection = getConnection();
				PreparedStatement ps = connection
						.prepareStatement("UPDATE books SET title = ?,author= ?, publisher=?, description=?, page_total=?, status=?, category= ?  WHERE id = ?")) {

			ps.setString(1, updatedBook.getTitle());
			ps.setString(2, updatedBook.getAuthor());
			ps.setString(3, updatedBook.getPublisher()); 
			ps.setString(4, updatedBook.getDescription()); 
			ps.setString(5, updatedBook.getPage_total());
			ps.setString(6, updatedBook.getStatus());	
			ps.setString(7, updatedBook.getCategory());
			ps.setString(8, updatedBook.getId());

			ps.executeUpdate();

		} catch (SQLException e) {
			printSQLException(e);

		}
	}
	
	public void confirmToBorrow(BookModel book) {
		
		try (Connection connection = getConnection();
				PreparedStatement ps = connection
						.prepareStatement("UPDATE books SET status=? WHERE id = ?");) {

			ps.setString(1, book.getStatus());
			ps.setString(2, book.getId());
	 

			ps.executeUpdate();

		} catch (SQLException e) {
			printSQLException(e);

		}
		 
	}
	
	public void setToAvailable(BookModel book) {
		
		try (Connection connection = getConnection();
				PreparedStatement ps = connection
						.prepareStatement("UPDATE books SET status=? WHERE id = ?");) {

			ps.setString(1, book.getStatus());
			ps.setString(2, book.getId());
	 

			ps.executeUpdate();

		} catch (SQLException e) {
			printSQLException(e);

		}
	}
	
	public void setToForConfirmation(BookModel book) {
		
		try (Connection connection = getConnection();
				PreparedStatement ps = connection
						.prepareStatement("UPDATE books SET status=? WHERE id = ?");) {

			ps.setString(1, book.getStatus());
			ps.setString(2, book.getId());
	 

			ps.executeUpdate();

		} catch (SQLException e) {
			printSQLException(e);

		}
		
	}



	public boolean deleteSingleBook(String id) throws SQLException {
		boolean rowDeleted;
		try (Connection connection = getConnection();
				PreparedStatement ps = connection.prepareStatement("DELETE FROM books WHERE id = ?");) {
			ps.setString(1, id);
			rowDeleted = ps.executeUpdate() > 0;
		}
		return rowDeleted;
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
