package model;

public class LogModel {
	
	
	private String id;
	private String book_id;
	private String book_title;
	private String user_id;
	private String username;
	private String firstname;
	private String lastname;
	private String transaction_date;
	private String status;
 
	
	public LogModel() {
		
	}
							 //displaying all logs
	public LogModel(String id, String book_id, String book_title, String user_id, String status, String transaction_date) {
		super();
		this.id = id;
		this.book_id = book_id;
		this.book_title = book_title;
		this.user_id = user_id;
		this.status = status;
		this.transaction_date = transaction_date;
 
	}
						//updating the logs status
	public LogModel( String id, String status,String transaction_date) {
		super();
	 
		this.id = id;
		this.status = status;
		this.transaction_date = transaction_date;
	 
 
	}
	
			//creating new logs
		public LogModel( String book_id,String book_title, String user_id, String status,String transaction_date) {
		super();
		
		this.book_id = book_id;
		this.book_title = book_title;
		this.user_id = user_id;
		this.status = status;
		this.transaction_date = transaction_date;

		}




	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getBook_id() {
		return book_id;
	}



	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}



	public String getBook_title() {
		return book_title;
	}



	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getFirstname() {
		return firstname;
	}



	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}



	public String getLastname() {
		return lastname;
	}



	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}

	public String getTransaction_date() {
		return transaction_date;
	}



	public void setTransaction_date(String transaction_date) {
		this.transaction_date = transaction_date;
	}



 
	
	
	

}
