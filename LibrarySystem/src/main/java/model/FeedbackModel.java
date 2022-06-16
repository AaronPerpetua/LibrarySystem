package model;

public class FeedbackModel {
	
	private String id;
 
	private String user_id;
	private String username;
	private String message;
	private String created_at;
	
	public FeedbackModel() {
		
	}
	//for selecting single feedback and displaying all feedback
	public FeedbackModel(String id,String user_id, String username, String message,
			String created_at) {
		super();
		this.id = id;
		this.user_id = user_id;
		this.username = username;
		this.message = message;
		this.created_at = created_at;
	}
	
	public FeedbackModel(String user_id,String username,String message,String created_at) {
		super();
		this.user_id = user_id;
		this.username = username;
		this.message = message;
		this.created_at = created_at;
		
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}

	
	
	 



	 
}
