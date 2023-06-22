<%-- 
    Document   : ManageStory
    Created on : 22 Jun 2023, 09:11:19
    Author     : faiza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@page import="java.util.Arrays"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Stories Page</title>
    </head>
    <body>
        <%
            List<Story> submittedStories = (List<Story>) request.getAttribute("submittedStories");
            List<Story> draftedStories = (List<Story>) request.getAttribute("draftedStories");
        %>
        
        <h1>Submitted Stories</h1>
        <%
            if  (submittedStories != null) {
        %>
        <table border="1">
            <tr>
                <th>Title</th>
                <th>Image</th>
                <th>Blurb</th>
                <th>Story</th>
                <th>Approval Status</th>
            </tr>
            <%
                for (Story story : submittedStories) {
            %>
            <tr>
                <td><%=story.getTitle()%></td>
                <td><img src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Story Image"></td>
                <td><%=story.getBlurb()%></td>
                <td><%=story.getContent()%></td>
                <%
                    String approvalStatus;
                    if (story.getRejected()) {
                        approvalStatus = "Rejected";
                    } else if (story.getApproved()) {
                        approvalStatus = "Approved";
                    } else {
                        approvalStatus = "Waiting Approval";
                    }
                %>
                <td><%=approvalStatus%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } else {
        %>
        <h3>You currently have no submitted stories.</h3>
        <%
            }
        %>
        
        <h1>Drafts</h1>
        <%
            if  (draftedStories != null) {
        %>
        <table border="1">
            <tr>
                <th>Title</th>
                <th>Image</th>
                <th>Blurb</th>
                <th>Story</th>
                <th>Action</th>
            </tr>
            <%
                for (Story story : draftedStories) {
            %>
            <tr>
               <td><%=story.getTitle()%></td>
                <td><img src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Story Image"></td>
                <td><%=story.getBlurb()%></td>
                <td><%=story.getContent()%></td>
                <td><button type="button">Submit Story</button></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } else {
        %>
        <h3>You currently have no drafted stories.</h3>
        <%
            }
        %>
    </body>
</html>
