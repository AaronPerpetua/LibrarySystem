package controller;

import java.io.IOException;
import java.io.PrintWriter;
 
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
 
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import dao.LogDAO;
import dao.UserDAO;
import model.BookModel;
import model.LogModel;
 
import model.UserModel;

 
@WebServlet(urlPatterns = {"/user/UpdateProfile","/user/getAllUsers", "/user/createSingleUser","/user/getSingleUser","/user/deleteSingleUser","/user/getBorrowBooks","/user/userLogin","/user/userLogout"})
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Gson gson = new Gson();
	private UserDAO userDAO;
	private LogDAO logDAO;
	
	public void init() {
		userDAO = new UserDAO();
		logDAO = new LogDAO();
	}

	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
	    String action = request.getServletPath();
	    

		  try { 
			  switch (action) { 
			  case "/user/getAllUsers": 
				  getAllUsers(request,response);
				  break;
			  
			  case "/user/createSingleUser":
				  addSingleUser(request,response);
				  break;
				 
			  case "/user/getSingleUser":
				  getSingleUser(request,response);
				  break;
				  
			  case "/user/deleteSingleUser":
				  deleteSingleUser(request,response);
				  break;
			  case "/user/getBorrowBooks":
				  getBorrowBooks(request,response);
				  break;
				  
			  case "/user/UpdateProfile":
				  updateProfile(request,response);
				  break;
				  
			  case "/user/userLogin":
				  userLogin(request,response);
				  break;
				  
			  case "/user/userLogout":
				  userLogout(request,response);
				  break;
				  
			
			  
		    	}
		    }catch (Exception ex) {
				throw new ServletException(ex);
			}
		    

	}


	private void updateProfile(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("user_id");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String gender = request.getParameter("gender");
		String age = request.getParameter("age");
		String contact_number = request.getParameter("contact_number");
		String address = request.getParameter("address");
		String created_at = request.getParameter("created_at");
			 
		

		try {  
			
			UserModel updateUser = new UserModel(id,username,password,email,firstname,lastname,gender,contact_number,age,address,created_at);
			
			userDAO.updateUserProfile(updateUser);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}


	private void userLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
	 
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect("/LibrarySystem");
	}


	private void userLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
		try {
			UserModel user = userDAO.checklogin(username, password);
			
			if(user != null ) {
				
				String user_id = user.getId();
				
				
				
				HttpSession session = request.getSession(true);
				session.setAttribute("user_id",user_id);
				session.setAttribute("username",username);
				
				String data = "success";
				String res = gson.toJson(data);
		        out.print(res);
		        out.flush();
		        
	
			
			}else {
				String message = "Invalid Username & Password";
				String ex = gson.toJson(message);
				out.print(ex);
		        out.flush();
			}

	        
		}catch(Exception e) {
		 
			String ex = gson.toJson(e);
	        out.print(ex);
	        out.flush();
		}

		
		
	}


	private void getBorrowBooks(HttpServletRequest request, HttpServletResponse response) {
		String user_id = request.getParameter("user_id");
		 
		try {

			  List<LogModel> getBorrowBooks = logDAO.getBorrowBooks(user_id);
			  
			  Gson gson = new GsonBuilder().create(); 
			  JsonArray jarray =  gson.toJsonTree(getBorrowBooks).getAsJsonArray(); 
			  JsonObject jsonObject = new JsonObject(); 
			  jsonObject.add("data", jarray);
			  
			  PrintWriter out = response.getWriter(); 
			  out.print(jsonObject.toString());
			 

		}catch(Exception e) {
			System.out.println("cant catch to database");
		}
	 
		
	}


	private void deleteSingleUser(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		
		try {
			
			 userDAO.deleteSingleUser(id);
				
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}


	private void getSingleUser(HttpServletRequest request, HttpServletResponse response) {
	 
		String id = request.getParameter("id");
		
		try {
			UserModel user = userDAO.getSingleUser(id);
			
			String result = gson.toJson(user);
			 
		 	PrintWriter out = response.getWriter();
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        out.print(result);
	        out.flush();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}


	private void addSingleUser(HttpServletRequest request, HttpServletResponse response) {
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String gender = request.getParameter("gender");
		String age = request.getParameter("age");
		String contact_number = request.getParameter("contact_number");
		String address = request.getParameter("address");
		
		LocalDateTime myDateObj = LocalDateTime.now();    
	    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");  
	    
	    String created_at = myDateObj.format(myFormatObj);  
	    
		try {  
			
			UserModel newUser = new UserModel(username,password,email,firstname,lastname,gender,contact_number,age,address,created_at);
	
			userDAO.createUser(newUser);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	    
	}


	private void getAllUsers(HttpServletRequest request, HttpServletResponse response) {
		 
		try {

			  List<UserModel> allUsers = userDAO.getAllUsers();
			  
			  Gson gson = new GsonBuilder().create(); 
			  JsonArray jarray =  gson.toJsonTree(allUsers).getAsJsonArray(); 
			  JsonObject jsonObject = new JsonObject(); 
			  jsonObject.add("data", jarray);
			  
			  PrintWriter out = response.getWriter(); 
			  out.print(jsonObject.toString());
			 

		}catch(Exception e) {
			System.out.println("cant catch to database");
		}
	}

	 

}
