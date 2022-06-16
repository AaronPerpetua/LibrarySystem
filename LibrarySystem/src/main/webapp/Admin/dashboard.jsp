<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
response.setHeader("Cache-Control","no-cache"); 
response.setHeader("Pragma","no-cache"); 
response.setDateHeader ("Expires", -1);
%>
 <% if(session.getAttribute("user_id")== null){
		response.sendRedirect("../"); 
 }%>  
 
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
                   <h2>Dashboard Page  <i class="bi bi-bar-chart-fill"></i></h2>
                </div>
            </nav>
            
            <!-- cards  -->
      	<jsp:include page="cards.jsp" /> 
              <br> 
				      <button type="button" class="btn btn-dark"  id="btn-add" name="btn-add">
						  Add Book
						</button>
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
								<th scope="col">Category</th>
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
    
            <!-- Modal add Book -->
<div class="modal fade  modal-xl" id="addbook-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Add Book</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <div class="modal-body">
   <div class="card">
 
 <form  id="addbook-form" name="addbook-form">
   <div class="card-body">
    <div class="row">
      	<div class="col-6">
			     <div class="mb-2">
			    <label for="title" class="form-label">Title</label>
			    <input type="text" class="form-control" id="title"   name="title" required>
			   
			  </div>
			  <div class="mb-2">
			    <label for="author" class="form-label">Author</label>
			    <input type="text" class="form-control" id="author" name="author" required> 
			  </div>
			    <div class="mb-2">
			    <label for="publisher" class="form-label">Publisher</label>
			    <input type="text" class="form-control" id="publisher" name="publisher" required > 
			  </div>
			  <div class="mb-2">
			    <label for="pagetotal" class="form-label">Page Total</label>
			    <input type="number" class="form-control" id="pagetotal" name="pagetotal"  required>
			  </div>
      	
	      	</div>
	      	
	      	<div class="col-6">
      		    <div class="mb-2">
			    <label for="description" class="form-label">Description</label>
			    <textarea class="form-control"  rows="7" name="description" id ="description" required ></textarea>			     
			  </div>
				<div class="mb-2">
			    <label for="category" class="form-label">Category</label>
			    <select class="form-select" aria-label="Default select example" id="category" name ="category" required>
				  <option value="Action">Action</option>
				    <option value="Adventure">Adventure</option>
				    <option value="Biography">Biography</option>
				  <option value="Comedy">Comedy</option>
				   <option value="Drama">Drama</option>
				   <option value="Fantasy">Fantasy</option>
				  <option value="Horror">Horror</option>
				    <option value="Thriller">Thriller</option>
				      <option value="Romance">Romance</option>
				</select>
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
			    <div>
			    <div class="mb-2">
			    <label for="category" class="form-label">Category</label>
			    <input type="text" class="form-control" id="category"   name="category" disabled>
			  </div>
			  
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
			    <textarea class="form-control"  rows="11" name="description" id ="description" disabled></textarea>
			     
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


        <!-- Modal update Book form  -->
<div class="modal fade  modal-xl" id="editbook-modal"  data-bs-backdrop="static" data-bs-keyboard="false"  tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Edit Book Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
     <div class="card">
     
     <form  id="updatebook-form" name="updatebook-form">
   		<div class="card-body">  
      <div class="row">
 
      	<div class="col-6">
      	
      		  <div class="mb-2">
			  
			    <input type="hidden" class="form-control" id="id" name="id" required >		   
			  </div>
			  	     <div class="mb-2">
			    <label for="id" class="form-label">Book ID</label>
			    <input type="text" class="form-control" id="id" name="id" required disabled >
			   
			  </div>
			     <div class="mb-2">
			    <label for="title" class="form-label">Title</label>
			    <input type="text" class="form-control" id="title" name="title" required >
			   
			  </div>
			  <div class="mb-2">
			    <label for="author" class="form-label">Author</label>
			    <input type="text" class="form-control" id="author" name="author" required> 
			  </div>
			    <div class="mb-2">
			    <label for="publisher" class="form-label">Publisher</label>
			    <input type="text" class="form-control" id="publisher" name="publisher" required> 
			  </div>
			  
			<div class="mb-2">
			    <label for="category" class="form-label">Category</label>
			    <select class="form-select" aria-label="Default select example" id="category" name ="category" required>
				  <option value="Action">Action</option>
				    <option value="Adventure">Adventure</option>
				    <option value="Biography">Biography</option>
				    <option value="Comedy">Comedy</option>
				    <option value="Drama">Drama</option>
				     <option value="Fantasy">Fantasy</option>
				    <option value="Horror">Horror</option>
				    <option value="Thriller">Thriller</option>
				    <option value="Romance">Romance</option>
				</select>
			  </div>
			 

	      	</div>
	      	
	      	<div class="col-6">
      		    <div class="mb-2">
			    <label for="description" class="form-label">Description</label>
			     <textarea class="form-control"  rows="11" name="description" id="description" ></textarea>
			  </div>
			    <div class="mb-2">
			    <label for="pagetotal" class="form-label">Page Total</label>
			    <input type="number" class="form-control" id="pagetotal" name="pagetotal" required>
			  </div>
			   	<div class="mb-2">
			    <label for="status" class="form-label">Status</label>
			    <select class="form-select" aria-label="Default select example" id="status" name ="status" required>
				  <option value="Available">Available</option>
				  <option value="Not Available">Not Available</option>
				</select>
			  </div>
			  
			     <div class="mb-2">
			    <input type="hidden" class="form-control" id="created_at" name="created_at" required>
			  </div>
      	</div>
      </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-success" >Save Changes</button>
      </div>
      </form>
      </div>
      </div>

    </div>
  </div>
</div> 

	 <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>	
     <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
  	 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
 	 <script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
 	 <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
     <script type="text/javascript"><%@include file="/WEB-INF/js/admin/dashboard.js"%></script>
</body>
</html>