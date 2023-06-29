<%@page import="Models.Writer"%>
<%@page import="Models.Reader"%>
<%@page import="Models.Account"%>
<%@page import="java.time.LocalDate"%>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Data Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <style>
        /* Custom CSS to fix the navbar position */
        #navbar-container {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 9999;
        }
        
        
        #content-container {
            padding-top: 80px; /* Adjust the padding value as needed */
        }
        
        #content-container2{
            padding-top: 700px; /* Adjust the padding value as needed */
        }
        
        #content-container3{
            padding-top: 2000px; /* Adjust the padding value as needed */
        }
        
        

        .card {
            border: 1px solid #ddd;
            border-radius: 5px;
            transition: transform 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            border-color: #007bff;
            box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
        }

        .card-fixed {
            height: 400px;
        }

        .card-img-top-fixed {
            width: 100%;
            height: 250px;
            object-fit: cover;
        }

        .space {
            margin-bottom: 100px;
        }

        .other-space {
            margin-bottom: 40px;
        }
    </style>
</head>

<body>
<%
    Account user = (Account) request.getSession(false).getAttribute("user");
    Reader reader = null;
    Writer writer = null;
    if (user != null && user.getUserType().equals("R")) {
        reader = (Reader) user;
    } else if (user != null && user.getUserType().equals("W")) {
        writer = (Writer) user;
    }
%>

<div id="navbar-container">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/">
                <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                READERS ARE INNOVATORS
            </a>
            <div class="d-flex align-items-center">
                <form>
                    <input class="form-control me-2" type="search" placeholder="Search for titles, genres, blurbs..." aria-label="Search" name="searchValue" required>
                    <input type="hidden" name="submit" value="searchForGenreAndStories">
                </form>
                <% if (user != null && (user.getUserType().equals("R") || user.getUserType().equals("W"))) { %>
                    <!-- Button trigger profile modal -->
                    <button type="button" class="btn btn-primary ms-2" data-bs-toggle="modal" data-bs-target="#profileDetails">
                        Profile
                    </button>
                    <a class="btn btn-primary ms-2" href="LoginController?submit=logout">Logout</a>
                <% } %>
                <% if (writer != null) { %>
                    <a class="btn btn-primary ms-2" href="StoryController?submit=manageStories">Manage Stories</a>
                <% } %>
            </div>
        </div>
    </nav>
</div>


<div id="content-container">
<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="mosteditors">
    <input type="hidden" name="startDate" value="<%= LocalDate.now() %>">
    <input type="hidden" name="endDate" value="<%= LocalDate.now() %>">
    <input type="submit" value="Show Most Editors Chart">
</form>
<%
    // Set the chartNumber attribute in the request
    int chartNumber = 1; // Set the desired chartNumber
    request.setAttribute("chartNumber", chartNumber);
%>

<%@ include file="chart.jsp" %>

    </div>
    
    
<div id="content-container2">    
    
<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="topwriters">
    <input type="hidden" name="startDate" value="<%= LocalDate.now() %>">
    <input type="hidden" name="endDate" value="<%= LocalDate.now() %>">
    <input type="submit" value="Show the top writers chart">
</form>

<%
    // Set the chartNumber attribute in the request
    int chartNumber2 =2; // Set the desired chartNumber
    request.setAttribute("chartNumber", chartNumber2);
%>

<%@ include file="chart.jsp" %>

</div>
    

<div id="content-container2">    

<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="mostlikedstories">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the most liked stories chart">
</form>

<%
    // Set the chartNumber attribute in the request
    int chartNumber3 =3; // Set the desired chartNumber
    request.setAttribute("chartNumber", chartNumber3);
%>

<%@ include file="chart.jsp" %>
</div>

    
<div id="content-container2">  
<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="topratedstories">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the top rated stories">
</form>
<%
    // Set the chartNumber attribute in the request
    int chartNumber4 = 4; // Set the desired chartNumber
    request.setAttribute("chartNumber", chartNumber4);
%>

<%@ include file="chart.jsp" %></div>

<div id="content-container2">  
<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="topgenres">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the top genres chart">
</form>
<%
    // Set the chartNumber attribute in the request
    int chartNumber5 = 5; // Set the desired chartNumber
    request.setAttribute("chartNumber", chartNumber5);
%>

<%@ include file="chart.jsp" %></div>
</div>

<div id="content-container2"> 
<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="mostviewedstories">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the most viewed stories chart">
</form>
<%
    // Set the chartNumber attribute in the request
    int chartNumber6 = 6; // Set the desired chartNumber
    request.setAttribute("chartNumber", chartNumber6);
%>

<%@ include file="chart.jsp" %></div></div>

</div>
</body>
</html>
