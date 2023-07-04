<%-- 
    Document   : SelectReportData
    Created on : 29 Jun 2023, 15:15:51
    Author     : Jarrod
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Data Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.6.0/font/bootstrap-icons.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <style>
        .other-space{
            margin-bottom: 100px;
        }
        body{
            background-color: #333333;
            color: white;
        }
    </style>
    <body>

        <!--navbar-->
    <div class="space-div"></div>
    <%
        Account user = (Account) request.getSession(false).getAttribute("user");
        String message = (String) request.getAttribute("message");
    %>

    <div id="navbar-container">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <button class="btn btn-dark" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="sidebar" aria-expanded="false" style="position: absolute; left: 0;">
                    <i class="bi bi-list"></i> <!-- More Icon -->
                </button>
                <div class="container-fluid">
                    <a class="navbar-brand position-relative" href="http://localhost:8080/RIPClientMaven/">
                    <img src="book.svg" alt="Book Icon" class="me-2 " width="24" height="24" style="filter: invert(1)" >READERS ARE INNOVATORS</a>
                </div>
                <div class="d-flex align-items-center">
                    <%
                        if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
                    %>
                    <!-- Button trigger profile modal -->


                    <%
                        }
                    %>
                </div>
        </nav>
    </div>

    <!--side-navbar-->
    <div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="sidebar" aria-labelledby="sidebar">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasExampleLabel">Menu</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body">
            <div class="d-grid">
                <button class="btn btn-dark " type="button" data-bs-toggle="modal" data-bs-target="#profileDetails"><i class="bi bi-person-fill"></i> Profile</button>
                <a class="btn btn-dark " href="LoginController?submit=logout"><i class="bi bi-box-arrow-right"></i>Logout</a>
            </div>
        </div>
    </div>

    
        <div class="other-space"></div>
        <%
            if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
        %>
        <!-- Editors select which charts they'd like to see -->
        <div class="container mt-5">
            <div class="row mt-5">
                <h1>Generate Data Report</h1>
                <form action="DataReportController" method="post">
                    <div class="col-auto">
                        <div class="mb-3">
                            <div class="form-check">
                                <input name="reportOptions" class="form-check-input" type="checkbox" value="mostViewedStories" id="mostViewedStories">
                                <label class="form-check-label" for="mostViewed">
                                    Top 10 Most Viewed Stories
                                </label>
                            </div>
                            <label class="form-label" for="startDate">Start Date</label>
                            <input class="form-control" type="date" id="startDate" name="startDate">
                            <label class="form-label" for="endDate">End Date</label>
                            <input class="form-control" type="date" id="endDate" name="endDate">
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input name="reportOptions" class="form-check-input" type="checkbox" value="mostRatedStories" id="mostRatedStories" >
                                <label class="form-check-label" for="mostRated">
                                    Top 20 Most Rated Stories Of The Month
                                </label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input name="reportOptions" class="form-check-input" type="checkbox" value="mostLikedStories" id="mostLikedStories" >
                                <label class="form-check-label" for="mostLiked">
                                    Top 20 Most Liked Stories
                                </label>
                                <select name="monthOfMostLikedStories" class="form-select" aria-label="monthOfMostLikedStories">
                                    <option selected>Select a month</option>
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                    <option value="4">April</option>
                                    <option value="5">May</option>
                                    <option value="6">June</option>
                                    <option value="7">July</option>
                                    <option value="8">August</option>
                                    <option value="9">September</option>
                                    <option value="10">October</option>
                                    <option value="11">November</option>
                                    <option value="12">December</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input name="reportOptions" class="form-check-input" type="checkbox" value="topGenres" id="topGenres" >
                                <label class="form-check-label" for="topGenres">
                                    Top 3 Genres Of The Month
                                </label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input name="reportOptions" class="form-check-input" type="checkbox" value="topWriters" id="topWriters">
                                <label class="form-check-label" for="topWriters">
                                    Top 30 Writers Of All Time(Based on views)
                                </label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <input name="reportOptions" class="form-check-input" type="checkbox" value="topEditors" id="topEditors">
                                <label class="form-check-label" for="topEditors">
                                    Top 3 Editors Of All Time
                                </label>
                            </div>
                        </div>
                        <div class="mb-3">
                            <input type="hidden" name="submit" value="showcharts">
                            <button type="submit" class="btn btn-primary mb-3">Generate Reports</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-primary mx-auto my-auto" role="alert">
            <h4 class="alert-heading">You are not currently logged in.</h4>
        </div> 
        <%
            }
        %>
    </body>
</html>
