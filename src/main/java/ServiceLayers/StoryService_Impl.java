/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Genre;
import Models.Story;
import Utils.GetProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jarro
 */
public class StoryService_Impl implements StoryService_Interface {

    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;

    public StoryService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/stories/";
    }

    @Override
    public Story getStory(Integer storyId) {
        String getStoryUri = uri + "getStory/{storyId}";
        webTarget = client.target(getStoryUri).resolveTemplate("storyId", storyId);
        response = webTarget.request().get();
        return response.readEntity(Story.class);
    }

    @Override
    public List<Story> getAllStories() {
        List<Story> stories = null;
        try {
            String getAllStoriesUri = uri + "getAllStories";
            webTarget = client.target(getAllStoriesUri);
            stories = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return stories;
    }

    @Override
    public List<Story> getStoriesInGenre(Integer genreId) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public String updateStory(Story story) {
        try {
            String loginReaderUri = uri + "updateStory";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(story)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public String deleteStory(Integer storyId) {
        String deleteStoryUri = uri + "deleteStory/{storyId}";
        webTarget = client.target(deleteStoryUri).resolveTemplate("storyId", storyId);
        response = webTarget.request().get();
        return response.readEntity(String.class);
    }

    @Override
    public String addStory(Story story) {
        try {
            String loginReaderUri = uri + "addStory";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(story)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public List<Story> getTopPicks() {
        return getAllStories();
    }

    @Override
    public List<Story> getRecommendations() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }
}
