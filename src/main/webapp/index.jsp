<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>

<%
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

<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	
<link rel="stylesheet" href="css/style.css">

<title>BookMyRide</title>

<script type="text/javascript">
function authorize() {
    var authorizeEndpoint = '<%= properties.getProperty("authorizeEndpoint") %>';
    var clientId = '<%= properties.getProperty("client_id") %>';
    var redirectUri = encodeURIComponent('<%= properties.getProperty("baseurl") %>/BookMyRide/authorize.jsp');
	var scope = '<%= properties.getProperty("scope") %>';
    var redirectUrl = authorizeEndpoint + '?response_type=code' +
        '&client_id=' + clientId +
        '&scope='+scope+
        '&redirect_uri=' + redirectUri;

    window.location.href = redirectUrl;
}
</script>

</head>
<body class="img js-fullheight" style="background-image: url(images/background2.jpg);">
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">Welcome to BookMyRide</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6 col-lg-4">
					<div class="login-wrap p-0">
		      	<h3 class="mb-4 text-center">Sign In using Asgardeo</h3>
		      	
	            <div class="form-group">
	            	<button type="button" onclick="authorize()" class="form-control btn btn-primary submit px-3">Sign In</button>
	            	
	            </div>
	  
	          <p class="w-100 text-center">&mdash; Don't have an Asgardeo Account &mdash;</p>
	          <div class="social d-flex text-center">
	          	<a href="https://console.asgardeo.io/" class="px-2 py-2 mr-md-1 rounded"><span class="ion-logo-facebook mr-2"></span> Create</a>
	          </div>
		      </div>
				</div>
			</div>
		</div>
	</section>


	</body>
</html>