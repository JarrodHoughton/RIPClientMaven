/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Like;
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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 27713
 */
public class LikeService_Impl implements LikeService_Interface{
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;
    
    public LikeService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/like/";
    }
    
    @Override
    public String addLike(Like like) {
        String addLikeUri = uri + "addLike";
        try {            
            webTarget = client.target(addLikeUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(like)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Like not added";
        }
        if (response.getStatus() == Response.Status.OK.getStatusCode()) {
            return response.readEntity(String.class);
        } else {            
            return "Like not added";
        }
    }

    @Override
    public String deleteLike(Like like) {
        try {
            String deleteLikeUri = uri + "deleteLike";
            webTarget = client.target(deleteLikeUri);
            response= webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(like)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Like not deleted";
        }
        return response.readEntity(String.class);
    }

    @Override
    public List<Like> getLikesByReaderId(Integer accountId) {
        List<Like> likes = new ArrayList<>();
        try {            
            String likesByReaderUri = uri + "getLikesByReaderId/{accountId}";
            webTarget = client.target(likesByReaderUri).resolveTemplate("accountId",accountId);
            likes = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Like>>(){});
        } catch (IOException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);            
        }
        return likes;
    }

    @Override
    public List<Like> getLikesByStory(Integer storyId) {
        List<Like> likes = new ArrayList<>();
        try {            
            String likesByStoryUri = uri + "getLikesByStory/{storyId}";
            webTarget = client.target(likesByStoryUri).resolveTemplate("storyId",storyId);
            likes = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Like>>(){});
        } catch (IOException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return likes;
    }

    @Override
    public Integer getStoryLikesByDate(Integer storyId, Timestamp startDate, Timestamp endDate) {        
        String storyLikesUri = uri + "getStoryLikesByDate/{storyId}/{startDate}/{endDate}";
        HashMap<String, Object> details = new HashMap<>();
        details.put("storyId", storyId);
        details.put("startDate", startDate);
        details.put("endDate", endDate);
        webTarget = client.target(storyLikesUri).resolveTemplates(details);
        response = webTarget.request().get();
        return response.readEntity(Integer.class);
    }

    @Override
    public List<Integer> getMostLikedBooks(Integer numberOfBooks, Timestamp startDate, Timestamp endDate) {
        List<Integer> bookIds = new ArrayList<>();
        HashMap<String, Object> details = new HashMap<>();
        try {            
            String mostLikedBooksUri = uri + "getMostLikedBooks/{numberOfBooks}/{startDate}/{endDate}";
            details.put("numberOfBooks", numberOfBooks);
            details.put("startDate", startDate);
            details.put("endDate", endDate);
            webTarget = client.target(mostLikedBooksUri).resolveTemplates(details);
            bookIds = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Integer>>(){});
        } catch (IOException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bookIds;
    }
    
    @Override
    public Boolean checkIfLikeExists(Like like) {
        try {
            String checkLikeExistsUri = uri + "checkIfLikeExists";
            webTarget = client.target(checkLikeExistsUri);
            response= webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(like)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(Boolean.class);
    }

    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }

    
    
}
