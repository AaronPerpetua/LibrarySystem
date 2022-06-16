<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand" href="../User/dashboard.jsp">G5 Incorporated</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link " aria-current="page" href="../User/dashboard.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../User/request.jsp">Request & Logs</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../User/feedback.jsp">Feedback</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="../User/profile.jsp">  ${sessionScope.username}</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%=response.encodeURL("/LibrarySystem/user/userLogout") %>">Signout</a>
        </li>
      	
      </ul>
    </div>
  </div>
</nav>