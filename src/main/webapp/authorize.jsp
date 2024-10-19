<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.FileInputStream, java.io.IOException, java.util.Properties" %>
<%@ page import="java.io.InputStream, java.io.IOException" %>
<%
	
		String code = request.getParameter("code");
	
		String sessionState = request.getParameter("session_state");
	
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <script type="text/javascript">
        function makePostRequest() {
            var url = '<%= properties.getProperty("tokenEndpoint") %>';

            var code = encodeURIComponent('<%= code %>');
            var state = encodeURIComponent('<%= sessionState %>');
            localStorage.setItem('state', state);
            var sessionState = encodeURIComponent('<%= sessionState %>');
            var client_Id = '<%= properties.getProperty("client_id") %>';
            var client_secret = '<%= properties.getProperty("client_secret") %>';
           
            var redirect_uri =  '<%= properties.getProperty("baseurl") %>' + '/BookMyRide/authorize.jsp';
          	//console.log(redirect_uri);
            
            // const introspectionEndpoint = 'https://api.asgardeo.io/t/learnmasith/oauth2/introspect';
           // const clientCredentials = btoa(`${client_Id}:${client_secret}`);


            // Define the request body parameters
            var bodyParams = new URLSearchParams();
            bodyParams.append('code', code);
            bodyParams.append('grant_type', 'authorization_code');
            bodyParams.append('client_id', client_Id);
            bodyParams.append('client_secret', client_secret);
            bodyParams.append('redirect_uri', redirect_uri);

            var requestOptions = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                data: bodyParams.toString()
            };

            $.ajax(url, requestOptions)
                .done(function (data) {

                    var access_token  = data.access_token;
                   	var id_token = data.access_token;
                   	localStorage.setItem('access_token', access_token);
                   	localStorage.setItem('id_token', id_token);
            	    window.location.href = "pages/home.jsp";
            	    
                   	
            	    
            	    
                })	
                .fail(function (error) {
                	// Handle any errors here
                	console.error('Error:', error);
                	window.location.href = "../index.jsp";
                	});

                
        }

        makePostRequest();
    </script>
</body>
</html>
