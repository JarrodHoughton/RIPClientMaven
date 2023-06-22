<!DOCTYPE html>
<html>
<head>
  <title>Data Report</title>
  <!-- Add Chart.js library -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
  <h1>Data Report</h1>
  
  <button onclick="fetchMostLikedStoriesAndCreateChart()">Fetch Most Liked Stories</button>
  
  <canvas id="myChart"></canvas>
  
  <script>
  function fetchMostLikedStoriesAndCreateChart() {
  const numberOfStories = 5; // Replace with the desired number of stories
  const startDate = '2023-01-01'; // Replace with the actual start date
  const endDate = '2023-06-30'; // Replace with the actual end date

  // Make an AJAX request to fetch the most liked stories data from the server
  fetch(`/datareport/getMostLikedStories/${numberOfStories}/${startDate}/${endDate}`)
    .then(response => response.json())
    .then(data => {
      // Extract the necessary data for the chart
      const storyNames = data.map(story => story.name);
      const storyIds = data.map(story => story.id);

      // Fetch the likes for each story within the desired time period
      const fetchLikesPromises = storyIds.map(storyId =>
        fetch(`/datareport/getStoryLikesByDate/${storyId}/${startDate}/${endDate}`)
          .then(response => response.json())
          .then(likesData => likesData.reduce((sum, entry) => sum + entry.likes, 0))
      );

      // Wait for all the fetch requests to complete
      Promise.all(fetchLikesPromises)
        .then(likes => {
          // Create a new chart using the retrieved data
          const ctx = document.getElementById('myChart').getContext('2d');
          new Chart(ctx, {
            type: 'bar',
            data: {
              labels: storyNames,
              datasets: [{
                label: 'Likes',
                data: likes,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
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
        })
        .catch(error => {
          console.error('Error:', error);
        });
    })
    .catch(error => {
      console.error('Error:', error);
    });
}

  </script>
</body>
</html>
