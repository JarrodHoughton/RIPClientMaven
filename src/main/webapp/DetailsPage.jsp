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

            .column

            .body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
            }

            .container{
                flex-direction: column;
                width: 100%;

            }
            .story-container{
                flex-direction: row;

            }
            .comment-container{

            }
            .image-container{
                width: 40%;
            }
            .details-container{
                flex-direction: column;
            }
            .blurb-container{
                width: 60%;
            }
            .button-container{
                flex-direction: column;
            }
            .twobutton-container{
                flex-direction: row;
            }
            .readbutton-container{

            }
            .header{
                padding: 30px;
                text-align: center;
            }
            .header h1 {
                font-size: 50px;
            }
            .topnav {
                overflow: hidden;
                background-color: #333;
            }
            .topnav a {
                float: left;
                display: block;
                color: #f2f2f2;
                text-align: center;
                padding: 14px 16px;
                text-decoration: none;
            }
            .topnav a:hover {
                background-color: #ddd;
                color: black;
            }
            
            
            /*Star rating*/
            *{
                margin: 0;
                padding: 0;
            }
            .rate {
                float: left;
                height: 46px;
                padding: 0 10px;
            }
            .rate:not(:checked) > input {
                position:absolute;
                top:-9999px;
            }
            .rate:not(:checked) > label {
                float:right;
                width:1em;
                overflow:hidden;
                white-space:nowrap;
                cursor:pointer;
                font-size:30px;
                color:#ccc;
            }
            .rate:not(:checked) > label:before {
                content: '★ ';
            }
            .rate > input:checked ~ label {
                color: #ffc700;
            }
            .rate:not(:checked) > label:hover,
            .rate:not(:checked) > label:hover ~ label {
                color: #deb217;
            }
            .rate > input:checked + label:hover,
            .rate > input:checked + label:hover ~ label,
            .rate > input:checked ~ label:hover,
            .rate > input:checked ~ label:hover ~ label,
            .rate > label:hover ~ input:checked ~ label {
                color: #c59b08;
            }

            /* Modified from: https://github.com/mukulkant/Star-rating-using-pure-css */
        </style>
        <script>
            function autoSubmit(){
                document.getElementById("ratingForm").submit();
            }
        </script>
        <!-- StarRating -->
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <div class="header">
            <h1>READERS ARE INNOVATORS</h1>
        </div>

        <div class="topnav">
            <a href="#">Link</a>
            <a href="#">Link</a>
            <a href="#">Link</a>
            <a href="#" style="float:right">Link</a>
        </div>

        <h1>Story Details</h1>
        <%
        List<Comment> comments = (List<Comment>) request.getAttribute("comments");
        Story story = (Story) request.getAttribute("story");
        String likeMessage = (String) request.getAttribute("likeMessage");
        String ratingMessage = (String) request.getAttribute("ratingMessage");
        String commentMessage = (String) request.getAttribute("commentMessage");
        if (commentMessage!=null){%>
        <h3><%=commentMessage%></h3>
        <%}
                    if (ratingMessage!=null){%>
        <h3><%=ratingMessage%></h3>
        <%}
                    if (likeMessage!=null) {%>
        <h3><%=likeMessage%></h3>
        <%}
                    if (story != null) {%>
        <div class="container">
            <div class="story-container">
                <div class="image-container">
                    <img class="image" src="data:image/jpg;base64,<%=Base64.getEncoder().encodeToString(ArrayUtils.toPrimitive(story.getImage()))%>" alt="Book Image">
                </div>
                <div class="details-container">
                    <h2 class="title"><%= story.getTitle() %></h2>
                    <div class="blurb-container">
                        <p class="blurp"><%= story.getBlurb() %></p>
                    </div>

                    <div class="button-container">
                        <div class="rating-container">
                            <div class="rating-box">Rating: <%= story.getRating() %></div>
                            <div class="likes-box">Likes: <%= story.getLikeCount() %></div>
                        </div>
                        <div class="readbutton-container">
                            <a href="StoryController?submit=readStory&storyId=<%=story.getId()%>">Read</a>
                            <a href="StoryController?submit=likeStory&storyId=<%=story.getId()%>">Like</a>
                            <a href="StoryController?submit=rateStory&storyId=<%=story.getId()%>">Rate</a>
                            <form class="rate" id="ratingForm" action="StoryController" method="get">
                                <input type="radio" id="star5" name="rate" value="5" onchange="autoSubmit()"/>
                                <label for="star5" title="text">5 stars</label>
                                <input type="radio" id="star4" name="rate" value="4" onchange="autoSubmit()"/>
                                <label for="star4" title="text">4 stars</label>
                                <input type="radio" id="star3" name="rate" value="3" onchange="autoSubmit()"/>
                                <label for="star3" title="text">3 stars</label>
                                <input type="radio" id="star2" name="rate" value="2" onchange="autoSubmit()"/>
                                <label for="star2" title="text">2 stars</label>
                                <input type="radio" id="star1" name="rate" value="1" onchange="autoSubmit()"/>
                                <label for="star1" title="text">1 star</label>
                                <input type="hidden" name="isAdding" value="true"/>
                                <input type="hidden" name="storyId" value="<%=story.getId()%>"/>
                                <input type="hidden" name="submit" value="rateStory"/>
                            </form>
                        </div>

                        <form action="StoryController" method="post">
                            <div>
                                <textarea name="comment" id="comments" style="font-family:sans-serif;
                                          font-size:1.2em;">
                                    Leave a comment!
                                </textarea>
                            </div>
                            <input type="hidden" name="storyId" value="<%=story.getId()%>"/>
                            <input type="submit" name="submit" value="commentStory"/>
                        </form>
                    </div>
                </div>
            </div>
            <div class="comment-container">

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
        </div>
    </body>
</html>
