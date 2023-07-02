/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Genre;
import Models.StoriesHolder;
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
import jakarta.ws.rs.core.UriBuilder;
import java.io.IOException;
import java.net.URI;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Jarrod
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
            return null;
        }
        return stories;
    }

    @Override
    public List<Story> getStoriesInGenre(Integer genreId, Integer numberOfStories, Integer offset) {
        List<Story> stories = null;
        try {
            String getStoriesInGenrePath = uri + "getStoriesInGenre";
            // Build the query parameters
            URI getStoriesInGenreUri = UriBuilder.fromPath(getStoriesInGenrePath)
                .queryParam("genreId", genreId)
                .queryParam("numberOfStories", numberOfStories)
                .queryParam("offset", offset)
                .build();
            webTarget = client.target(getStoriesInGenreUri);
            stories = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return stories;
    }

    @Override
    public String updateStory(Story story) {
        try {
            String loginReaderUri = uri + "updateStory";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(story)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong updating a story on the system.";
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
            String addStoryUri = uri + "addStory";
            webTarget = client.target(addStoryUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(story)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong adding a story to the system.";
        }
        return response.readEntity(String.class);
    }

    @Override
    public List<Story> getTopPicks() {
        List<Story> stories = null;
        try {
            String getTopPicksUri = uri + "getTopPicks";
            webTarget = client.target(getTopPicksUri);
            Logger.getLogger("CALLING GET TOP PICKS");
            stories = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return stories;
    }
    
    @Override
    public List<Story> getSubmittedStories(Integer numberOfStories, Integer offset) {
        List<Story> submittedStories = null;
        try {
            String getSubmittedStoriesUri = uri + "getSubmittedStories/{numberOfStories}/{offset}";
            HashMap<String, Object> params = new HashMap<>();
            params.put("numberOfStories", numberOfStories);
            params.put("offset", offset);
            webTarget = client.target(getSubmittedStoriesUri).resolveTemplates(params);
            submittedStories = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.ALL, null, ex);
            return null;
        }
        return submittedStories;
    }
    
    @Override
    public List<Story> searchForStories(String searchValue) {
        List<Story> stories = null;
        try {
            String searchForStoriesUri = uri + "searchForStories/{searchValue}";
            webTarget = client.target(searchForStoriesUri).resolveTemplate("searchValue", searchValue);
            stories = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Story>>() {});
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return stories;
    }
    
    @Override
    public List<Story> getRecommendations(List<Integer> genreIds) {
        List<Story> recommendedStories = null;
        try {
            String loginReaderUri = uri + "getRecommendations";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(genreIds)));
            recommendedStories = response.readEntity(StoriesHolder.class).getStories();
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return recommendedStories;
    }

    @Override
    public List<Story> getWritersSubmittedStories(List<Integer> storyIds, Integer writerId) {
        List<Story> submittedStories = null;
        try {
            StoriesHolder storiesHolder = new StoriesHolder();
            storiesHolder.setId(writerId);
            storiesHolder.setStoryIds(storyIds);
            String loginReaderUri = uri + "getWritersSubmittedStories";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(storiesHolder)));
            submittedStories = response.readEntity(StoriesHolder.class).getStories();
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return submittedStories;
    }

    @Override
    public List<Story> getWritersDraftedStories(List<Integer> storyIds, Integer writerId) {
        List<Story> draftedStories = null;
        try {
            StoriesHolder storiesHolder = new StoriesHolder();
            storiesHolder.setId(writerId);
            storiesHolder.setStoryIds(storyIds);
            String loginReaderUri = uri + "getWritersDraftedStories";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(storiesHolder)));
            draftedStories = response.readEntity(StoriesHolder.class).getStories();
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return draftedStories;
    }
    
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }

    @Override
    public String updateStories(List<Story> stories) {
        try {
            String updateStoriesUri = uri + "updateStories";
            webTarget = client.target(updateStoriesUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(stories)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong updating the selected stories.";
        }
        return response.readEntity(String.class);
    }
}
