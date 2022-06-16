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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import dao.FeedbackDAO;
 
import model.FeedbackModel;
 
 

 
@WebServlet(urlPatterns = {"/feedback/getAllFeedback","/feedback/getSingleFeedback","/feedback/deleteSingleFeedback","/feedback/addFeedback","/feedback/getAllUsersFeedback"})
public class FeedbackController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	
	private Gson gson = new Gson();
	private FeedbackDAO feedbackDAO;
	
	
	public void init() {
		feedbackDAO  =new FeedbackDAO();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getServletPath();
		
		 try { 
			  switch (action) { 
			  case "/feedback/getAllFeedback": 
				  getAllFeedback(request,response);
				  break;
				  
			  case "/feedback/getSingleFeedback":
				  getSingleFeedback(request,response);
				  break;
				  
			  case "/feedback/deleteSingleFeedback":
				  deleteSingleFeedback(request,response);
				  break;
				  
			  case "/feedback/addFeedback":
				  addFeedback(request,response);
				  break;
				  
			  case "/feedback/getAllUsersFeedback":
				  getAllUsersFeedback(request,response);
				  break;
			  

		    	}
		    }catch (Exception ex) {
				throw new ServletException(ex);
			}
	
	}

	private void getAllUsersFeedback(HttpServletRequest request, HttpServletResponse response) {
		  try {
			  
			  List<FeedbackModel> getAllUsersFeedback = feedbackDAO.getAllUsersFeedback();
			  
			  Gson gson = new GsonBuilder().create(); 
			  JsonArray jarray = gson.toJsonTree(getAllUsersFeedback).getAsJsonArray(); 
			  JsonObject jsonObject = new JsonObject(); 
			  jsonObject.add("data", jarray);
			  
			  PrintWriter out = response.getWriter(); 
			  out.print(jsonObject.toString());
			  
			  
			  }catch(Exception e) {
				  System.out.println("cant catch to database"); 
				  }
			 
		
	}

	private void addFeedback(HttpServletRequest request, HttpServletResponse response) {
		String message = request.getParameter("message");
		String user_id = request.getParameter("user_id");
		String username = request.getParameter("username");
	
		
		LocalDateTime myDateObj = LocalDateTime.now();  
	  
	    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");  
	    
	    String created_at = myDateObj.format(myFormatObj);  
		
		try {    //title,author,publisher,description,page_total,status,created_at
			FeedbackModel newFeedback = new FeedbackModel(user_id,username,message,created_at);
			
			feedbackDAO.createFeedback(newFeedback);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	private void deleteSingleFeedback(HttpServletRequest request, HttpServletResponse response) {
			String id = request.getParameter("id");
		
			try {
				
				 feedbackDAO.deleteSingleUser(id);
					
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		
	}

	private void getSingleFeedback(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		try {
			FeedbackModel feedback = feedbackDAO.getSingleFeedback(id);
			
			String result = gson.toJson(feedback);
			 
		 	PrintWriter out = response.getWriter();
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        out.print(result);
	        out.flush();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
	}

	private void getAllFeedback(HttpServletRequest request, HttpServletResponse response) {
		 
		String user_id = request.getParameter("user_id");
		  try {
		  
		  List<FeedbackModel> allfeedback = feedbackDAO.getAllFeedback(user_id);
		  
		  Gson gson = new GsonBuilder().create(); 
		  JsonArray jarray = gson.toJsonTree(allfeedback).getAsJsonArray(); 
		  JsonObject jsonObject = new JsonObject(); 
		  jsonObject.add("data", jarray);
		  
		  PrintWriter out = response.getWriter(); 
		  out.print(jsonObject.toString());
		  
		  
		  }catch(Exception e) {
			  System.out.println("cant catch to database"); 
			  }
		 
		
	 
	}

 

}
