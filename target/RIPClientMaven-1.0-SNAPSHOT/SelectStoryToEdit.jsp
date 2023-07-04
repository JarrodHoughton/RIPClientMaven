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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <title>Edit Story</title>
</head>
<style>
    .other-space {
        margin-bottom: 150px;
    }

    .space-one {
        margin-bottom: 20px;
    }

    body {
        background-color: #333333;
        color: white;
    }
    .approve-container{
        
    }
</style>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/EditorLandingPage.jsp">
            <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
            READERS ARE INNOVATORS
        </a>
    </div>
</nav>
<%
    List<Story> submittedStories = (List<Story>) request.getAttribute("submittedStories");
    List<Genre> genres = (List<Genre>) request.getSession(false).getAttribute("genres");
    String message = (String) request.getAttribute("message");
%>
<div class="other-space"></div>

<div class="container mt-8">
    <div class="container mt-5">
        <%
            if (message != null) {
        %>
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading"><%= message %></h4>
        </div>
        <%
            }
        %>
        <%
            if  (submittedStories != null) {
        %>
        <h2>Submitted Stories</h2>
        <table class="table" border="1">
            <thead class="table-dark">
            <tr>
                <th class="border-end">Author</th>
                <th class="border-end">Title</th>
                <th class="border-end">Image</th>
                <th class="border-end">Genres</th>
                <th class="border-end">Blurb</th>
                <th class="border-end">Story</th>
                <th class="border-end">Action</th>
            </tr>
            </thead>
            <tbody class="mb-2 ">
            <%
                for (Story story : submittedStories) {
            %>
            <tr>
                <td class="border-end border-dark">Author/Writer</td>
                <td class="border-end border-dark" ><%=story.getTitle()%></td>
                <td class="border-end border-dark">
                    <div class="text-center">
                        <%
                            if (story.getImage()!=null) {
                        %>
                        <img class="card-img-top card-img-top-fixed" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
                        <%
                            } else {
                        %>
                        <img class="card-img-top card-img-top-fixed" src="book.svg" alt="Book Image">
                        <%
                            }
                        %>
                    </div>
                </td>

                <td class="border-end border-dark">
                    <ul class="list-group list-group-flush">
                        <%
                            if (genres != null) {
                                for (Genre genre : genres) {
                                    if  (story.getGenreIds().contains(genre.getId())) {
                        %>
                        <li class="list-group-item"><%=genre.getName()%></li>
                        <%      
                                    }   
                                }
                            }
                        %>
                    </ul>
                </td>
                
                <td class="border-end border-dark"><%=story.getBlurb()%></td>
                <td class="border-end border-dark"><%=story.getContent()%></td>
                <td class="approve-container border-end border-dark">
                    <div class="btn-group-vertical " role="group">
                        <a class="btn btn-danger"
                           href="StoryController?submit=rejectStoryFromEditor&storyId=<%=story.getId()%>">
                            Deny
                        </a>
                        <a class="btn btn-primary"
                           href="StoryController?submit=goToEditStoryPage&storyId=<%=story.getId()%>">
                            Edit
                        </a>
                        <a class="btn btn-success"
                           href="StoryController?submit=submitStoryFromSelectStoryToEditPage&storyId=<%=story.getId()%>">
                            Approve
                        </a>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <div class="alert alert-primary mt-5" role="alert">
            <h4 class="alert-heading">There are currently no stories to approve.</h4>
        </div>
        <%
            }
        %>
    </div>
</div>

<div class="space-one"></div>
</body>
</html>
