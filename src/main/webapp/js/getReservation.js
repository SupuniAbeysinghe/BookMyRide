var refreshInterval;

function clearTable(tableId) {
    var table = document.getElementById(tableId);
    var rows = table.getElementsByTagName('tr');

    for (var i = rows.length - 1; i > 0; i--) {
        table.deleteRow(i);
    }
}

function updateReservations() {
    $.ajax({
        url: 'fetchData.jsp',
        method: 'GET',
        data: { username: username },
        dataType: 'json',
        success: function(response) {

            if (response.pastResultSetData !== undefined) {
                var pastReservations = response.pastResultSetData;

                var pastTable = document.getElementById("pastTable");
				clearTable('pastTable');
               	pastReservations.forEach(function(reservation) {
		         var row = pastTable.insertRow();
		         var data;
		            try {

		                data = JSON.parse(reservation.replace(/date: '([^']*)'/g, '"date": "$1"').replace(/time: '([^']*)'/g, '"time": "$1"'));
		            } catch (e) {
		                console.error('Error parsing JSON:', e);
		                console.log('Invalid JSON:', reservation);
		                return;
		            }
		
		            var keys = ['bookingId', 'date', 'time', 'location', 'mileage', 'vehicleNo', 'message'];
		
		            keys.forEach(function(key) {
		                var cell = row.insertCell();
		                cell.innerHTML = data[key];
		            });
		        });
            }

            if (response.futureResultSetData !== undefined) {
                var futureReservations = response.futureResultSetData;

                var futureTable = document.getElementById("futureTable");

               clearTable('futureTable');
				futureReservations.forEach(function(reservation) {
				    var row = futureTable.insertRow();
				    var data;
				
				    try {
				        var cleanedReservation = reservation.replace(/[\u0000-\u001F]+/g, "");
				        data = JSON.parse(cleanedReservation.replace(/date: '([^']*)'/g, '"date": "$1"').replace(/time: '([^']*)'/g, '"time": "$1"'));
				    } catch (e) {
				        console.error('Error parsing JSON:', e);
				        console.log('Invalid JSON:', reservation);
				        return;
				    }
				
				    var keys = ['bookingId', 'date', 'time', 'location', 'mileage', 'vehicleNo', 'message'];
				
				    keys.forEach(function(key) {
				        var cell = row.insertCell();
				        cell.innerHTML = data[key];
				    });
				    
				    var deleteCell = row.insertCell();
				    var deleteButton = document.createElement('button');
				    deleteButton.setAttribute('class', 'delete');
				    deleteButton.setAttribute('onclick', `document.getElementById('id01').style.display='block'; document.getElementById('bookingID').value = ${data.bookingId};`);
				    deleteButton.innerHTML = 'Delete';
				    deleteCell.appendChild(deleteButton);
				});

            }

            clearInterval(refreshInterval);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data:', error);
        }
    });
}

$(document).ready(function() {
    updateReservations();
    refreshInterval = setInterval(updateReservations, 5000);
});



