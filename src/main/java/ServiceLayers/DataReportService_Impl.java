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

    public DataReportService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/datareport/";
    }

    @Override
    public Integer getStoryLikesByDate(Integer storyId, String startDate, String endDate) {
        String storyLikesUri = uri + "getStoryLikesByDate";

        // Build the query parameters
        UriBuilder uriBuilder = UriBuilder.fromUri(storyLikesUri)
                .queryParam("storyId", storyId)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate);

        webTarget = client.target(uriBuilder);

        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public List<Story> getMostLikedStories(Integer numberOfStories, String startDate, String endDate) {
        List<Story> listOfStories = null;
        try {
            String mostLikedStoriesUri = uri + "getMostLikedStories";

            // Build the query parameters
            UriBuilder uriBuilder = UriBuilder.fromUri(mostLikedStoriesUri)
                    .queryParam("numberOfStories", numberOfStories)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate);

            webTarget = client.target(uriBuilder);

            // Perform the HTTP GET request
            response = webTarget.request().get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                listOfStories = response.readEntity(new GenericType<List<Story>>() {});
            } else {
                System.err.println("Failed to retrieve most liked stories. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
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
            String mostViewedStoriesUri = uri + "getMostViewedStories";

            // Build the query parameters
            UriBuilder uriBuilder = UriBuilder.fromUri(mostViewedStoriesUri)
                    .queryParam("numberOfEntries", numberOfEntries)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate);

            webTarget = client.target(uriBuilder);

            // Perform the HTTP GET request
            response = webTarget.request().get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                listOfStories = response.readEntity(new GenericType<List<Story>>() {});
            } else {
                System.err.println("Failed to retrieve most viewed stories. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
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
        String storyViewsUri = uri + "getStoryViewsByDate";

        // Build the query parameters
        UriBuilder uriBuilder = UriBuilder.fromUri(storyViewsUri)
                .queryParam("storyId", storyId)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate);

        webTarget = client.target(uriBuilder);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public List<Story> getTopHighestRatedStoriesInTimePeriod(String startDate, String endDate, Integer numberOfEntries) {
        List<Story> listOfStories = null;
        try {
            String topRatedStoriesUri = uri + "getTopHighestRatedStories";

            // Build the query parameters
            UriBuilder uriBuilder = UriBuilder.fromUri(topRatedStoriesUri)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate)
                    .queryParam("numberOfEntries", numberOfEntries);

            webTarget = client.target(uriBuilder);

            // Perform the HTTP GET request
            response = webTarget.request().get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                // Read the response entity as a list of Story objects
                listOfStories = response.readEntity(new GenericType<List<Story>>() {});
            } else {
                System.err.println("Failed to retrieve top rated stories. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
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
    String storyRatingUri = uri + "getStoryRatingByDate";

    // Build the query parameters
    UriBuilder uriBuilder = UriBuilder.fromUri(storyRatingUri)
            .queryParam("startDate", startDate)
            .queryParam("endDate", endDate)
            .queryParam("storyId", storyId);

    webTarget = client.target(uriBuilder);

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
            String topWritersUri = uri + "getTopWriters";
            // Build the query parameters
            UriBuilder uriBuilder = UriBuilder.fromUri(topWritersUri)
                    .queryParam("numberOfWriters", numberOfWriters);

            webTarget = client.target(uriBuilder);

            // Perform the HTTP GET request
            response = webTarget.request().get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                topWriters = response.readEntity(new GenericType<List<Writer>>() {});
            } else {
                System.err.println("Failed to retrieve top writers. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
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
            String topRatedStoriesUri = uri + "getTopGenres";
            // Build the query parameters
            UriBuilder uriBuilder = UriBuilder.fromUri(topRatedStoriesUri)
                    .queryParam("startDate", startDate)
                    .queryParam("endDate", endDate)
                    .queryParam("numberOfEntries", numberOfEntries);

            webTarget = client.target(uriBuilder);

            // Perform the HTTP GET request
            response = webTarget.request().get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                // Read the response entity as a list of Genre objects
                listOfTopGenres = response.readEntity(new GenericType<List<Genre>>() {});
            } else {
                System.err.println("Failed to retrieve top genres. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
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
        String genresViewsUri = uri + "getGenreViewsByDate";

        // Build the query parameters
        UriBuilder uriBuilder = UriBuilder.fromUri(genresViewsUri)
                .queryParam("genreId", genreId)
                .queryParam("startDate", startDate)
                .queryParam("endDate", endDate);

        webTarget = client.target(uriBuilder);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public Integer getTotalViewsByWriterId(Integer writerId) {
        String totalViewsByWriterIdUri = uri + "getTotalViewsByWriterId";

        // Build the query parameters
        UriBuilder uriBuilder = UriBuilder.fromUri(totalViewsByWriterIdUri)
                .queryParam("writerId", writerId);

        webTarget = client.target(uriBuilder);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        return response.readEntity(Integer.class);
    }

    @Override
    public List<Editor> getTopEditors(Integer numberOfEntries) {
        List<Editor> topEditors = null;
        try {
            String topEditorsUri = uri + "getTopEditors";

            // Build the query parameters
            UriBuilder uriBuilder = UriBuilder.fromUri(topEditorsUri)
                    .queryParam("numberOfEntries", numberOfEntries);

            webTarget = client.target(uriBuilder);

            // Perform the HTTP GET request
            response = webTarget.request().get();

            // Check if the response is successful
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                topEditors = response.readEntity(new GenericType<List<Editor>>() {});
            } else {
                System.err.println("Failed to retrieve top editors. Response status: " + response.getStatus());
            }
        } catch (ProcessingException | IllegalStateException ex) {
            // Handle exceptions related to the HTTP request or response processing
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, "Error processing the request", ex);
        } finally {
            // Close the response to release resources
            if (response != null) {
                response.close();
            }
        }
        return topEditors;
    }
}
