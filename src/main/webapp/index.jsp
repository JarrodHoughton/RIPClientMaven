<%-- 
    Document   : index
    Created on : 19 Jun 2023, 09:40:59
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Controllers.StoryController"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>index</title>
        <% List<String> topPicks = (List<String>) request.getAttribute("topPicks");
   if (topPicks == null) {
        %>
        <script>
            window.location.replace("StoryController?submit=getTopPicks");
        </script>
        <% } %>
        
    </head>
    <body onload="myFunction()">
        <h1>Hello World!</h1>
        <div>
            <%
       if (topPicks != null) {
           for (String pick : topPicks) { %>
            <div id="storycard">
                <ul>
                    <li><%=pick %></li>
                </ul>
            </div>

            <% }
   } %>
        </div>
    </body>
</html>
