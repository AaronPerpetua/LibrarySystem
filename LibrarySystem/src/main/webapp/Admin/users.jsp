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
	<meta http-equiv='cache-control' content='no-cache'>
	<meta http-equiv='expires' content='0'>
	<meta http-equiv='pragma' content='no-cache'>
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

                   <h2>Users Page  <i class="bi bi-people-fill"></i></h2>

               
                </div>
            </nav>
				      <button type="button" class="btn btn-dark"  id="btn-add" name="btn-add">
						  Add User
						</button>
						   <button type="button" class="btn btn-dark"  id="refresh" name="refresh">
						 Refresh
						</button>
					<div class="card">
					 		  <div class="card-header bg-dark text-bg-secondary " >
					    List of All Users
					  </div>
					  <div class="card-body">
					    <table class="table table-hover table-sm table-responsive" style="width:100%" id="datatable" >
						 
					        <thead>
					            <tr>
					                <th scope="col">ID</th>
					                <th scope="col">Username</th>
					                <th scope="col">First Name</th>
					                <th scope="col">Last Name</th>
					                <th scope="col">Email</th>
					                <th scope="col">Gender</th>
					                <th scope="col">Action</th>
					            </tr>
					        </thead>
					    
					    </table>
					  </div>
					</div>
		        </div>
		    </div>
    
            <!-- Modal add Book -->
<div class="modal fade  modal-xl" id="adduser-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add User</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
   <div class="card">
 
 <form  id="adduser-form" name="adduser-form">
   <div class="card-body">
    <div class="row">
      	<div class="col-6">
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
			    <label for="address" class="form-label">Address</label>
			     <textarea class="form-control"  rows="5" name="address" id="address"  required></textarea>
			  </div>
      	
	      	</div>  
      </div>
 </div>
 
		 <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		        <button type="submit" class="btn btn-success" >Submit</button>
		       
		      </div>
			 </form>
			  </div>
		      </div>
		    </div>
		  </div>
		</div> 




      <!--  Modal view Book  -->
<div class="modal fade  modal-xl" id="viewuser-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">View User Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">     
    	  <div class="card">
   		<div class="card-body">  
      <div class="row">
      	<div class="col-6">
      	     <div class="mb-2">
			    <label for="id" class="form-label">User ID</label>
			    <input type="text" class="form-control" id="id"   name="id" disabled>
			  </div>
			  
		  <div class="mb-2">
			    <label for="v-username" class="form-label">Username</label>
			    <input type="text" class="form-control" id="v-username" name="v-username" disabled> 
			  </div>
			    <div class="mb-2">
			    <label for="v-password" class="form-label">Password</label>
			    <input type="text" class="form-control" id="v-password" name="v-password" disabled > 
			  </div>
			   <div class="mb-2">
			    <label for="v-email" class="form-label">Email</label>
			    <input type="text" class="form-control" id="v-email" name="v-email" disabled> 
			  </div>
			    <div class="mb-2">
			    <label for="v-firstname" class="form-label">First Name</label>
			    <input type="text" class="form-control" id="v-firstname" name="v-firstname" disabled > 
			  </div>
			      <div class="mb-2">
			    <label for="v-lastname" class="form-label">Last Name</label>
			    <input type="text" class="form-control" id="v-lastname" name="v-lastname" disabled > 
			  </div>
		
	      	</div>
	      	
			<div class="col-6">
				    <div class="mb-2">
			    <label for="created_at" class="form-label">User Created</label>
			    <input type="text" class="form-control" id="created_at" name="created_at"  disabled>
			  </div>
			     <div class="mb-2">
			    <label for="gender" class="form-label">Gender</label>
			    <select class="form-select" aria-label="Default select example" id="gender" name ="gender" disabled>
				  <option value="Male">Male</option>
				  <option value="Female">Female</option>
				</select>
			  </div>
			  <div class="mb-2">
			    <label for="age" class="form-label">Age</label>
			    <input type="number" class="form-control" id="age" name="age" disabled> 
			  </div>
			    <div class="mb-2">
			    <label for="contact_number" class="form-label">Contact Number</label>
			    <input type="number" class="form-control" id="contact_number" name="contact_number" disabled > 
			  </div>
			     <div class="mb-2">
			    <label for="address" class="form-label">Address</label>
			     <textarea class="form-control"  rows="5" name="address" id="address"  disabled></textarea>
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

     <script type="text/javascript">
     $(document).ready(function () {
    	
    	 
    	 var t;
    	 
    	 
    	 //datatables for the user
    	 const getDatatable = () => {
    		 
    		 t = $('#datatable').DataTable({
    			order:[[0,"desc"]],
 		        processing: true,
 		        serverSide: false,
 		        cache: false,
 		       destroy: true,
               scrollY: "500px",
 		        dataSrc: "data",
 		        ajax: 'http://localhost:8080/LibrarySystem/user/getAllUsers', //endpoint to get all the user data
 		        columns: [
     	            { data: 'id' },
     	            { data: 'username' },
     	            { data: 'firstname' },
     	            { data: 'lastname' },
     	            { data: 'email' },
     	            { data: 'gender' },
     	        
     	            {
                         data: null,
                         sortable: false,
                         searchable: false,
                         render: function (data, type, full) {
                         	 return ` <button type="button" class="btn btn-dark btn-sm" value="${data.id}" name="btn-view" id="btn-view">
                              <i class="bi bi-eye-fill"></i>
                              </button> 
                           
                              
                              <button type="button" class="btn btn-dark btn-sm" value="${data.id}" id="btn-delete" name="btn-delete" >
                              <i class="bi bi-trash"></i>
                              </button> `;
                         },
                     }, 
     	           
     	        ],
 		    });
    		 
    	 }
    		
    	
    		
    		//botton for displaying add book modal form 
    		
			$(document).on('click', '#btn-add', function(){
				$("#adduser-modal").modal("show");
				   $("#username").val('');
				   $("#password").val('');     		//we add this to avoid cache coming from the web
				   $("#email").val('');
				   $("#firstname").val('');
				   $("#lastname").val('');
				   $("#gender").val('');
				   $("#age").val('');
				   $("#contact_number").val('');
				   $("#address").val('');
	
			});
    		
    		//button to refresh the tables
    		$(document).on('click', '#refresh',function(){
    			 $("#datatable").DataTable().ajax.reload();
    			 
    		});
			
    		
    		const refreshDatatables = () => {          // function to refresh the table
    			 $("#datatable").DataTable().ajax.reload();
    		}
    		
																
				$("#adduser-form").submit(function(e){			//button for submiting the new user
					e.preventDefault();
					
					
					var cnum = $('#contact_number').val();
					
					const data = {
						username : $("#username").val(),
						password : $("#password").val(),
						email : $("#email").val(),
						firstname : $("#firstname").val(),
						lastname : $("#lastname").val(),
						gender : $("#gender").val(),
						age : $("#age").val(),
						contact_number : $("#contact_number").val(),
						address : $("#address").val(),
					};
					
				 	if(cnum.length > 11 || cnum.length < 11 ){
				 		alertify.error('Invalid contact number, must be 11 digits');
				 	}else{
				 		alertify.confirm("Are you sure you want to Add this User ?",
		      	  				  function(){
		    					$.ajax({
		    					
		    						url: "http://localhost:8080/LibrarySystem/user/createSingleUser",  //endpoint for creating new user
		    						dataType:"json",
		    						cache:false,
		    						data:data,
		    						success: function(response){

		    						},
		    						error: function(response){
		    							console.log(response);
		    						}
		    					});
		    					   refreshDatatables();
			   					   $("#datatable").DataTable().ajax.reload();
			   					   $("#adduser-modal").modal("hide");
			    					
		      	  				    alertify.success('Added Successfully !');
		      	  				  },
		      	  				  function(){
		      	  					  
		      	  				    alertify.error('Cancelled');
		      	  				  }).setHeader("Confirmation "); 
				 	}
			
				});
				

    			
    			//button for displaying user details 
    			  $('#datatable').on( 'click', "#btn-view", function () {
    					 
            	   var data = t.row( $(this).parents('tr') ).data();

    	    	  $("#viewuser-modal").modal("show");
    	    	  
 
    		  	 $.ajax({
    	                url: "http://localhost:8080/LibrarySystem/user/getSingleUser",
    	                type: "GET",
    	                data: { id: data.id },
    	                cache: false,
    	                success: function (response) {
    	                	
    	                    $("[name='id']").val(response.id); 
    	                	$("[name='v-username']").val(response.username); 
    	                	$("[name='v-password']").val(response.password); 
    	                	$("[name='v-email']").val(response.email); 
    	                	$("[name='v-firstname']").val(response.firstname); 
    	                	$("[name='v-lastname']").val(response.lastname); 
    	                	$("[name='gender']").val(response.gender); 
    	                	$("[name='age']").val(response.age); 
    	                	$("[name='contact_number']").val(response.contact_number); 
    	                	$("[name='address']").val(response.address); 
    	                	$("[name='created_at']").val(moment(response.created_at).format('LLL'));  
 
    	                },
    	                error: function () {
    	                    alert(
    	                        "Error: Please Contact System Admnistrator \n Or Refresh this Page."
    	                    );
    	                },
    	            });	  
 
      	     
      	    	 });
    			

      		
    		
 				//button for deleting the user
    	    	 $('#datatable').on( 'click', "#btn-delete", function () {
	 
    	    	    var data = t.row( $(this).parents('tr') ).data();
    	    	    
    	    
    		    alertify.confirm("Are you sure you want to delete this user ? " +(data.username),
    	  				  function(){
    	    	   		 $.ajax({
    	    	                url: "http://localhost:8080/LibrarySystem/user/deleteSingleUser",
    	    	                type: "GET",
    	    	                data: { id: data.id },
    	    	                cache: false,
    	    	                success: function (response) {
  									console.log("User deleted");
    	    	                },
    	    	                error: function () {
    	    	                    alert(
    	    	                        "Error: Please Contact System Admnistrator \n Or Refresh this Page."
    	    	                    );
    	    	                },
    	    	            });	 
	    	    	   		 refreshDatatables();
	   					  $("#datatable").DataTable().ajax.reload();
	    	  			alertify.success('Removed Successfully !');
    	  				  },
    	  				  function(){
    	  				    alertify.error('Cancelled');
    	  				  }).setHeader("Confirmation "); 
    	     
    	    	 });
   
    	    	 getDatatable();
   });
	
</script>
  
</body>

</html>