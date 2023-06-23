<%-- 
    Document   : EditStoryPage
    Created on : 21 Jun 2023, 15:02:51
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>s
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Story Page</title>
    </head>
    <body>
        <%
            List<Story> submittedStories = (List<Story>) request.getAttribute("submittedStories");
            List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
        %>
        <h1>Select stories page</h1>
        <%
            if  (submittedStories != null) {
        %>
        <table border="1">
            <tr>
                <th>Author</th>
                <th>Title</th>
                <th>Image</th>
                <th>Genres</th>
                <th>Blurb</th>
                <th>Story</th>
                <th>Action</th>
            </tr>
            <%
                for (Story story : submittedStories) {
            %>
            <tr>
                <td>Author/Writer</td>
                <td><input type="text" value="<%=story.getTitle()%>"></td>
                <td>
                    <img src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image"><br>
                </td>
                <td>
                    <%
                        if (genres != null) {
                            for (Genre genre : genres) {
                    %>
                    <input type="checkbox" name="<%=genre.getId()%>" value="<%=genre.getId()%>" <%if (story.getGenreIds().contains(genre.getId())) {%>checked<%}%>> <%=genre.getName()%><br>
                    <%      }
                        }
                    %>
                </td>
                <td><textarea><%=story.getBlurb()%></textarea></td>
                <td><textarea><%=story.getContent()%></textarea></td>
                <td>
                    <button type="button">Approve</button>
                    <button type="button">Deny</button>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } else {
        %>
        <h3>There are currently no stories to approve.</h3>
        <%
            }
        %>
    </body>
</html>
