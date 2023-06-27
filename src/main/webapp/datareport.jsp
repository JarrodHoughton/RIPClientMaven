<%@page import="java.time.LocalDate"%>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Data Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <h1>Data Report</h1>

<form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="mosteditors">
    <input type="hidden" name="startDate" value="<%= LocalDate.now() %>">
    <input type="hidden" name="endDate" value="<%= LocalDate.now() %>">
    <input type="submit" value="Show Most Editors Chart">
</form>
    
    <form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="mostlikedstories">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the most liked stories chart">
    </form>
    
    <form action="DataReportController" method="post">
   <input type="hidden" name="submit" value="topwriters">
    <input type="hidden" name="startDate" value="<%= LocalDate.now() %>">
    <input type="hidden" name="endDate" value="<%= LocalDate.now() %>">
    <input type="submit" value="Show the top writers chart">
    </form>
    
    <form action="DataReportController" method="post">
     <input type="hidden" name="submit" value="topratedstories">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the top rated stories">
    </form>
    
    <form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="topgenres">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the top genres chart">
    </form>
    
    <form action="DataReportController" method="post">
    <input type="hidden" name="submit" value="mostviewedstories">
    <label for="startDate">Start Date:</label>
    <input type="date" id="startDate" name="startDate" required>
    <label for="endDate">End Date:</label>
    <input type="date" id="endDate" name="endDate" required>
    <input type="submit" value="Show the most viewed stories chart" onclick="combineDateTime()">
    </form>
    



    <% 
        List<String> dataLabels = (List<String>) request.getAttribute("dataLabels");
        List<Number> dataValues = (List<Number>) request.getAttribute("dataValues");
        String dataLabelString = (String) request.getAttribute("dataLabelString");
        String valueLabelString = (String) request.getAttribute("valueLabelString");
        String chartTitle = (String) request.getAttribute("charttitle");

        if (dataLabels != null && dataValues != null && dataLabelString != null && valueLabelString != null) {
            JSONArray dataLabelsJsonArray = new JSONArray(dataLabels);
            JSONArray dataValuesJsonArray = new JSONArray(dataValues);
    %>
    <canvas id="dataChart"></canvas>
    <script>
        var dataLabels = <%= dataLabelsJsonArray %>;
        var dataValues = <%= dataValuesJsonArray %>;

        var ctx = document.getElementById('dataChart').getContext('2d');
        var dataChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dataLabels,
                datasets: [{
                    label: '<%= valueLabelString %>',
                    data: dataValues,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                        title: {
                            display: true,
                            text: '<%= valueLabelString %>'
                        }
                    },
                    x: {
                        title: {
                            display: true,
                            text: '<%= dataLabelString %>'
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    title: {
                        display: true,
                        text: '<%= chartTitle %>',
                        position: 'top',
                        font: {
                            size: 16,
                            weight: 'bold'
                        }
                    }
                }
            }
        });
    </script>
    <%
        } else {
    %>
    <p>No data to display</p>
    <% } %>
</body>
</html>
