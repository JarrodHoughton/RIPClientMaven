package ServiceLayers;

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
import jakarta.ws.rs.core.Response;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.HashMap;
import java.util.Map;

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
        String storyLikes = uri + "getStoryLikesByDate/{storyId}/{startDate}/{endDate}";
        String storyIdNum = storyId.toString();
        Map<String, Object> details = new HashMap<>();
        details.put("storyId", storyIdNum);
        details.put("startDate",startDate);
        details.put("endDate", endDate);
        webTarget = client.target(storyLikes).resolveTemplates(details);
        response = webTarget.request().get();
        return response.readEntity(Integer.class);
    }
@Override
public List<Story> getMostLikedStories(Integer numberOfStories, String startDate, String endDate) {
    List<Story> listOfStories = null;
    try {
        String mostLikedStoriesUri = uri + "getMostLikedStories/{numberOfStories}/{startDate}/{endDate}";
        String storyNum = numberOfStories.toString();
        Map<String, Object> details = new HashMap<>(); 
        details.put("numberOfStories", storyNum);
        details.put("startDate",startDate);
        details.put("endDate", endDate);
        webTarget = client.target(mostLikedStoriesUri).resolveTemplates(details);

        // Perform the HTTP GET request
        response = webTarget.request().get();

        // Check if the response is successful
        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
            // Read the response entity as a list of Story objects
            listOfStories = response.readEntity(new GenericType<List<Story>>() {});
        } else {
            // Handle the case when the response is not successful
            // You can choose to log an error, throw an exception, or return a default value
            System.err.println("Failed to retrieve most liked stories. Response status: " + response.getStatus());
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
    public List<Story> getMostViewedStoriesInATimePeriod(Integer numberOfEntries, String startDate, String endDate) {
        List<Story> listOfStories = null;
        try {
            String mostViewedStoriesUri = uri + "getmostviewedstories/{numberOfStories}/{startDate}/{endDate}";
            webTarget = client.target(mostViewedStoriesUri);
            webTarget = webTarget.resolveTemplate("numberOfStories", numberOfEntries);
            webTarget = webTarget.resolveTemplate("startDate", startDate);
            webTarget = webTarget.resolveTemplate("endDate", endDate);
            String responseString = webTarget.request().get(String.class);
            listOfStories = mapper.readValue(responseString, new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listOfStories;
    }

    @Override
    public Integer getTheViewsOnAStoryInATimePeriod(Integer storyId, String startDate, String endDate) {
        String storyViewsUri = uri + "getstoryviewsbydate/{storyId}/{startDate}/{endDate}";
        webTarget = client.target(storyViewsUri);
        webTarget = webTarget.resolveTemplate("storyId", storyId);
        webTarget = webTarget.resolveTemplate("startDate", startDate);
        webTarget = webTarget.resolveTemplate("endDate", endDate);
        response = webTarget.request().get();
        return response.readEntity(Integer.class);
    }

    @Override
    public List<Story> getTopHighestRatedStoriesInTimePeriod(String startDate, String endDate, Integer numberOfEntries) {
        List<Story> listOfStories = null;
        try {
            String topRatedStoriesUri = uri + "getTopHighestRatedStories/{startDate}/{endDate}/{numberOfEntries}";
            webTarget = client.target(topRatedStoriesUri);
            webTarget = webTarget.resolveTemplate("startDate", startDate);
            webTarget = webTarget.resolveTemplate("endDate", endDate);
            webTarget = webTarget.resolveTemplate("numberOfEntries", numberOfEntries);
            String responseString = webTarget.request().get(String.class);
            listOfStories = mapper.readValue(responseString, new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listOfStories;
    }

    @Override
    public List<Writer> getTopWriters(Integer numberOfWriters) {
        List<Writer> topWriters = null;
        try {
            String topWritersUri = uri + "getTopWriters/{numberOfEntries}";
            webTarget = client.target(topWritersUri);
            webTarget = webTarget.resolveTemplate("numberOfEntries", numberOfWriters);
            String responseString = webTarget.request().get(String.class);
            topWriters = mapper.readValue(responseString, new TypeReference<List<Writer>>() {});
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topWriters;
    }

    @Override
    public List<Writer> getTopWritersByDate(Integer numberOfWriters, String startDate, String endDate) {
        List<Writer> topWriters = null;
        try {
            String topWritersByDateUri = uri + "getTopWritersByDate/{startDate}/{endDate}/{numberOfEntries}";
            webTarget = client.target(topWritersByDateUri);
            webTarget = webTarget.resolveTemplate("startDate", startDate);
            webTarget = webTarget.resolveTemplate("endDate", endDate);
            webTarget = webTarget.resolveTemplate("numberOfEntries", numberOfWriters);
            String responseString = webTarget.request().get(String.class);
            topWriters = mapper.readValue(responseString, new TypeReference<List<Writer>>() {});
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topWriters;
    }

    @Override
    public List<Integer> getTopEditors(Integer numberOfEditors) {
        List<Integer> topEditors = null;
        try {
            String topEditorsUri = uri + "getTopEditors/{numberOfEntries}";
            webTarget = client.target(topEditorsUri);
            webTarget = webTarget.resolveTemplate("numberOfEntries", numberOfEditors);
            String responseString = webTarget.request().get(String.class);
            topEditors = mapper.readValue(responseString, new TypeReference<List<Integer>>() {});
        } catch (IOException ex) {
            Logger.getLogger(DataReportService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topEditors;
    }
}
