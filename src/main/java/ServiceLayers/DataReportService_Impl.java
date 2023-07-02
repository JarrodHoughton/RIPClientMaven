package ServiceLayers;

import Models.Editor;
import Models.Genre;
import Models.Story;
import Models.Writer;
import Utils.GetProperties;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ws.rs.ProcessingException;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import java.io.IOException;
import java.net.URI;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DataReportService_Impl implements DataReportService_Interface {

    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;
    private HashMap<String, Object> params;

    public DataReportService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/datareport/";
    }

    @Override
    public Integer getStoryLikesByDate(Integer storyId, String startDate, String endDate) {
        String storyLikesPath = uri + "getStoryLikesByDate";

        // Build the query parameters
        URI storyLikesUri = UriBuilder.fromPath(storyLikesPath)
                .queryParam("storyId", storyId)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate)
                .build();
        webTarget = client.target(storyLikesUri);

        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public List<Story> getMostLikedStories(Integer numberOfStories, String startDate, String endDate) {
        List<Story> listOfStories = null;
        try {
            String mostLikedStoriesPath = uri + "getMostLikedStories";

            // Build the query parameters
            URI mostLikedStoriesUri = UriBuilder.fromPath(mostLikedStoriesPath)
                    .queryParam("numberOfStories", numberOfStories)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate)
                    .build();
            webTarget = client.target(mostLikedStoriesUri);

            // Perform the HTTP GET request
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                listOfStories = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Story>>() {
                });
            } else {
                System.err.println("Failed to retrieve most liked stories. Response status: " + response.getStatus());
                System.out.println(response.readEntity(String.class));
            }
        } catch (ProcessingException | IllegalStateException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return listOfStories;
    }

    @Override
    public List<Story> getMostViewedStoriesInATimePeriod(Integer numberOfEntries, String startDate, String endDate) {
        List<Story> listOfStories = null;
        try {
            String mostViewedStoriesPath = uri + "getMostViewedStories";

            // Build the query parameters
            URI mostViewedStoriesUri = UriBuilder.fromPath(mostViewedStoriesPath)
                    .queryParam("numberOfEntries", numberOfEntries)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate)
                    .build();
            webTarget = client.target(mostViewedStoriesUri);

            // Perform the HTTP GET request
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                listOfStories = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Story>>() {
                });
            } else {
                System.err.println("Failed to retrieve most viewed stories. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return listOfStories;
    }

    @Override
    public Integer getTheViewsOnAStoryInATimePeriod(Integer storyId, String startDate, String endDate) {
        String storyViewsPath = uri + "getStoryViewsByDate";

        // Build the query parameters
        URI storyViewsUri = UriBuilder.fromPath(storyViewsPath)
                .queryParam("storyId", storyId)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate)
                .build();
        webTarget = client.target(storyViewsUri);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public List<Story> getTopHighestRatedStoriesInTimePeriod(String startDate, String endDate, Integer numberOfEntries) {
        List<Story> listOfStories = null;
        try {
            String topRatedStoriesPath = uri + "getTopHighestRatedStories";

            // Build the query parameters
            URI topRatedStoriesUri = UriBuilder.fromPath(topRatedStoriesPath)
                    .queryParam("numberOfEntries", numberOfEntries)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate)
                    .build();
            webTarget = client.target(topRatedStoriesUri);

            // Perform the HTTP GET request
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                // Read the response entity as a list of Story objects
                listOfStories = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Story>>() {
                });
            } else {
                System.err.println("Failed to retrieve top rated stories. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return listOfStories;
    }

    @Override
    public Double getAverageRatingOfAStoryInATimePeriod(Integer storyId, String startDate, String endDate) {
        String storyRatingPath = uri + "getStoryRatingByDate";

        // Build the query parameters
        URI storyRatingUri = UriBuilder.fromPath(storyRatingPath)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate)
                .queryParam("storyId", storyId)
                .build();
        webTarget = client.target(storyRatingUri);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        if (response.getStatus() == 200) {
            String responseBody = response.readEntity(String.class);
            try {
                return Double.parseDouble(responseBody);
            } catch (NumberFormatException e) {
                // Handle the case when the response body cannot be parsed as a Double
                // Log an error or throw an exception to handle the issue appropriately
                return null; // or throw an exception
            }
        } else {
            // Handle the case when the response has an error status
            // Log an error or throw an exception to handle the issue appropriately
            return null; // or throw an exception
        }
    }

    @Override
    public List<Writer> getTopWriters(Integer numberOfWriters) {
        List<Writer> topWriters = null;
        try {
            String topWritersUri = uri + "getTopWriters/{numberOfWriters}";
            // Build the query parameters
            webTarget = client.target(topWritersUri).resolveTemplate("numberOfWriters", numberOfWriters);

            // Perform the HTTP GET request
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                topWriters = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Writer>>() {
                });
            } else {
                System.err.println("Failed to retrieve top writers. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return topWriters;
    }

    @Override
    public List<Genre> getTopGenres(String startDate, String endDate, Integer numberOfEntries) {
        List<Genre> listOfTopGenres = null;
        try {
            String topRatedStoriesPath = uri + "getTopGenres";

            //build query
            URI topRatedStoriesUri = UriBuilder.fromPath(topRatedStoriesPath)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate)
                    .queryParam("numberOfEntries", numberOfEntries)
                    .build();
            webTarget = client.target(topRatedStoriesUri);

            // Perform the HTTP GET request
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                // Read the response entity as a list of Genre objects
                listOfTopGenres = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Genre>>() {
                });
            } else {
                System.err.println("Failed to retrieve top genres. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return listOfTopGenres;
    }

    @Override
    public Integer getGenreViewsByDate(String startDate, String endDate, Integer genreId) {
        String genresViewsPath = uri + "getGenreViewsByDate";

        //build query
        URI genresViewsUri = UriBuilder.fromPath(genresViewsPath)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate)
                .queryParam("genreId", genreId)
                .build();
        webTarget = client.target(genresViewsUri);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public Integer getTotalViewsByWriterId(Integer writerId) {
        String totalViewsByWriterIdUri = uri + "getTotalViewsByWriterId/{writerId}";

        // Build the query parameters
        webTarget = client.target(totalViewsByWriterIdUri).resolveTemplate("writerId", writerId);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public List<Editor> getTopEditors(Integer numberOfEntries) {
        List<Editor> topEditors = null;
        try {
            String topEditorsUri = uri + "getTopEditors/{numberOfEntries}";

            // Build the query parameters
            webTarget = client.target(topEditorsUri).resolveTemplate("numberOfEntries", numberOfEntries);

            // Perform the HTTP GET request
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                topEditors = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Editor>>() {
                });
            } else {
                System.err.println("Failed to retrieve top editors. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return topEditors;
    }
}
