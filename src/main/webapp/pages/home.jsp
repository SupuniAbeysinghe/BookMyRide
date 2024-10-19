<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.services.dao.*" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<% 

		ServiceDAO service = new ServiceDAO();

	    
		
		try {
    	if (request.getParameter("submit") != null) {
	        String location = request.getParameter("location");
	        String mileageStr = request.getParameter("mileage");
	        String vehicle_no = request.getParameter("vehicle");
	        String message = request.getParameter("message");
	        String userName = request.getParameter("usernameField");
	        String dateStr = request.getParameter("date");
	        String timeStr = request.getParameter("time");
	    	/*
			System.out.println("Username: " + userName);
		    System.out.println("location: " + location);
		    System.out.println("Mileage: " + mileageStr);
		    System.out.println("Message: " + message);
		    System.out.println("Vehicle No: " + vehicle_no);*/
	
	        int rowsInserted =  service.insertService(location,  mileageStr, vehicle_no,  message,  userName,  dateStr,  timeStr);
	        if (rowsInserted > 0) {
	        	String successMessage = "Data inserted successfully.";
	            request.setAttribute("successMessage", successMessage);
	            response.sendRedirect(request.getRequestURI() + "#service");
	             
	         }else if(rowsInserted == -1){
	        	 out.println("Invalid time format. Please enter time in hh:mm format.");
	         }
	         else if(rowsInserted == -2){
	        	 out.println("Error parsing time");
	        	 	   
	         }
	        
	        else {
	        	 out.println("Failed to insert data.");
	         }
	         
    	}
	    if (request.getParameter("delete") != null){
	    	
	    	String bookingId = request.getParameter("bookingID");
	    	String username = request.getParameter("usernameForDelete");
	    	
	    	int id = Integer.parseInt(bookingId);

	    	int rowsAffected = service.deleteServices(id,username);
	    	
	    	if (rowsAffected > 0) {
	    		 response.sendRedirect(request.getRequestURI());
		         
		    }else if(rowsAffected == -1){
		    	out.println("Error in the databse. Try again later");
		    } else {
		        out.println("No data found for the given booking ID");
		    }
	    	
	    	
	    } 

	
	}catch (ClassNotFoundException e) {
		e.printStackTrace();
			
		}
		
		
Properties properties = new Properties();

try {
	 InputStream inputStream = application.getResourceAsStream("/WEB-INF/classes/application.properties");
	 properties.load(inputStream);
	} catch (IOException e) {
	    e.printStackTrace();
	}
		
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	const infoUrl = '<%= properties.getProperty("userinfoEndpoint") %>';
	const client_Id = '<%= properties.getProperty("client_id") %>';
	const client_secret = '<%= properties.getProperty("client_secret") %>';
	const postLogoutRedirectUri = '<%= properties.getProperty("baseurl") %>' + '/BookMyRide/index.jsp';
	const introspectionEndpointUrl ='<%= properties.getProperty("introspectionEndpoint") %>';

</script>
<script type="text/javascript"  src="../js/userInfo.js"></script>


<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../css/nav.css">
<link rel="stylesheet" href="../css/home.css">
<link rel="stylesheet" href="../css/profileCard.css">
<link rel="stylesheet" href="../css/service.css">

	
<title>Home</title>

</head>
<body>
<section id="home">

<!-- ----------------------Navigation Panel-------------------- -->
<nav>
  <a class="active" href="#">
    <svg viewBox="0 0 100 100">
      <g transform="translate(10 5) scale(0.8 0.9)">
        <path d="M 0 30 v 70 h 100 v -70 l -50 -30 z" stroke="currentColor" stroke-width="10" fill="none"
          stroke-linejoin="round" stroke-linecap="round" />
      </g>
    </svg>
    <span>
      Home
    </span>
  </a>

  <a href="#service">
    <svg viewBox="0 0 100 100">
      <g transform="translate(5 5) scale(0.9 0.9)">
        <path d="M 50 35 a 20 20 0 0 1 50 0 q 0 25 -50 60 q -50 -35 -50 -60 a 25 25 0 0 1 50 0" stroke="currentColor"
          stroke-width="10" fill="none" stroke-linejoin="round" stroke-linecap="round" />
      </g>
    </svg>
    <span>
     Services
    </span>
  </a>

  <a href="#history">
    <svg viewBox="0 0 100 100">
      <g transform="translate(5 5) scale(0.9 0.9)">
        <circle cx="45" cy="38" r="38" stroke="currentColor" stroke-width="10" fill="none" />
        <line x1="66" y1="65" x2="100" y2="100" stroke="currentColor" stroke-width="10" />
      </g>
    </svg>
    <span>
      Search
    </span>
  </a>
  

  <a href="#info">
    <svg viewBox="0 0 100 100">
      <g transform="translate(5 5) scale(0.9 0.9)">
        <circle cx="50" cy="35" r="18" stroke="currentColor" stroke-width="10" fill="none" />
        <rect x="15" y="75" width="70" height="50" rx="25" stroke="currentColor" stroke-width="10" fill="none" />
      </g>
    </svg>
    <span>
      Profile
    </span>
  </a>
</nav>



<!-- ----------------------Welcome message-------------------- -->
<div class="land"> 
	<h1>BookMy<span class="care">Ride</span></h1>
	
	<h2 class="welcome">Wel<span class="come">come!</span></h2>
	<h2 id="givenName"></h2>
</div>


</section>

<!-- ----------------------Profile Info-------------------- -->
<section id="info">

<div class="card">
  <div class="img-avatar">
    <svg viewBox="0 0 100 100">
    <path d="m38.977 59.074c0 2.75-4.125 2.75-4.125 0s4.125-2.75 4.125 0"></path>
    <path d="m60.477 59.074c0 2.75-4.125 2.75-4.125 0s4.125-2.75 4.125 0"></path>
    <path d="m48.203 69.309c1.7344 0 3.1484-1.4141 3.1484-3.1484 0-0.27734-0.22266-0.5-0.5-0.5-0.27734 0-0.5 0.22266-0.5 0.5 0 1.1836-0.96484 2.1484-2.1484 2.1484s-2.1484-0.96484-2.1484-2.1484c0-0.27734-0.22266-0.5-0.5-0.5-0.27734 0-0.5 0.22266-0.5 0.5 0 1.7344 1.4141 3.1484 3.1484 3.1484z"></path>
    <path d="m35.492 24.371c0.42187-0.35156 0.48047-0.98438 0.125-1.4062-0.35156-0.42188-0.98438-0.48438-1.4062-0.125-5.1602 4.3047-16.422 17.078-9.5312 42.562 0.21484 0.79688 0.85547 1.4062 1.6641 1.582 0.15625 0.035156 0.31641 0.050781 0.47266 0.050781 0.62891 0 1.2344-0.27344 1.6445-0.76562 0.82812-0.98828 2.0039-1.5391 2.793-1.8203 0.56641 1.6055 1.4766 3.3594 2.9727 4.9414 2.2852 2.4219 5.4336 3.9453 9.3867 4.5547-3.6055 4.5-3.8047 10.219-3.8086 10.484-0.011719 0.55078 0.42187 1.0078 0.97656 1.0234h0.023438c0.53906 0 0.98437-0.42969 1-0.97266 0-0.054688 0.17187-4.8711 2.9805-8.7773 0.63281 1.2852 1.7266 2.5 3.4141 2.5 1.7109 0 2.7578-1.2695 3.3398-2.6172 2.8867 3.9258 3.0586 8.8359 3.0586 8.8906 0.015625 0.54297 0.46094 0.97266 1 0.97266h0.023438c0.55078-0.015625 0.98828-0.47266 0.97656-1.0234-0.007812-0.26953-0.20703-6.0938-3.9141-10.613 7.0781-1.3086 10.406-5.4219 11.969-8.9766 1.0508 0.98828 2.75 2.1992 4.793 2.1992 0.078126 0 0.15625 0 0.23828-0.003906 0.47266-0.023438 1.5781-0.074219 3.4219-4.4219 1.1172-2.6406 2.1406-6.0117 2.8711-9.4922 4.8281-22.945-4.7852-30.457-9.1445-32.621-12.316-6.1172-22.195-3.6055-28.312-0.42188-0.48828 0.25391-0.67969 0.85938-0.42578 1.3477s0.85938 0.67969 1.3477 0.42578c5.7031-2.9688 14.934-5.3047 26.5 0.4375 7.1875 3.5703 9 11.586 9.2539 17.684 0.49609 11.93-4.2617 23.91-5.7344 25.062h-0.015626c-1.832 0-3.4102-1.5742-4.0352-2.2852 0.28906-0.99609 0.44531-1.8672 0.52734-2.5117 0.62891 0.16797 1.2812 0.27344 1.9727 0.27344 0.55469 0 1-0.44922 1-1 0-0.55078-0.44531-1-1-1-7.3203 0-10.703-13.941-10.734-14.082-0.097656-0.40625-0.4375-0.71094-0.85156-0.76172-0.43359-0.050781-0.82031 0.16406-1.0117 0.53906-1.8984 3.7188-1.4297 6.7539-0.67969 8.668-6.2383-2.2852-8.9766-8.6914-9.0078-8.7617-0.17969-0.43359-0.62891-0.68359-1.1016-0.60156-0.46094 0.082032-0.80469 0.47266-0.82422 0.94141-0.14062 3.3359 0.67188 5.75 1.5 7.3164-8.3125-2.4297-10.105-11.457-10.184-11.875-0.097656-0.51562-0.57422-0.86328-1.0898-0.8125-0.51953 0.054687-0.90625 0.50391-0.89062 1.0234 0.41406 13.465-1.8516 17.766-3.2383 19.133-0.66406 0.65625-1.1992 0.67188-1.2383 0.67188-0.53906-0.050781-1.0156 0.31641-1.0938 0.85156-0.078125 0.54688 0.29688 1.0547 0.84375 1.1328 0.03125 0.003906 0.11328 0.015625 0.23828 0.015625 0.36719 0 1.1016-0.09375 1.9414-0.66406 0.050781 0.38672 0.125 0.81641 0.21875 1.2656-1.0273 0.35156-2.6211 1.0781-3.7812 2.4648-0.015625 0.019532-0.054687 0.066406-0.15625 0.046875-0.039062-0.007812-0.13281-0.039062-0.16406-0.15234-2.1875-8.1094-5.7148-28.309 8.8867-40.496zm12.711 51.828c-1.0039 0-1.5898-1.207-1.8672-2.0117 0.48047 0.023438 0.95703 0.050781 1.4531 0.050781 0.74219 0 1.4453-0.035156 2.1289-0.082031-0.24219 0.83594-0.76172 2.043-1.7148 2.043zm-13.148-30.664c1.9531 3.6211 5.6367 7.9102 12.305 8.6992 0.43359 0.046875 0.83984-0.18359 1.0234-0.57422 0.18359-0.39062 0.089844-0.85938-0.22656-1.1523-0.074219-0.070312-1.2734-1.2227-1.9688-3.6367 2 2.6094 5.3359 5.6836 10.305 6.5664 0.42187 0.070312 0.83594-0.125 1.0469-0.49219 0.21094-0.36719 0.16406-0.82812-0.11719-1.1484-0.023437-0.027344-1.9414-2.2969-1.2891-5.8906 1.2227 3.5508 3.7461 9.2227 7.8945 11.551-0.03125 0.55859-0.14844 1.668-0.55078 3.0156-0.085937 0.13672-0.125 0.28516-0.13672 0.44531-1.3008 3.8906-5.0039 9.3281-15.547 9.3281-5.375 0-9.4414-1.418-12.086-4.2109-3.5664-3.7656-3.332-8.8477-3.332-8.8984v-0.011719c1.5898-2.7227 2.5-7.3203 2.6797-13.59z"></path>
  </svg>
  </div>
  <div class="card-text">
    <div class="portada">
    
    </div>
    <div class="title-total">   
      <div class="title">User</div>
      <h2 id = "name"></h2>
      <br>
  
  <div class="desc">
  
  <ul>
  <li>Email : <span id = 'email'></span></li>
  <li>Contact: <span id = 'phone'></span></li>
  <li>Country: <span id = 'country'></span></li>
  
  
  </ul>
  
  
  </div>
  <div class="actions">
  		<!-- Logout form  -->
  	  <form id="logout-form" action="<%= properties.getProperty("logoutEndpoint") %>" method="POST">
        <input type="hidden" id="client-id" name="client_id" value="">
        <input type="hidden" id="post-logout-redirect-uri" name="post_logout_redirect_uri" value="">
        <input type="hidden" id="state" name="state" value="">
        <button type="submit" id="logout" >Logout</button>
    </form>
  

    
  </div></div>
 
  </div>
  
 
  
</div>


</section>
<!-- ----------------------Reservation form-------------------- -->
<section id="service">

<div class="content">
	<div class="container">
	      <div class="row align-items-stretch no-gutters contact-wrap">
	        <div class="col-md-12">
	          <div class="form h-100">
	          	<%
				String message = (String) request.getAttribute("successMessage");
	          	//System.out.println(message);
	          	if(message!=null){
				%>
				    <div class="success-message">
				        <%= message %>
				    </div>
				    <script>
					    document.addEventListener('DOMContentLoaded', function() {
					        var successMessage = '<%= message %>';
					        alert(successMessage);
					    });
				    </script>
				   <% } %>

	            <h3>Service</h3>
	            <form class="mb-5" method="post" id="contactForm" name="contactForm">
	              <div class="row">
	                <div class="col-md-6 form-group mb-3">
	                  <label for="" class="col-form-label">Location *</label>
	                  <select class="custom-select" id="location" name="location" required>
						    <option selected>Choose...</option>
						    <option value="Colombo">Colombo</option>
				            <option value="Gampaha">Gampaha</option>
				            <option value="Kalutara">Kalutara</option>
				            <option value="Kandy">Kandy</option>
				            <option value="Matale">Matale</option>
				            <option value="Nuwara Eliya">Nuwara Eliya</option>
				            <option value="Galle">Galle</option>
				            <option value="Matara">Matara</option>
				            <option value="Hambantota">Hambantota</option>
				            <option value="Jaffna">Jaffna</option>
				            <option value="Kilinochchi">Kilinochchi</option>
				            <option value="Mannar">Mannar</option>
				            <option value="Vavuniya">Vavuniya</option>
				            <option value="Mullaitivu">Mullaitivu</option>
				            <option value="Batticaloa">Batticaloa</option>
				            <option value="Ampara">Ampara</option>
				            <option value="Trincomalee">Trincomalee</option>
				            <option value="Kurunegala">Kurunegala</option>
				            <option value="Puttalam">Puttalam</option>
				            <option value="Anuradhapura">Anuradhapura</option>
				            <option value="Polonnaruwa">Polonnaruwa</option>
				            <option value="Badulla">Badulla</option>
				            <option value="Monaragala">Monaragala</option>
				            <option value="Ratnapura">Ratnapura</option>
				            <option value="Kegalle">Kegalle</option>
						  </select>

					 </div>
					 <br>
	                <div class="col-md-6 form-group mb-3">
	                  <label for="" class="col-form-label">Mileage *</label>
	                  <input type="number" step="1" min="1" pattern="\d+" class="form-control" name="mileage" id="mileage"  placeholder="Enter the total mileage" required>
	                </div>
	                <br>
	                <div class="col-md-6 form-group mb-3">
	                   <label for="day" class="col-form-label">Date *</label>
  						<input type="date" id="date" name="date" min="<%= java.time.LocalDate.now() %>" required>
	                </div>
	                <br>
	                <div class="col-md-6 form-group mb-3">
	                   <label for="time" class="col-form-label">Select a time * </label>
  					 <select class="custom-select" id="time" name="time" required>
  					 		<option selected>Choose...</option>
						    <option value="10:00 AM">10:00 AM</option>
				            <option value="11:00 AM">11:00 AM</option>
				            <option value="12:00 PM">12:00 PM</option>
  					 </select>
	                </div>
	                
	                 <input type="hidden" id="usernameField" name="usernameField" value="" >
	              </div>
	              <br>
	
	              <div class="row">
	                <div class="col-md-12 form-group mb-3">
	                  <label for="budget" class="col-form-label">Vehicle</label>
	                  <select class="custom-select" id="vehicle" name="vehicle" required>
						    <option selected>Choose...</option>
						    <option value="AAA-001"> Suzuki-WagonR(2015)</option>
						    <option value="ABC-002">Toyota-Prius(2012)</option>
						    <option value="FG-034">Suzuki-Alto(2019)</option>
						    <option value="QA-004">Dolphin(2011) </option>
						    <option value="CAT-005">Honda-Fit(2020) </option>
						  </select>
	                </div>
	              </div>
					<br>
	              <div class="row">
	                <div class="col-md-12 form-group mb-3">
	                  <label for="message" class="col-form-label">Message *</label>
	                  <textarea class="form-control" name="message" id="message" cols="30" rows="4"  placeholder="Write your message"></textarea>
	                </div>
	              </div>
	              <div class="row">
	                <div class="col-md-12 form-group">
	                <br>
	                  <input type="submit" value="Submit" id="submit" name="submit" class="btn btn-primary rounded-0 py-2 px-4">
	                  <span class="submitting"></span>
	                </div>
	              </div>
	            </form>
	
	          </div>
	        </div>
	      </div>
	    </div>
	</div>

</section>

<!-- ----------------------View reservation section-------------------- -->
<section id = "history">



<div class="past" id="past">
<h2 id="tableName" id="pastTable">Past Reservations</h2>
<br>
<table class="table" id="pastTable">
    <tr>
        <th>Booking ID</th>
        <th>Date</th>
        <th>Time</th>
        <th>Location</th>
        <th>Mileage</th>
        <th>Vehicle Number</th>
        <th>Message</th>
    </tr>
</table>

<div class="future" id="future">
    <h2 id="tableName">Future Reservations</h2>
    <br>
    <table class="table" id="futureTable">
        <tr>
            <th>Booking ID</th>
            <th>Date</th>
            <th>Time</th>
            <th>Location</th>
            <th>Mileage</th>
            <th>Vehicle Number</th>
            <th>Message</th>
            <th>Action</th>
        </tr>
    </table>
</div>

</div>


<!-- ----------------------Pop-up window to get confirmation for deleting-------------------- -->
<div id="id01" class="modal">
  <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">�</span>
  <form class="modal-content" id="deleteForm" method="post" >
    <div class="container2">
      <h1>Delete Reservation</h1>
      <p>Are you sure you want to delete your reservation?</p>
    	<input type="hidden" id="bookingID" name="bookingID" value="" >
    	<input type="hidden" id="usernameForDelete" name="usernameForDelete" value="" >
      <div class="clearfix">
        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        <input type="submit" value="Delete" name="delete" id="delete" onclick="document.getElementById('id01').style.display='none'" class="deletebtn">
      </div>
    </div>
  </form>
</div>



</section>


<script type="text/javascript"  src="../js/home.js"></script>
<script type="text/javascript"  src="../js/logout.js"></script>

</body>


</html>