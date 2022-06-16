package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonBuilderFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import dao.AdminDAO;
 
import model.AdminModel;
 



 
@WebServlet(urlPatterns= {"/admin/adminLogin","/admin/adminLogout","/admin/countAvailableBooks"})
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private Gson gson = new Gson();
	private AdminDAO adminDAO;
	 
 
	public void init() {
		adminDAO = new AdminDAO();
 
	 
	}

 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		String action = request.getServletPath();
		
		  try { 
			  switch (action) { 
			  case "/admin/adminLogin": 
				  adminLogin(request,response);
				  break;
			
			  case "/admin/adminLogout": 
				  adminLogout(request,response);
				  break;
				  
			  case "/admin/countAvailableBooks": 
				  countAvailableBooks(request,response);
				  break;
		
			  }
		    }catch (Exception ex) {
				throw new ServletException(ex);
			}
		    
		
	}
	
	protected Connection getConnection() throws SQLException {
		Connection connection = null;

		new org.sqlite.JDBC();

		String jdbcURL = "jdbc:sqlite:D:\\sqlite\\miniproject.db";
		connection = DriverManager.getConnection(jdbcURL);

		System.out.println("Connection to SQLite has been established.");
		return connection;
	}


	private void countAvailableBooks(HttpServletRequest request, HttpServletResponse response) {
	
		
		try(Connection connection = getConnection();
				 PreparedStatement ps1 = connection.prepareStatement("SELECT COUNT(status) FROM books WHERE status = 'Available'");
				 PreparedStatement ps2 = connection.prepareStatement("SELECT COUNT(status) FROM books WHERE status = 'For Confirmation'");
				 PreparedStatement ps3 = connection.prepareStatement("SELECT COUNT(status) FROM books WHERE status = 'Borrowed'");
				 PreparedStatement ps4 = connection.prepareStatement("SELECT COUNT(*) FROM users")){
			
	
				 ResultSet rs1 = ps1.executeQuery();
				 ResultSet rs2 = ps2.executeQuery();
				 ResultSet rs3 = ps3.executeQuery();
				 ResultSet rs4 = ps4.executeQuery();
 
				   rs1.next(); rs2.next(); rs3.next(); rs4.next();
				  
					    
				   String countAvailable = rs1.getString(1);
				   String countForConfirmation = rs2.getString(1);
				   String countBorrowed = rs3.getString(1);
				   String countUsers = rs4.getString(1);
		
			
				   javax.json.JsonArray value = Json.createArrayBuilder()
						   .add(Json.createObjectBuilder()
						       .add("countAvailable", countAvailable)
						       .add("countForConfirmation", countForConfirmation)
						       .add("countBorrowed", countBorrowed)
						       .add("countUsers", countUsers))
						   .build();
				
					PrintWriter out = response.getWriter();
			        response.setContentType("application/json");
			        response.setCharacterEncoding("UTF-8");
			        out.print(value);
			        out.flush();
				  
			}catch(Exception e) {
					e.printStackTrace();
			}
	
	 
		
	}


	private void adminLogout(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		session.invalidate();
		response.sendRedirect("/LibrarySystem");
	}


	private void adminLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
		try {
			AdminModel admin = adminDAO.checklogin(username, password);
			
			if(admin != null ) {
				
				String user_id = admin.getId();
				
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

 
 
	
	

}
