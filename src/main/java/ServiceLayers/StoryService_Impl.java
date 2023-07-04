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
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.Response.StatusType;
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

        try {
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(Story.class);
            } else {
                // Handle error response
                System.err.println("Failed to get story. Response status: " + response.getStatus());
            }
        } finally {
            if (response != null) {
                response.close();
            }
        }

        return null;
    }


    @Override
    public List<Story> getAllStories() {
        List<Story> stories = null;
        try {
            String getAllStoriesUri = uri + "getAllStories";
            webTarget = client.target(getAllStoriesUri);
            response = webTarget.request().get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                String responseString = response.readEntity(String.class);
                stories = mapper.readValue(responseString, new TypeReference<List<Story>>() {});
            } else {
                // Handle error response
                System.err.println("Failed to get all stories. Response status: " + response.getStatus());
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (response != null) {
                response.close();
            }
        }

        return stories;
    }

    @Override
    public List<Story> getStoriesInGenre(Integer genreId, Integer numberOfStories, Integer currentId, Boolean next) {
        List<Story> stories = null;
        try {
            String getStoriesInGenrePath = uri + "getStoriesInGenre";
            // Build the query parameters
            URI getStoriesInGenreUri = UriBuilder.fromPath(getStoriesInGenrePath)
                .queryParam("genreId", genreId)
                .queryParam("numberOfStories", numberOfStories)
                .queryParam("currentId", currentId)
                .queryParam("next", String.valueOf(next))
                .build();
            webTarget = client.target(getStoriesInGenreUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                String responseString = response.readEntity(String.class);
                stories = mapper.readValue(responseString, new TypeReference<List<Story>>() {});
            } else {
                // Handle error response
                System.err.println("Failed to get stories in genre. Response status: " + response.getStatus());
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
        }

        return stories;
    }


    @Override
    public String updateStory(Story story) {
        try {
            String updateStoryUri = uri + "updateStory";
            webTarget = client.target(updateStoryUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(story)));

            if (response.getStatus() != Response.Status.OK.getStatusCode()) {
                // Handle error response
                System.err.println("Failed to update story. Response status: " + response.getStatus());
                return "Something went wrong updating the story on the system.";
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong updating the story on the system.";
        } finally {
            if (response != null) {
                response.close();
            }
        }

        return response.readEntity(String.class);
    }

    @Override
    public String deleteStory(Integer storyId) {       
        try{
        String deleteStoryUri = uri + "deleteStory/{storyId}";
        webTarget = client.target(deleteStoryUri).resolveTemplate("storyId", storyId);
        response = webTarget.request().get();
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(String.class);
            }else {
                System.err.println("Failed to delete story. Response status: " + response.getStatus());
            }
        }finally{
           response.close();

        }
        return "System failed to delete story";
    }
    
    @Override
    public String addStory(Story story) {
        try {
            String addStoryUri = uri + "addStory";
            webTarget = client.target(addStoryUri);
            String storyJson = toJsonString(story);
            response = webTarget.request(MediaType.APPLICATION_JSON)
                                .post(Entity.json(storyJson));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(String.class);
            } else {
                return "Something went wrong adding a story to the system.";
            }
        } catch (Exception ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong adding a story to the system.";
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }

    @Override
    public List<Story> getTopPicks() {
        List<Story> stories = null;
        try {
            String getTopPicksUri = uri + "getTopPicks";
            webTarget = client.target(getTopPicksUri);
            response = webTarget.request().get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                stories = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Story>>() {});
            } else {
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
        }

        return stories;
    }
    
    @Override
    public List<Story> getSubmittedStories(Integer numberOfStories, Integer offset) {
        List<Story> submittedStories = null;
        try {
            String getSubmittedStoriesUri = uri + "getSubmittedStories/{numberOfStories}/{offset}";
            webTarget = client.target(getSubmittedStoriesUri)
                    .resolveTemplate("numberOfStories", numberOfStories)
                    .resolveTemplate("offset", offset);
            response = webTarget.request().get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                submittedStories = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Story>>() {
                });
            } else {
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.ALL, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
        }
        return submittedStories;
    }

    
    @Override
    public List<Story> searchForStories(String searchValue, Integer numberOfStories, Integer currentId, Boolean next) {
        List<Story> stories = null;
        try {
            String searchForStoriesPath = uri + "searchForStories";
            UriBuilder uriBuilder = UriBuilder.fromPath(searchForStoriesPath)
                    .queryParam("searchValue", searchValue)
                    .queryParam("numberOfStories", numberOfStories)
                    .queryParam("currentId", currentId)
                    .queryParam("next", next);
            URI searchForStoriesUri = uriBuilder.build();

            webTarget = client.target(searchForStoriesUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                stories = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Story>>() {});
            } else {
                Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, "Failed to retrieve stories from search. Response status: {0}", response.getStatus());
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
        }

        return stories;
}

    
    @Override
    public List<Story> getRecommendations(List<Integer> genreIds) {
        List<Story> recommendedStories = null;
        try {
            String getRecommendationsUri = uri + "getRecommendations";
            webTarget = client.target(getRecommendationsUri);

            response = webTarget.request(MediaType.APPLICATION_JSON)
                    .post(Entity.json(toJsonString(genreIds)));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                recommendedStories = response.readEntity(new GenericType<List<Story>>() {});
            } else {
                Logger.getLogger(StoryService_Impl.class.getName())
                        .log(Level.SEVERE, "Failed to retrieve recommended stories.", response.getStatus());
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
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

            String getWritersSubmittedStoriesUri = uri + "getWritersSubmittedStories";
            webTarget = client.target(getWritersSubmittedStoriesUri);

            response = webTarget.request(MediaType.APPLICATION_JSON)
                    .post(Entity.json(toJsonString(storiesHolder)));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                submittedStories = response.readEntity(new GenericType<List<Story>>() {});
            } else {
                Logger.getLogger(StoryService_Impl.class.getName())
                        .log(Level.SEVERE, "Failed to retrieve submitted stories.", response.getStatus());
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
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

            String getWritersDraftedStoriesUri = uri + "getWritersDraftedStories";
            webTarget = client.target(getWritersDraftedStoriesUri);

            response = webTarget.request(MediaType.APPLICATION_JSON)
                    .post(Entity.json(toJsonString(storiesHolder)));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                draftedStories = response.readEntity(new GenericType<List<Story>>() {
                });
            } else {
                Logger.getLogger(StoryService_Impl.class.getName())
                        .log(Level.SEVERE, "Failed to retrieve drafted stories.", response.getStatus());
                return null;
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
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

            response = webTarget.request(MediaType.APPLICATION_JSON)
                    .post(Entity.json(toJsonString(stories)));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(String.class);
            } else {
                Logger.getLogger(StoryService_Impl.class.getName())
                        .log(Level.SEVERE, "Failed to update the selected stories.", response.getStatus());
                return "Something went wrong updating the selected stories.";
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong updating the selected stories.";
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }

}
