<%-- 
    Document   : createStory
    Created on : 15 Jun 2023, 13:41:37
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Story</title>
    </head>
    <body>
        <%
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
            Writer user = (Writer) request.getSession(false).getAttribute("user");
            if  (genres!=null) {
        %>
        <h1><%=genres%></h1>
        <%}%>
        <h1>Write a new story</h1>
        <form action="StoryController" method="post" enctype="multipart/form-data">
            <div>
                <label for="title">Title:</label><br>
                <input type="text" id="title" name="title" required>
            </div>
            <div>
                <label for="image">Upload Image:</label><br>
                <input type="file" id="image" name="image" accept="image/*" required>
            </div>
            <div>
                <label for="story">Story:</label><br>
                <textarea id="story" name="story" rows="10" cols="50" required></textarea>
            </div>
            <div>
                <label for="summary">Summary:</label><br>
                <textarea id="summary" name="summary" rows="5" cols="50" required></textarea>
            </div>
            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    Select Genres
                </button>
                <ul class="dropdown-menu checkbox-menu allow-focus" aria-labelledby="dropdownMenuButton">
                    <% for(Genre genre: genres) { %>
                    <li>
                        <label>
                            <input type="checkbox" name="<%= genre.getId() %>" value="<%= genre.getId() %>"> <%= genre.getName() %>
                        </label>
                    </li>
                    <% } %>
                </ul>
            </div>
            <input type="submit" value="addStory" name="submit">
            <input type="submit" value="saveToDraft" name="submit">
        </form>
    </body>
</html>