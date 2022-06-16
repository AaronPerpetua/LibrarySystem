<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ page session="true" %>
<%
	response.setHeader("Cache-Control","no-cache"); 
	response.setHeader("Pragma","no-cache"); 
	response.setDateHeader ("Expires", -1);
%>
 <% 
	if(session.getAttribute("user_id")== null){
	response.sendRedirect("../"); }%>    
 
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='pragma' content='no-cache'>
    <title>Library System</title>

 
    <!-- Bootstrap CSS CDN -->
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">  
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
     <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
     <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>
     <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    
   </head>

<body>
<br><br>
 <jsp:include page="navBarMenu.jsp" />  


<br> 

 
 <div class="container">
 	<div class="row">
 		<div class="col">
 		
 		 <!-- user's user_id from session -->
 		 	<input type=hidden class="form-control" id="user_id" name="user_id" value="${sessionScope.user_id}">
 		  
 		</div>
 		<div class="col-12">
 	            <button type="button" class="btn btn-dark"  id="refresh" name="refresh">
					Refresh
						</button>
				 
					<div class="card">
					 <div class="card-header bg-dark text-bg-secondary " >
							 List of All Available Books   
					  </div>
					 
					  <div class="card-body">
					    <table class="table table-hover table-sm table-responsive" style="width:100%" id="datatable" >
						 
					        <thead>
					            <tr>
					                <th scope="col">Book ID</th>
					                <th scope="col">Title</th>
					                <th scope="col">Author</th>
					                <th scope="col">Publisher</th>
					                <th scope="col">Status</th>
					                <th scope="col">Date Added</th>
					                 <th scope="col">Action</th>
					            </tr>
					        </thead>
					    
					    </table>
					  </div>
					</div>
 
 		</div>
 	</div>
</div>

       <!-- Modal view Book  -->
<div class="modal fade  modal-xl" id="viewbook-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">View Book Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">     
    	  <div class="card">
   		<div class="card-body">  
      <div class="row">
      	<div class="col-6">
      	
      	    <div class="mb-2">
			    <label for="id" class="form-label">Book ID</label>
			    <input type="text" class="form-control" id="id"   name="id" disabled>
			   
			  </div>
			    <div class="mb-2">
			    <label for="title" class="form-label">Title</label>
			    <input type="text" class="form-control" id="title"   name="title" disabled>
			   
			  </div>
			  <div class="mb-2">
			    <label for="author" class="form-label">Author</label>
			    <input type="text" class="form-control" id="author" name="author" disabled> 
			  </div>
			    <div class="mb-2">
			    <label for="publisher" class="form-label">Publisher</label>
			    <input type="text" class="form-control" id="publisher" name="publisher" disabled> 
			  </div>
			     <div class="mb-2">
			    <label for="status" class="form-label">Status</label>
			    <input type="text" class="form-control" id="status" name="status" disabled> 
			  </div>
      	
	      	</div>
	      	
	      	<div class="col-6">
      		      	  <div class="mb-2">
			    <label for="description" class="form-label">Description</label>
			    <textarea class="form-control"  rows="8" name="description" id ="description" disabled></textarea>
			     
			  </div>
			  <div class="mb-2">
			    <label for="pagetotal" class="form-label">Page Total</label>
			    <input type="number" class="form-control" id="pagetotal" name="pagetotal" disabled>
			  </div>
			    <div class="mb-2">
			    <label for="created_at" class="form-label">Date Added</label>
			    <input type="text" class="form-control" id="created_at" name="created_at" disabled>
			  </div>
      	</div>
      </div>
      </div>
         </div>
            </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>   
      </div>
    </div>
  </div>
</div> 
 	
 	

 
 

 

	 <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>	
     <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
  	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
 	 <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
 	 <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
 	 <script type="text/javascript"><%@include file="/WEB-INF/js/user/dashboard.js"%></script>

</body>
</html>