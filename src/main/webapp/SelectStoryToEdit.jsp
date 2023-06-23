<%-- 
    Document   : EditStoryPage
    Created on : 21 Jun 2023, 15:02:51
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Story</title>
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
                <td><p><%=story.getTitle()%></p></td>
                <td>
                    <img src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image"><br>
                </td>
                <td>
                    <%
                        if (genres != null) {
                            for (Genre genre : genres) {
                    %>
                    <p><%=genre.getName()%></p><br>
                    <%      }
                        }
                    %>
                </td>
                <td><pre><%=story.getBlurb()%></pre></td>
                <td><pre><%=story.getContent()%></pre></td>
                <td>
                    <a href="StoryController?submit=goToEditStoryForEditor&storyId=<%=story.getId()%>">
                    <button type="button">Edit</button>
                    </a>
                    <a href="StoryController?submit=submitStoryFromEditor&storyId=<%=story.getId()%>">
                    <button type="button">Approve</button>
                    </a>
                    <a href="StoryController?submit=rejectStoryFromEditor&storyId=<%=story.getId()%>">
                    <button type="button">Deny</button>
                    </a>
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
