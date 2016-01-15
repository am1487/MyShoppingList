<%-- 
    Document   : logout
    Created on : Jan 14, 2016, 8:37:38 PM
    Author     : Mitsos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
        Cookie[] cookies = request.getCookies();
        
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                cookies[i].setMaxAge(0);
                response.addCookie(cookies[i]);
            }
            
        }
        response.sendRedirect("index.jsp");
%>