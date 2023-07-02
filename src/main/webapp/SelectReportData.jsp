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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
        <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <title>Data Report</title>
    </head>
    <style>
        html,
        body {
            height: 100%;
        }

        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .other-space{
            margin-bottom: 100px;
        }
    </style>
    <body>
        <%
            Account user = (Account) request.getSession(false).getAttribute("user");
        %>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
            <div class="container">
                <a class="navbar-brand" href="http://localhost:8080/RIPClientMaven/EditorLandingPage.jsp">
                    <img src="book.svg" alt="Book Icon" class="me-2" width="24" height="24" style="filter: invert(1)">
                    READERS ARE INNOVATORS
                </a>
                <div class="d-flex align-items-center">
                    <%
                        if (user != null && (user.getUserType().equals("E") || user.getUserType().equals("A"))) {
                    %>
                    <a class="btn btn-primary ms-2" href="LoginController?submit=logout">Logout</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </nav>
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
