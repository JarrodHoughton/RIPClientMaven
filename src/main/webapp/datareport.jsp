<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Data Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <canvas id="chart" width="400" height="400"></canvas>
    <div>
        <h3><%= request.getAttribute("dataLabelString") + " " %>Names:</h3>
        <ul>
            <% for (Object name : (List<?>) request.getAttribute("dataLabels")) { %>
                <li><%= name %></li>
            <% } %>
        </ul>
        <h3><%= request.getAttribute("valueLabelString") %></h3>
        <ul>
            <% for (Object data : (List<?>) request.getAttribute("dataValues")) { %>
                <li><%= data %></li>
            <% } %>
        </ul>
    </div>
    <script>
        // Get the data from the request attributes
        var dataLabels = <%= new JSONArray((List<?>) request.getAttribute("dataLabels")) %>;
        var dataValues = <%= new JSONArray((List<?>) request.getAttribute("dataValues")) %>;
        var valueLabel = '<%= request.getAttribute("valueLabelString") %>';

        // Check if arrays are not empty
        if (dataLabels.length > 0 && dataValues.length > 0) {
            // Create the chart
            var ctx = document.getElementById('chart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: dataLabels,
                    datasets: [{
                        label: valueLabel,
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
                            precision: 0
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>