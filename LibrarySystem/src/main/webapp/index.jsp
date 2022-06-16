<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	 
     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
   <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
    <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>   
<!-- 	 <style>
	body {
	  background-color: #17202A;
	}
	</style> -->

   </head>

<body><br><br><br><br><br><br>
 	<div class="container">
 	<div class="row">
 		<div class="col-2"></div>
 	<div class="col-4">
 	      <img src="images/login-image.jpg" class="img-fluid rounded-start" alt="...">
 	</div>
 	<div class="col-4">
 	
   <div class="card text-center">
  <div class="card-header bg-dark text-bg-secondary " >
      Currently @version 1
  </div>
  <div class="card-body">
    <h4 class="card-title">Login Portal</h4>
    <p class="card-text">Reading is Brain Food.</p>
    <button type="button" class="btn btn-secondary btn-lg" data-bs-toggle="modal" data-bs-target="#userlogin-modal">
 	User Login
</button>
  <button type="button" class="btn btn-secondary btn-lg" data-bs-toggle="modal" data-bs-target="#adminlogin-modal">
  Admin Login
</button>
  </div>
   <div class="card-header bg-dark text-bg-secondary " >
 Copyright &copy; 2022 G5 Inc. Alrights Reserved
  </div>
 
</div>
 	</div>
 	</div>
 	</div>
 	
 	
 	<!-- Modal user login -->
<div class="modal fade" id="userlogin-modal"  data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Login User</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="userlogin-form" name="userlogin-form">
			  <div class="mb-3">
			    <label for="user-username" class="form-label">Username</label>
			    <input type="text" class="form-control" name="user-username" id="user-username" required>
			    <div id="user-username"  class="form-text">We'll never share your details with anyone else.</div>
			  </div>
			  <div class="mb-3">
			    <label for="user-password" class="form-label">Password</label>
			    <input type="password" class="form-control" id="user-password" name="user-password" required>
			  </div>
			  <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <br>
        <button type="submit" class="btn btn-success" >Submit</button>
      </div>
			  
			</form>
      </div>
     
    </div>
  </div>
</div>
		
 	<!-- Modal admin login-->
<div class="modal fade" id="adminlogin-modal"  data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Admin Login</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="adminlogin-form" name="adminlogin-form">
			  <div class="mb-3">
			    <label for="admin-username" class="form-label">Username</label>
			    <input type="text" class="form-control" name="admin-username" id="admin-username" required>
			    <div id="admin-username"  class="form-text">We'll never share your details with anyone else.</div>
			  </div>
			  <div class="mb-3">
			    <label for="admin-password" class="form-label">Password</label>
			    <input type="password" class="form-control" id="admin-password" name="admin-password" required>
			  </div>
			  <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <br>
        <button type="submit" class="btn btn-success" >Submit</button>
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

      <script type="text/javascript">
	 $(document).ready(function(){ 
		
		
		 $('#userlogin-form').submit(function(e){
			 e.preventDefault();
			 
				const data = {
						username : $("#user-username").val(),
						password : $("#user-password").val(),
				};
			 
				$.ajax({
					url:"http://localhost:8080/LibrarySystem/user/userLogin",
					dataType:"json",
					data:data,
					success: function(response){
					if(response == "success"){
					 
						window.location.href = "http://localhost:8080/LibrarySystem/User/dashboard.jsp";
					
					}else{
						 alertify.error('Invalid Username & Password');
					}
					},
					error: function(response){
						console.log(response);
					}
				}); 
			 
			 
		 });
		 
		 
		 $('#adminlogin-form').submit(function(e){
			 e.preventDefault();
			 
				const data = {
						username : $("#admin-username").val(),
						password : $("#admin-password").val(),
				};
			 
				$.ajax({
					url:"http://localhost:8080/LibrarySystem/admin/adminLogin",
					dataType:"json",
					data:data,
					success: function(response){
					if(response == "success"){
					 
						window.location.href = "http://localhost:8080/LibrarySystem/Admin/dashboard.jsp";
					
					}else{
						 alertify.error('Invalid Username & Password');
					}
					},
					error: function(response){
						console.log(response);
					}
				}); 
			 
			 
		 });
		 
		 
		 

		 $('#adminlogin-form').submit(function(e){
			 e.preventDefault();
			 
			 console.log("login admin");
		 });
		 
	});
		
 
	</script>
</body>

</html>