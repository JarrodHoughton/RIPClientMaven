<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<%@ page import="org.json.JSONArray" %>
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
    <form action="DataReportController" method="post">
        <div id="content-container1">
            <input type="hidden" name="submit" value="showcharts">
            <input type="hidden" name="startDate" value="<%= LocalDate.now() %>">
            <input type="hidden" name="endDate" value="<%= LocalDate.now() %>">
            <canvas id="dataChart1"></canvas>
        </div>

        <div id="content-container2">
            <input type="hidden" name="submit" value="showcharts">
            <input type="hidden" name="startDate" value="<%= LocalDate.now() %>">
            <input type="hidden" name="endDate" value="<%= LocalDate.now() %>">
            <canvas id="dataChart2"></canvas>
        </div>

        <div id="content-container3">
            <label for="startDate1">Start Date:</label>
            <input type="date" id="startDate1" name="startDate1" required>
            <label for="endDate1">End Date:</label>
            <input type="date" id="endDate1" name="endDate1" required>
            <canvas id="dataChart3"></canvas>
        </div>

        <div id="content-container4">
            <label for="startDate2">Start Date:</label>
            <input type="date" id="startDate2" name="startDate2" required>
            <label for="endDate2">End Date:</label>
            <input type="date" id="endDate2" name="endDate2" required>
            <canvas id="dataChart4"></canvas>
        </div>

        <div id="content-container5">
            <label for="startDate3">Start Date:</label>
            <input type="date" id="startDate3" name="startDate3" required>
            <label for="endDate3">End Date:</label>
            <input type="date" id="endDate3" name="endDate3">
            <canvas id="dataChart5"></canvas>
        </div>

        <div id="content-container6">
            <label for="startDate4">Start Date:</label>
            <input type="date" id="startDate4" name="startDate4" required>
            <label for="endDate4">End Date:</label>
            <input type="date" id="endDate4" name="endDate4" required>
            <canvas id="dataChart6"></canvas>
        </div>

        <input type="submit" value="Show Charts">
    </form>

    <script>
        function generateChart(chartNumber, dataLabels, dataValues, dataLabelString, valueLabelString, chartTitle) {
            var canvas = document.getElementById("dataChart" + chartNumber);
            var ctx = canvas.getContext("2d");
            var existingChart = Chart.getChart(ctx);

            // Destroy the existing chart if it exists
            if (existingChart) {
                existingChart.destroy();
            }

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: dataLabels,
                    datasets: [{
                        label: valueLabelString,
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
                                text: valueLabelString
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: dataLabelString
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        title: {
                            display: true,
                            text: chartTitle,
                            position: 'top',
                            font: {
                                size: 16,
                                weight: 'bold'
                            }
                        }
                    }
                }
            });
        }
    </script>

    <script>
        var dataLabels1 = <%= new JSONArray((List<String>) request.getAttribute("dataLabels1")) %>;
        var dataValues1 = <%= new JSONArray((List<Number>) request.getAttribute("dataValues1")) %>;
        var dataLabelString1 = '<%= (String) request.getAttribute("dataLabelString1") %>';
        var valueLabelString1 = '<%= (String) request.getAttribute("valueLabelString1") %>';
        var chartTitle1 = '<%= (String) request.getAttribute("charttitle1") %>';
        generateChart(1, dataLabels1, dataValues1, dataLabelString1, valueLabelString1, chartTitle1);

        var dataLabels2 = <%= new JSONArray((List<String>) request.getAttribute("dataLabels4")) %>;
        var dataValues2 = <%= new JSONArray((List<Number>) request.getAttribute("dataValues4")) %>;
        var dataLabelString2 = '<%= (String) request.getAttribute("dataLabelString4") %>';
        var valueLabelString2 = '<%= (String) request.getAttribute("valueLabelString4") %>';
        var chartTitle2 = '<%= (String) request.getAttribute("charttitle4") %>';
        generateChart(2, dataLabels2, dataValues2, dataLabelString2, valueLabelString2, chartTitle2);
        
                var dataLabels3 = <%= new JSONArray((List<String>) request.getAttribute("dataLabels2")) %>;
        var dataValues3 = <%= new JSONArray((List<Number>) request.getAttribute("dataValues2")) %>;
        var dataLabelString3 = '<%= (String) request.getAttribute("dataLabelString2") %>';
        var valueLabelString3 = '<%= (String) request.getAttribute("valueLabelString2") %>';
        var chartTitle3 = '<%= (String) request.getAttribute("charttitle2") %>';
        generateChart(3, dataLabels3, dataValues3, dataLabelString3, valueLabelString3, chartTitle3);

        var dataLabels4 = <%= new JSONArray((List<String>) request.getAttribute("dataLabels3")) %>;
        var dataValues4 = <%= new JSONArray((List<Number>) request.getAttribute("dataValues3")) %>;
        var dataLabelString4 = '<%= (String) request.getAttribute("dataLabelString3") %>';
        var valueLabelString4 = '<%= (String) request.getAttribute("valueLabelString3") %>';
        var chartTitle4 = '<%= (String) request.getAttribute("charttitle3") %>';
        generateChart(4, dataLabels4, dataValues4, dataLabelString4, valueLabelString4, chartTitle4);

        var dataLabels5 = <%= new JSONArray((List<String>) request.getAttribute("dataLabels5")) %>;
        var dataValues5 = <%= new JSONArray((List<Number>) request.getAttribute("dataValues5")) %>;
        var dataLabelString5 = '<%= (String) request.getAttribute("dataLabelString5") %>';
        var valueLabelString5 = '<%= (String) request.getAttribute("valueLabelString5") %>';
        var chartTitle5 = '<%= (String) request.getAttribute("charttitle5") %>';
        generateChart(5, dataLabels5, dataValues5, dataLabelString5, valueLabelString5, chartTitle5);

        var dataLabels6 = <%= new JSONArray((List<String>) request.getAttribute("dataLabels6")) %>;
        var dataValues6 = <%= new JSONArray((List<Number>) request.getAttribute("dataValues6")) %>;
        var dataLabelString6 = '<%= (String) request.getAttribute("dataLabelString6") %>';
        var valueLabelString6 = '<%= (String) request.getAttribute("valueLabelString6") %>';
        var chartTitle6 = '<%= (String) request.getAttribute("charttitle6") %>';
        generateChart(6, dataLabels6, dataValues6, dataLabelString6, valueLabelString6, chartTitle6);

        document.getElementById("startDate1").addEventListener("change", function () {
            document.getElementById("content-container1").submit();
        });
        document.getElementById("endDate1").addEventListener("change", function () {
            document.getElementById("content-container1").submit();
        });

        document.getElementById("startDate2").addEventListener("change", function () {
            document.getElementById("content-container2").submit();
        });
        document.getElementById("endDate2").addEventListener("change", function () {
            document.getElementById("content-container2").submit();
        });

        document.getElementById("startDate3").addEventListener("change", function () {
            document.getElementById("content-container3").submit();
        });
        document.getElementById("endDate3").addEventListener("change", function () {
            document.getElementById("content-container3").submit();
        });

        document.getElementById("startDate4").addEventListener("change", function () {
            document.getElementById("content-container4").submit();
        });
        document.getElementById("endDate4").addEventListener("change", function () {
            document.getElementById("content-container4").submit();
        });

        document.getElementById("startDate5").addEventListener("change", function () {
            document.getElementById("content-container5").submit();
        });
        document.getElementById("endDate5").addEventListener("change", function () {
            document.getElementById("content-container5").submit();
        });

        document.getElementById("startDate6").addEventListener("change", function () {
            document.getElementById("content-container6").submit();
        });
        document.getElementById("endDate6").addEventListener("change", function () {
            document.getElementById("content-container6").submit();
        });
    </script>
</body>
</html>
