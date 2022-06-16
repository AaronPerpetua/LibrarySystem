package model;

public class BookModel {
	
	private String id;
	private String title;
	private String description;
	private String author;
	private String publisher;
	private String page_total;
	private String status;
	private String created_at;
	private String category;
	
	public BookModel() {
		
	}
                          				//for selecting single book and displaying all books
	
										//id,title,author,publisher,category,description,page_total,status, created_at
	public BookModel(String id, String title, String author, String publisher, String category,  String description, String page_total,
			String status, String created_at) {
		super();
		this.id = id;    
		this.title = title;
		this.author = author;
		this.publisher = publisher;
		this.category = category;		
		this.description = description;
		this.page_total = page_total;
		this.status = status;
		this.created_at = created_at;
	}
	
										//for creating new book
	public BookModel(String category, String title,String author,String publisher,String description,String page_total,String status,String created_at) {
		super();
	
		this.category = category;
		this.title = title;
		this.description = description;
		this.author = author;
		this.publisher = publisher;
		this.page_total = page_total;
		this.status = status;
		this.created_at = created_at;
		 
	}
	
	public BookModel(String id,String status) {  // for changing book Status
		super();
	
		this.id = id;
		this.status = status;	 
	}
	
	public BookModel(String status) {  // for counting books
		super();

		this.status = status;	 
	}

 
 
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getPage_total() {
		return page_total;
	}

	public void setPage_total(String page_total) {
		this.page_total = page_total;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	
	

}
