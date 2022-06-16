 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
 	<input type=text class="form-control" id="user_id" name="user_id" value=" ${sessionScope.user_id}">
 		<div class="col"></div>
 		<div class="col-12">
 	            <button type="button" class="btn btn-dark" value="refresh" id="refresh" name="refresh">
						 Refresh
						</button>
				     
					<div class="card">
					 		  <div class="card-header bg-dark text-bg-secondary " >
					   Borrow Books
					  </div>
					  <div class="card-body">
					    <table class="table table-hover table-sm table-responsive" style="width:100%" id="datatable" >
						 
					        <thead>
					            <tr>
					           <th scope="col">ID</th>
					           <th scope="col">Username</th>
						      <th scope="col">Book ID</th>
						      <th scope="col">Book Title</th>
					          <th scope="col">Status</th>
					          <th scope="col"> Transanction Date</th>
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
			    <label for="book_id" class="form-label">Book ID</label>
			    <input type="text" class="form-control" id="book_id"   name="book_id" disabled>
			  </div>

			    <input type="hidden" class="form-control" id="log_id"   name="log_id" >

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
			  <br>

		<button type="button" class="btn btn-danger" id ="cancel_btn" name="cancel_btn">
		  Cancel this request
		</button>
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

      <script type="text/javascript">
	 $(document).ready(function(){ 
		 
  	 var booksTable;
  	 
		$(document).on('click', '#refresh',function(){
			 $("#datatable").DataTable().ajax.reload();
			 
		});
		
		const refreshDatatables = () => { 						// function to refresh the table
			 $("#datatable").DataTable().ajax.reload();
		}
		
    	 //datatables for the books
    	 const getDatatable = () => {
    		 
    		 booksTable = $('#datatable').DataTable({
    			order:[[0,"desc"]],
 		        processing: true,
 		        serverSide: false,
 		        cache: false,
 		        destroy: true,
               scrollY: "500px",
 		        dataSrc: "data",
 		        ajax: 'http://localhost:8080/LibrarySystem/user/getBorrowBooks', //endpoint to get all the books data
 		        columns: [
 		            { data: 'id' },
 		            { data: 'username' },
 	 	            { data: 'book_id' },
 	 	            { data: 'book_title' },
 	 	            { data: 'status' },
 	 	            { data: 'transaction_date' },
     	        
     	            {
                         data: null,
                         sortable: false,
                         searchable: false,
                         render: function (data, type, full) {
                        	 
                        	 return ` <button type="button" class="btn btn-dark btn-sm"   name="btn-view" id="btn-view">
                             <i class="bi bi-eye-fill"></i>
                             </button> `;

                         },
                     }, 
     	           
     	        ],
    			      columnDefs: [
    			    	  { "width": "20%", "targets": 5 },
    			     
  			    	  {
			    	        targets: 3,
			    	        render: function ( data, type, row ) {
			    	            return data.substr( 0, 20 );
			    	        }
			    	    },
    			   
           
                     
			    	      {
			      	           targets: 5,
			      	           width: "20%",
			      	           render: function (data) {
			      	               return moment(data).format('LLL');  					// to change the date format
			      	           },
			      	       }, 
              
                 ], 
  
 		    });
    		 
    	 }
    	 
 		//button for viewing the book details
		  $('#datatable').on( 'click', "#btn-view", function () {
			  
   	    	var data = booksTable.row( $(this).parents('tr') ).data();

   	    	 $("#viewbook-modal").modal("show");
   	    	 
   	    	 $("[name='log_id']").val(data.id); 
			 
    		 $.ajax({
               url: "http://localhost:8080/LibrarySystem/book/getSingleBook",
               type: "GET",
               data: { id: data.book_id },
               cache: false,
               success: function (response) {
               	
               	$("[name='book_id']").val(response.id); 
               	$("[name='title']").val(response.title); 
               	$("[name='author']").val(response.author); 
               	$("[name='publisher']").val(response.publisher); 
               	$("[name='description']").val(response.description); 
               	$("[name='pagetotal']").val(response.page_total); 
               	$("[name='status']").val(response.status); 
               	$("[name='created_at']").val(moment(response.created_at).format('LLL'));  
               	
          
             	if(response.status == "For Confirmation"){
             		$("[name='cancel_btn']").prop('disabled', false) ;
             	}else{
             		$("[name='cancel_btn").prop('disabled', true) ;
             	}
               },
               error: function () {
                   alert(
                       "Error: Please Contact System Admnistrator \n Or Refresh this Page."
                   );
               },
           });	      
    	
            
 
     });
 		
 		
 		$(document).on('click','#cancel_btn',function(e){
 			e.preventDefault();
 			
 		  var log_id = $( "#log_id" ).val();
 		  var book_id = $( "#book_id" ).val();
 		  
 		  
			alertify.confirm("Are you sure you want to cancel this book ?",
 				  function(){
 			 
			 		 $.ajax({
			             url: "http://localhost:8080/LibrarySystem/log/setToCancelled",
			             type: "GET",
			             data: { id: log_id},
			             cache: false,
			             success: function (response) {
			            	 refreshDatatables();
			             },
			             error: function () {
			                 alert(
			                     "Error: Please Contact System Admnistrator \n Or Refresh this Page."
			                 );
			             },
			         });	
			 		 
			 		 
			 		  $.ajax({	
			              url: "http://localhost:8080/LibrarySystem/book/setToAvailable",
			              type: "GET",
			              data: { id: book_id},
			              cache: false,
			              success: function (response) {              
			            	  refreshDatatables();
			              },
			              error: function () {
			                  alert(
			                      "Error: Please Contact System Admnistrator \n Or Refresh this Page."
			                  );
			              },
			          });	
			 		 	alertify.success('Borrow Cancelled !');
			 		 	$("#viewbook-modal").modal("hide");
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