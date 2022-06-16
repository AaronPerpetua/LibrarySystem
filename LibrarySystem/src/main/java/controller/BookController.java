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

import dao.BookDAO;
import dao.LogDAO;
import model.BookModel;
import model.LogModel;
 
 

@WebServlet(urlPatterns = {"/book/getAllBooks", "/book/getSingleBook","/book/getAvailableBook", "/book/createSingleBook","/book/deleteSingleBook","/book/updateSingleBook","/book/getToBorrowBook","/book/getBorrowedBook","/book/confirmToBorrow","/book/setToForConfirmation","/book/setToAvailable","/book/viewBorrowBookStatus"})
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	private Gson gson = new Gson();
	private BookDAO bookDAO;
	private LogDAO logDAO;
 
	
	public void init() {
		bookDAO = new BookDAO();
		logDAO = new LogDAO();
	}
  
	  
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   
			String action = request.getServletPath();

		    try {
		    	switch (action) {
		    	case "/book/getAllBooks":
		    		getAllBooks(request, response);
		    		break;
		    	case "/book/getSingleBook":
		    		getSingleBook(request, response);
		    		break;
		    	case "/book/createSingleBook":
		    		addSingleBook(request, response);
		    		break;
		    	case "/book/deleteSingleBook":
		    		deleteSingleBook(request, response);
		    		break;
		    	case "/book/updateSingleBook":
		    		updateSingleBook(request,response);
		    		break;
		    	case "/book/getToBorrowBook":
		    		getToBorrowBook(request,response);
		    		break;
		    	case "/book/getBorrowedBook":
		    		getBorrowedBook(request,response);
		    		break;
		    		
		    	case "/book/confirmToBorrow":
		    		confirmToBorrow(request,response);
		    		break;
		 
		    	case "/book/setToAvailable":
		    		setToAvailable(request,response);
		    		break;
		    	case "/book/getAvailableBook":
		    		getAvailableBook(request,response);
		    		break;
		    	case "/book/setToForConfirmation":
		    		setToForConfirmation(request,response);
		    		break;
		    		
		    	case "/book/viewBorrowBookStatus":
		    		viewBorrowBookStatus(request,response);
		    		break;
		    	}
		    }catch (Exception ex) {
				throw new ServletException(ex);
			}
		    

		}


	private void viewBorrowBookStatus(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		
		try {
			BookModel book = bookDAO.viewBorrowBookStatus(id);
			
			String result = gson.toJson(book);
			 
		 	PrintWriter out = response.getWriter();
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        out.print(result);
	        out.flush();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
			
		}


	private void setToForConfirmation(HttpServletRequest request, HttpServletResponse response) {
		String id = request.getParameter("id");
		String status = "For Confirmation";
			
		try {
			
			  BookModel book = new BookModel(id,status);
			  
			  bookDAO.setToForConfirmation(book);
			 		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		}


	private void getAvailableBook(HttpServletRequest request, HttpServletResponse response) {
		try {
			 
			List<BookModel> getAvailableBook = bookDAO.getAvailableBook();
			
			
			Gson gson = new GsonBuilder().create();
			JsonArray jarray = gson.toJsonTree(getAvailableBook).getAsJsonArray();
			JsonObject jsonObject = new JsonObject();
			jsonObject.add("data", jarray);

			
			  PrintWriter out = response.getWriter();
			  out.print(jsonObject.toString());
			 
			
			
		}catch(Exception e) {
			System.out.println("cant connect to database");
		}
			
		}


	private void setToAvailable(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String status = "Available";
			
		try {
			
			  BookModel book = new BookModel(id,status);
			  
			  bookDAO.setToAvailable(book);
			 		
		}catch(Exception e) {
			e.printStackTrace();
		}
			
		}


	private void confirmToBorrow(HttpServletRequest request, HttpServletResponse response) {
		
		String id = request.getParameter("id");
		String status = "Borrowed";
			
		try {
			
			  BookModel book = new BookModel(id,status);
			  
			  bookDAO.confirmToBorrow(book);
			 		
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		}


	private void getBorrowedBook(HttpServletRequest request, HttpServletResponse response) {
		try {

			  List<LogModel> getBorrowedBook = logDAO.getBorrowedBook();
			  
			  Gson gson = new GsonBuilder().create(); 
			  JsonArray jarray =  gson.toJsonTree(getBorrowedBook).getAsJsonArray(); 
			  JsonObject jsonObject = new JsonObject(); 
			  jsonObject.add("data", jarray);
			  
			  PrintWriter out = response.getWriter(); 
			  out.print(jsonObject.toString());
			 

		}catch(Exception e) {
			System.out.println("cant catch to database");
		}
			
		}


	private void getToBorrowBook(HttpServletRequest request, HttpServletResponse response) {
			 
		try {

			  List<LogModel> getToBorrowBook = logDAO.getToBorrowBook();
			  
			  Gson gson = new GsonBuilder().create(); 
			  JsonArray jarray =  gson.toJsonTree(getToBorrowBook).getAsJsonArray(); 
			  JsonObject jsonObject = new JsonObject(); 
			  jsonObject.add("data", jarray);
			  
			  PrintWriter out = response.getWriter(); 
			  out.print(jsonObject.toString());
			 

		}catch(Exception e) {
			System.out.println("cant catch to database");
		}
		
		}


	private void updateSingleBook(HttpServletRequest request, HttpServletResponse response) {
		
		
		  String id = request.getParameter("id"); 
		  String title = request.getParameter("title");
		  String author = request.getParameter("author");
		  String publisher = request.getParameter("publisher");
		  String description = request.getParameter("description");
		  
		  String category = request.getParameter("category");
		  
		  String page_total = request.getParameter("pagetotal"); 
		  String status = request.getParameter("status"); 
		  String created_at =request.getParameter("created_at");
		 
		 
	
		
		try {
			
			  BookModel updatedBook = new BookModel(id,title,author,publisher,category,description,page_total,status, created_at);
			  
			  bookDAO.updateSingleBook(updatedBook);
			 
		
			String result = gson.toJson(author);
			 
		 	PrintWriter out = response.getWriter();
	        response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        out.print(result);
	        out.flush();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
			
 
			
		}


	private void deleteSingleBook(HttpServletRequest request, HttpServletResponse response) {
			
			String id = request.getParameter("id");
			
			try {
				
				 bookDAO.deleteSingleBook(id);
					
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}


		private void addSingleBook(HttpServletRequest request, HttpServletResponse response) {
			 
			String title = request.getParameter("title");
			String author = request.getParameter("author");
			String publisher = request.getParameter("publisher");
			String description = request.getParameter("description");
			String page_total = request.getParameter("pagetotal");
			String category = request.getParameter("category");
			
			LocalDateTime myDateObj = LocalDateTime.now();  
		  
		    DateTimeFormatter myFormatObj = DateTimeFormatter.ofPattern("yyyy MM dd HH:mm:ss");  
		    
		    String created_at = myDateObj.format(myFormatObj);  
		    
			String status = "Available";
			
			try {    //title,author,publisher,description,page_total,status,created_at
				BookModel newBook = new BookModel(category,title,author,publisher,description,page_total,status,created_at);
				
				bookDAO.createBook(newBook);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}


		private void getSingleBook(HttpServletRequest request, HttpServletResponse response) {
			 
			String id = request.getParameter("id");
			
			try {
				BookModel book = bookDAO.getSingleBook(id);
				
				String result = gson.toJson(book);
				 
			 	PrintWriter out = response.getWriter();
		        response.setContentType("application/json");
		        response.setCharacterEncoding("UTF-8");
		        out.print(result);
		        out.flush();
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}


		private void getAllBooks(HttpServletRequest request, HttpServletResponse response) {
			 			
			try {
				 
				List<BookModel> allBooks = bookDAO.getAllBooks();
				
				
				Gson gson = new GsonBuilder().create();
				JsonArray jarray = gson.toJsonTree(allBooks).getAsJsonArray();
				JsonObject jsonObject = new JsonObject();
				jsonObject.add("data", jarray);

				
				  PrintWriter out = response.getWriter();
				  out.print(jsonObject.toString());
				 
				
				
			}catch(Exception e) {
				System.out.println("cant connect to database");
			}
		}

 
	 
	


}
