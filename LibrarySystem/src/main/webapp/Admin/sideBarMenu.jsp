
     <nav id="sidebar">
         <div class="sidebar-header">
             <h3>Library System</h3>
         </div>

         <ul class="list-unstyled components">
             <p>Books <i class="bi bi-book-fill"></i></p>
             <li>
                 <a href="../Admin/to-borrow-book.jsp">Books To Borrow  </a>
             </li>
       
             
             <li>
                 <a href="../Admin/to-return-book.jsp">Books For Return</a>
             </li>
          
        
         </ul>
          <ul class="list-unstyled components">
             <p>Menu <i class="bi bi-menu-button-fill"></i></p>
             <li>
                 <a href="../Admin/dashboard.jsp">Dashboard </a>
             </li>
      
             
             <li>
                 <a href="../Admin/users.jsp">Users  </a>
             </li>
           
             <li>
                   <a href="../Admin/feedbacks.jsp">Feedbacks  </a>
             </li>
             <li>
                 <a href="../Admin/logs.jsp">Logs </a>
             </li>
         </ul>
             <ul class="list-unstyled components">
                 <p>Your are Login as Administrator  <i class="bi bi-person-lines-fill"></i></p>
             <li>
                 <a href="<%=response.encodeURL("/LibrarySystem/admin/adminLogout") %>">Signout  <i class="bi bi-arrow-left-square-fill"></i></a>
             </li>
          
         </ul>
     </nav>

 