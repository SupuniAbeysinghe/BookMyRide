        const accessToken = localStorage.getItem('access_token');
       	 var username = null;
        if(accessToken){
        	
        var settings = {
            "url": infoUrl,
            "method": "GET",
            "timeout": 0,
            "headers": {
                "Authorization": "Bearer " + accessToken
            },
        };

        $.ajax(settings)
            .done(function (response) {
                username =  response.username;
                var given_name = response.given_name;
                var phone = response.phone_number;
                var email = response.email;
                var parts = given_name.split(' ');
                var firstName = parts[0];
                var address = response.address;
                var country = address.country;
                document.getElementById('givenName').textContent = given_name;
                document.getElementById('name').textContent = firstName;
                document.getElementById('email').textContent = email;
                document.getElementById('phone').textContent = phone;
                document.getElementById('country').textContent = country;
                
                document.getElementById('submit').addEventListener('click', function () {
                    document.getElementById('usernameField').value = username;
                 });
                  document.getElementById('delete').addEventListener('click', function () {
                    document.getElementById('usernameForDelete').value = username;
                 });
                
                
              
                
                getReservation()
                 
             
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                alert("Error in the authorization. Login again!");
                window.location.href = "../index.jsp";
            });
        }
        else{
        	window.location.href = "../index.jsp";	
        }
        
        
        
function getReservation() {
    var script = document.createElement('script');
    script.src = "../js/getReservation.js";
    document.head.appendChild(script);
}       
       
      
        