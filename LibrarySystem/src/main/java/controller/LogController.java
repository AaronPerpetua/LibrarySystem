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

import dao.LogDAO;
 
import model.LogModel;
 
 

 
@WebServlet(urlPatterns= {"/log/getAllLogs","/log/updateLogs", "/log/setToCancelled","/log/setToReturned","/log/createLog"})
public class LogController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	//private Gson gson = new Gson();
	private LogDAO logDAO;
	
	public void init() {
		logDAO = new LogDAO();
	}
	 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
 
		 String action = request.getServletPath();
		 
		  try { 
			  switch (action) { 
			  case "/log/getAllLogs": 
				  getAllLogs(request,response);
				  break;
				  
			  case "/log/updateLogs": 
				  updateLogs(request,response);
				  break;
				  
	 
			  case "/log/setToCancelled": 
				  setToCancelled(request,response);
				  break;
				  
			  case "/log/setToReturned": 
				  setToReturned(request,response);
				  break;
				  
			  case "/log/createLog": 
				  createLog(request,response);
				  break;
				  
			  }
			  
		    }catch (Exception ex) {
				throw new ServletException(ex);
			}
		    
		
	}

 

	private void createLog(HttpServletRequest request, HttpServletResponse response) {

		String book_id = request.getParameter("book_id");
		String book_title = request.getParameter("book_title");
		String user_id = request.getParameter("user_id");
		String status = "For Confirmation";
	 
		
		LocalDateTime myDateObj = LocalDateTime.now();    
	    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");  
	    
	    String transaction_date = myDateObj.format(myFormatObj); 
	    
	    
		try {  
			
			LogModel newLog = new LogModel(book_id,book_title,user_id,status,transaction_date);
			
			logDAO.createLog(newLog);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	private void setToReturned(HttpServletRequest request, HttpServletResponse response) {
		  try { 
			  
			  String id = request.getParameter("id");

			  LocalDateTime myDateObj = LocalDateTime.now();
			  
			  DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");
			  
			  String transaction_date = myDateObj.format(myFormatObj); 
			  
			  String status = "Returned";
			
			  LogModel updateLog = new LogModel(id,status,transaction_date);
			  
			  logDAO.updateLog(updateLog);
			 
				 
			
		
		  }catch(Exception e) { 
			  e.printStackTrace(); 
			  }
		 
		
	}

	private void setToCancelled(HttpServletRequest request, HttpServletResponse response) {
		  
		  try { 
		  
			  String id = request.getParameter("id");

			  LocalDateTime myDateObj = LocalDateTime.now();
			  
			  DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");
			  
			  String transaction_date = myDateObj.format(myFormatObj); 
			  
			  String status = "Cancelled";
			
			  LogModel updateLog = new LogModel(id,status,transaction_date);
			  
			  logDAO.updateLog(updateLog);
			 
				 
			
		
		  }catch(Exception e) { 
			  e.printStackTrace(); 
			  }
		 
		
		
		
	}

 

	private void updateLogs(HttpServletRequest request, HttpServletResponse response) {
		 
		  try { 
		  
			  String id = request.getParameter("id");

			  LocalDateTime myDateObj = LocalDateTime.now();
			  
			  DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");
			  
			  String transaction_date = myDateObj.format(myFormatObj); 
			  
			  String status = "Borrowed";
			
			  LogModel updateLog = new LogModel(id,status,transaction_date);
			  
			  logDAO.updateLog(updateLog);
			 
				 
			
		
		  }catch(Exception e) { 
			  e.printStackTrace(); 
			  }
		 
		
		
		
		
	}

	private void getAllLogs(HttpServletRequest request, HttpServletResponse response) {
		
		try {

			  List<LogModel> allLogs = logDAO.getAllLogs();
			  
			  Gson gson = new GsonBuilder().create(); 
			  JsonArray jarray =  gson.toJsonTree(allLogs).getAsJsonArray(); 
			  JsonObject jsonObject = new JsonObject(); 
			  jsonObject.add("data", jarray);
			  
			  PrintWriter out = response.getWriter(); 
			  out.print(jsonObject.toString());
			 

		}catch(Exception e) {
			System.out.println("cant catch to database");
		}
		
	}

 

}
