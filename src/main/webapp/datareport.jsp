<!DOCTYPE html>
<html>
    <head>
        <title>Data Report Example</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
        <canvas id="barChart"></canvas>

        <script>
            // Retrieve data from the Servlet
            var storyNames = ${requestScope.storynames};
            var numberOfLikes = ${requestScope.numberoflikes};

            // JavaScript code to generate the chart using the data
            var ctx = document.getElementById('barChart').getContext('2d');
            var chart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: storyNames,
                    datasets: [{
                            label: 'Number of Likes',
                            data: numberOfLikes,
                            backgroundColor: 'rgba(0, 123, 255, 0.5)',
                            borderColor: 'rgba(0, 123, 255, 1)',
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
    </body>
</html>
