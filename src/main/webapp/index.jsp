<%-- 
    Document   : index
    Created on : 19 Jun 2023, 09:40:59
    Author     : jarro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Controllers.StoryController"%>
<%@page import="java.util.List"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>index</title>
        <% List<Story> topPicks = (List<Story>) request.getAttribute("topPicks");
           Boolean getTopPicksCalled = (Boolean) request.getAttribute("getTopPicksCalled");
           if (getTopPicksCalled == null) {
                getTopPicksCalled = false;
            }
   if (topPicks == null && !getTopPicksCalled) {
        %>
        <script>
            window.location.replace("StoryController?submit=getTopPicks");
        </script>
        <% } %>

    </head>
    <body>
        <h1>Hello World!</h1>
        <div>
            <%
       if (topPicks != null) {
           for (Story story : topPicks) { %>
            <div id="storycard">
                <ul>
                    <li><%=story.getTitle()%></li>
                </ul>
            </div>

            <% }
    } 
            %>
            <a href="ImageTestWebPage.jsp">Test Images</a>
        </div>
    </body>
</html>
