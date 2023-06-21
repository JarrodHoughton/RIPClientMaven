<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="org.apache.commons.lang3.ArrayUtils"%>
<%@page import="Models.Story"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Story Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
            }

            .container {
                display: flex;
                align-items: flex-start;
            }

            .image-container {
                width: 50%;
                margin-right: 20px;
            }

            .image {
                width: 100%;
                height: auto;
            }

            .details-container {
                flex-grow: 1;
            }

            .title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 10px;
            }

            .blurp {
                margin-bottom: 20px;
                max-width: 100%;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .rating-container {
                display: flex;
                justify-content: space-between;
            }

            .rating-box, .likes-box {
                flex-basis: 45%;
                padding: 10px;
                background-color: #007bff;
                color: #fff;
                text-align: center;
                font-size: 16px;
            }

            .comments-container {
                margin-top: 20px;
            }

            .comment {
                margin-bottom: 10px;
                padding: 10px;
                background-color: #f2f2f2;
            }

            .comment-author {
                font-weight: bold;
            }

            .comment-content {
                margin-top: 5px;
            }
        </style>
    </head>
    <body>
        <h1>Story Details</h1>
        <%
            List<Comment> comments = (List<Comment>) request.getAttribute("comments");
            Story story = (Story) request.getAttribute("story");
            if (story != null) {
        %>
        <div class="container">
            <div class="image-container">
                <img class="image" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
            </div>
            <div class="details-container">
                <h2 class="title"><%= story.getTitle() %></h2>
                <p class="blurp"><%= story.getBlurb() %></p>
                <div class="rating-container">
                    <div class="rating-box">Rating: <%= story.getRating() %></div>
                    <div class="likes-box">Likes: <%= story.getLikeCount() %></div>
                    <a class="btn btn-read-story" href="StoryController?submit=viewStory&storyId=<%= story.getId() %>">Read</a>
                </div>
            </div>
        </div>
        <%
            if (story.getCommentsEnabled() && comments != null) {
        %>
        <div class="comments-container">
            <h3>Comments</h3>
            <% 
                for (Comment comment : comments) {
            %>
            <div class="comment">
                <p class="comment-content"><%= comment.getMessage() %></p>
            </div>
            <%
                }
            %>
        </div>
        <%
            }
        %>
        <%
            }
        %>
    </body>
</html>
