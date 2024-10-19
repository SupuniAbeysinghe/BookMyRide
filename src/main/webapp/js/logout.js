  
  // Usage example
	const idToken = localStorage.getItem('access_token');
	
	const state = localStorage.getItem('state');
	console.log(state);
	document.getElementById('logout').addEventListener('click', function () {
			   document.getElementById("client-id").value = client_Id;
			   document.getElementById("post-logout-redirect-uri").value = postLogoutRedirectUri;
			   document.getElementById("state").value = state;
			   localStorage.clear();
	});