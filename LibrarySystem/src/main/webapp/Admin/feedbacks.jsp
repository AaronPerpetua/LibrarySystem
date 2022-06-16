<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

    <title>Library System</title>

 
    <!-- Bootstrap CSS CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">  
   <!-- Our Custom CSS -->
	<style><%@include file="/WEB-INF/css/styles.css"%></style>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css">
    
   </head>

<body>
    <div class="wrapper">
        <!-- Sidebar  -->
 			 <jsp:include page="sideBarMenu.jsp" />  

        <!-- Page Content  -->
        <div id="content">

            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                   <h2>Feedback Page  <i class="bi bi-rss-fill"></i></h2>            
                </div>
            </nav>
            	   <button type="button" class="btn btn-dark"  id="refresh" name="refresh">
						 Refresh
						</button>
				     
					<div class="card">
					 		  <div class="card-header bg-dark text-bg-secondary " >
					    List of All Books
					  </div>
					  <div class="card-body">
					      <table class="table table-hover table-sm table-responsive" style="width:100%" id="datatable" >
						  <thead>
						    <tr>
						      <th scope="col">ID</th>
						      <th scope="col">User ID</th>
					          <th scope="col">Username</th>
					          <th scope="col">Message</th>
					          <th scope="col"> Date</th>
					          <th scope="col" style="text-align: center; vertical-align: middle;">Action</th>
						        
						    </tr>
						  </thead>
			 
						</table>
					  </div>
					</div>
		        </div>
		    </div>
    
  

      <!--  Modal view Feedback  -->
<div class="modal fade  modal-xl" id="viewfeedback-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">View Feedback Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">     
    	  <div class="card">
   		<div class="card-body">  
      <div class="row">
      	<div class="col-6">
      	     <div class="mb-2">
			    <label for="id" class="form-label">Feedback ID</label>
			    <input type="text" class="form-control" id="id"   name="id" disabled>
			  </div>
			   <div class="mb-2">
			    <label for="user_id" class="form-label">User ID</label>
			    <input type="text" class="form-control" id="user_id" name="user_id"    disabled> 
			   </div>
	      	    <div class="mb-2">
			    <label for="username" class="form-label">Username</label>
			    <input type="text" class="form-control" id="username" name="username" disabled > 
			  </div>
	  		</div>
	  		<div class="col-6">
	  
			 <div class="mb-2">
			    <label for="created_at" class="form-label">Feedback Date</label>
			    <input type="text" class="form-control" id="created_at" name="created_at"  disabled>
			  </div>
			     <div class="mb-2">
			    <label for="message" class="form-label">Message</label>
			     <textarea class="form-control"  rows="5" name="message" id="message"  disabled></textarea>
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
 	<script type="text/javascript"><%@include file="/WEB-INF/js/admin/feedback.js"%></script>

</body>
</html>