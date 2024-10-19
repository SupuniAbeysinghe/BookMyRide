package com.services.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

public class ServiceDAO {
	
	String dbUrl = "jdbc:mysql://172.187.178.153:3306/isec_assessment2";
	String dbUser = "isec";
	String dbPassword = "EUHHaYAmtzbv";
;
	
    public List<String> getFutureServices(String username) throws ClassNotFoundException, SQLException{
    	
		ResultSet futureResultSet = null;
		Connection conn = null;
	     List<String> futureResultSetData = new ArrayList<>();

	try {
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    
	    conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	  


	    String futureSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) >= ? ORDER BY date, time";
	    
	    PreparedStatement futurePreparedStatement = conn.prepareStatement(futureSql);
	    futurePreparedStatement.setString(1, username);
	    
	    SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String currentDateTime = dateTimeFormat.format(new Date());
	    futurePreparedStatement.setString(2, currentDateTime);
	    
		 futureResultSet = futurePreparedStatement.executeQuery();
		 
		 futureResultSetData = JavaToJavaScript(futureResultSet);
		 conn.close();
	
		}catch (SQLException e) {
			e.printStackTrace();
			
			}
	return futureResultSetData;
        
    }
    
public List<String> getPastServices(String username) throws ClassNotFoundException, SQLException {
    	
			ResultSet pastResultSet = null;
			Connection conn = null;
			List<String> pastResultSetData = new ArrayList<>();
		     
		
		try {
		
		Class.forName("com.mysql.cj.jdbc.Driver");
			    
		conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			  

		String pastSql = "SELECT * FROM vehicle_service WHERE username = ? AND CONCAT(date, ' ', time) < ? ORDER BY date, time";
		
		PreparedStatement pastPreparedStatement = conn.prepareStatement(pastSql);
	
		pastPreparedStatement.setString(1, username);
		
		SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String currentDateTime = dateTimeFormat.format(new Date());
		pastPreparedStatement.setString(2, currentDateTime);
		
		pastResultSet = pastPreparedStatement.executeQuery();
		
		pastResultSetData = JavaToJavaScript(pastResultSet);
		conn.close();
		
		
			} catch (SQLException e) {
			e.printStackTrace();
			
			}
		return pastResultSetData;

        
    }
    
    public int deleteServices(int bookingId, String username) throws ClassNotFoundException {
    	PreparedStatement preparedStatement = null;

    	try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
		    
    		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    			  

    	   
    	    String sql = "DELETE FROM vehicle_service WHERE booking_id = ? AND username = ?";

    	    preparedStatement = conn.prepareStatement(sql);

    	    preparedStatement.setInt(1, bookingId);
    	    preparedStatement.setString(2, username);

    	    int rowsAffected = preparedStatement.executeUpdate();
    	    
    	    
    	    conn.close();
    	    return rowsAffected;
    	}catch (SQLException e) {
    	    e.printStackTrace();
    	    return -1;
    	} 
    }
    
    
    public int insertService(String location, String mileageStr, String vehicle_no, String message, String userName, String dateStr, String timeStr) throws ParseException, ClassNotFoundException {

 	   try {
 	        int mileage = Integer.parseInt(mileageStr);

 	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
 	        Date date = dateFormat.parse(dateStr);
 	     
 	        
 	        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("h:mm a");

 	        LocalTime localTime = LocalTime.parse(timeStr, inputFormatter);

 	        Time time = Time.valueOf(localTime);


 	        Class.forName("com.mysql.cj.jdbc.Driver");
 	        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

 	        String sql = "INSERT INTO vehicle_service (date, time, location, mileage, vehicle_no, message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";

 	        PreparedStatement preparedStatement = conn.prepareStatement(sql);

 	        // Set the parameter values (after applying HTML escaping)
 	        preparedStatement.setDate(1, new java.sql.Date(date.getTime()));
 	        preparedStatement.setTime(2, time);
 	        preparedStatement.setString(3, escapeHtml(location));
 	        preparedStatement.setInt(4, mileage);
 	        preparedStatement.setString(5, escapeHtml(vehicle_no));
 	        preparedStatement.setString(6, escapeHtml(message));
 	        preparedStatement.setString(7, escapeHtml(userName));

 	        int rowsInserted = preparedStatement.executeUpdate();
 	        conn.close();

 	        return rowsInserted;
 	    } catch (SQLException e) {
 	        e.printStackTrace();
 	        return -1;
 	    }
    }

    public List<String> JavaToJavaScript(ResultSet resultSet) throws SQLException{
    	
        List<String> javascriptObjects = new ArrayList<>();

        while (resultSet.next()) {
        	int bookingId = resultSet.getInt("booking_id");
            String date = escapeHtml(resultSet.getString("date"));
            String time = escapeHtml(resultSet.getString("time"));
            String location = escapeHtml(resultSet.getString("location"));
            int mileage = resultSet.getInt("mileage");
            String vehicleNo = escapeHtml(resultSet.getString("vehicle_no"));
            String message1 = escapeHtml(resultSet.getString("message"));

            String javascriptObject = String.format("{\"bookingId\": %d, \"date\": \"%s\", \"time\": \"%s\", \"location\": \"%s\", \"mileage\": %d, \"vehicleNo\": \"%s\", \"message\": \"%s\"}",
                    bookingId, date, time, location, mileage, vehicleNo, message1);

            javascriptObjects.add(javascriptObject);

        }
        return javascriptObjects;
        
    	
    }
    
    
    // Method to escape HTML characters
    private String escapeHtml(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
    
}