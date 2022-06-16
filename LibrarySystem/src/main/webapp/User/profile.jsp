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
 		 	<input type=hidden class="form-control" id="user_id" name="user_id" value=" ${sessionScope.user_id}">
 		  
 		</div>
 		<div class="col-12">
					<div class="card">
					 <div class="card-header bg-dark text-bg-secondary " >
							 User Profile  <i class="bi bi-person-bounding-box"></i>
					  </div>		  
					 	 <form  id="update-form" name="update-form">
   <div class="card-body">
    <div class="row">
      	<div class="col-6">
      	   <div class="mb-2">
			    <label for="user_id" class="form-label">User ID</label>
			    <input type="text" class="form-control" id="user_id"   name="user_id" disabled>
			    <input type=hidden class="form-control" id="user_id" name="user_id" value=" ${sessionScope.user_id}">
			  </div>
			     <div class="mb-2">
			    <label for="username" class="form-label">Username</label>
			    <input type="text" class="form-control" id="username"   name="username" required>
			  </div>
			  <div class="mb-2">
			    <label for="password" class="form-label">Password</label>
			    <input type="password" class="form-control" id="password" name="password" required> 
			  </div>
			    <div class="mb-2">
			    <label for="email" class="form-label">Email</label>
			    <input type="email" class="form-control" id="email" name="email" required > 
			  </div>
			  <div class="mb-2">
			    <label for="firstname" class="form-label">First Name</label>
			    <input type="text" class="form-control" id="firstname" name="firstname"  required>
			  </div>
      		  <div class="mb-2">
			    <label for="lastname" class="form-label">Last Name</label>
			    <input type="text" class="form-control" id="lastname" name="lastname"  required>
			  </div>
	      	</div>
	      	
			<div class="col-6">
			     <div class="mb-2">
			    <label for="gender" class="form-label">Gender</label>
			    <select class="form-select" aria-label="Default select example" id="gender" name ="gender" required>
				  <option value="Male">Male</option>
				  <option value="Female">Female</option>
				</select>
			  </div>
			  <div class="mb-2">
			    <label for="age" class="form-label">Age</label>
			    <input type="number" class="form-control" id="age" name="age" required> 
			  </div>
			    <div class="mb-2">
			    <label for="contact_number" class="form-label">Contact Number</label>
			    <input type="number" class="form-control" id="contact_number" name="contact_number" required > 
			  </div>
			    <div class="mb-2">
			    <label for="created_at" class="form-label">Created At</label>
			    <input type="text" class="form-control" id="created_at" name="created_at" disabled > 
			  </div>
			     <div class="mb-2">
			    <label for="address" class="form-label">Address</label>
			     <textarea class="form-control"  rows="5" name="address" id="address"  required></textarea>
			  </div>
      	
	      	</div>  
      </div>
       <div class="modal-footer">     
		  <button type="submit" class="btn btn-dark" >Save Changes</button>
	</div>
 </div>
			 </form>
			</div>
 		</div>
 	</div>
</div>

 	
 
 

 

	 <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>	
     <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
  	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
 	 <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
 	 <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
 	 <script type="text/javascript"><%@include file="/WEB-INF/js/user/profile.js"%></script>

</body>
</html>