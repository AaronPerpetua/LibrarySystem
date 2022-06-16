package model;

public class UserModel {
	
	private String id;
	private String username;
	private String password;
	private String email;
	private String firstname;
	private String lastname;
	private String gender;
	private String contact_number;
	private String age;
	private String address;
	private String created_at;
	
	public UserModel() {
		
	}
					//id,username,password,email,firstname,lastname,gender,contact_number,age,address,created_at
	//for selecting single user and displaying all users
	public UserModel(String id, String username, String password, String email, String firstname, String lastname,
			String gender, String contact_number, String age, String address, String created_at) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.email = email;
		this.firstname = firstname;
		this.lastname = lastname;
		this.gender = gender;
		this.contact_number = contact_number;
		this.age = age;
		this.address = address;
		this.created_at = created_at;
	}


	//for creating new user      id,username,password,email,firstname,lastname,gender,contact_number,age,address
	public UserModel(String username, String password, String email, String firstname, String lastname, String gender,
			String contact_number, String age, String address, String created_at) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		this.firstname = firstname;
		this.lastname = lastname;
		this.gender = gender;
		this.contact_number = contact_number;
		this.age = age;
		this.address = address;
		this.created_at = created_at;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getContact_number() {
		return contact_number;
	}

	public void setContact_number(String contact_number) {
		this.contact_number = contact_number;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCreated_at() {
		return created_at;
	}

	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	
	
	
}
