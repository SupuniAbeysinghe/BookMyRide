<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.sql.*, java.util.List, com.services.dao.*, org.json.simple.JSONArray, org.json.simple.JSONObject" %>

<%
    if (request.getParameter("username") != null) {
        ServiceDAO service = new ServiceDAO();
        List<String> pastResultSetData = new ArrayList<>();
        List<String> futureResultSetData = new ArrayList<>();
        JSONObject jsonObject = new JSONObject();
        JSONArray pastJsonArray = new JSONArray();
        JSONArray futureJsonArray = new JSONArray();
        //System.out.println("username: "+username);
        try {
            String username = request.getParameter("username");
            System.out.println("username: "+username);
    
				pastResultSetData = service.getPastServices(username);
            	futureResultSetData = service.getFutureServices(username);

            

            if (pastResultSetData == null) {
                pastResultSetData = new ArrayList<>();
            }
            if (futureResultSetData == null) {
                futureResultSetData = new ArrayList<>();
            }

            for (String data : pastResultSetData) {
                pastJsonArray.add(data);
            }
            for (String data : futureResultSetData) {
                futureJsonArray.add(data);
            }

            jsonObject.put("pastResultSetData", pastJsonArray);
            jsonObject.put("futureResultSetData", futureJsonArray);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(jsonObject.toJSONString());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
%>