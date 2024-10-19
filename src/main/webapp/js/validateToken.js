        var accessToken = localStorage.getItem('access_token');

        // Encode client ID and client secret in Base64
        var authHeader = 'Basic ' + btoa(client_Id + ':' + client_secret);

        var xhr = new XMLHttpRequest();

        xhr.open('POST', introspectionEndpointUrl, true);

        // Set request headers
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('Authorization', authHeader);

        // Prepare the request data
        var requestData = 'token=' + encodeURIComponent(accessToken);

        // Define a function to handle the response
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    console.log(xhr.responseText);
                } else {
                    console.error('Error: ' + xhr.status);
                }
            }
        };

        xhr.send(requestData);

