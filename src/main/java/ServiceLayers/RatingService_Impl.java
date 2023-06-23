/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Rating;
import Models.Reader;
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
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 27713
 */
public class RatingService_Impl implements RatingService_Interface {

    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;

    public RatingService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/rating/";
    }

    @Override
    public String addRating(Rating rating) {
        String addRatingUri = uri + "addRating";
        webTarget = client.target(addRatingUri);
        try {
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(rating)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public Boolean checkRatingExists(Rating rating) {
        String checkRatingExistsUri = uri + "checkRatingExists";
        webTarget = client.target(checkRatingExistsUri);
        try {
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(rating)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(Boolean.class);
    }

    @Override
    public String updateRatingValue(Rating rating) {
        String updateRatingValueUri = uri + "updateRatingValue";
        webTarget = client.target(updateRatingValueUri);
        try {
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(rating)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public List<Integer> getTopHighestRatedStoriesInTimePeriod(Timestamp startDate, Timestamp endDate, Integer numberOfEntries) {
        List<Integer> bookIds = null;
        try {
            String mostLikedBooksUri = uri + "getTopHighestRatedStories/{startDate}/{endDate}/{numberOfEntries}";
            webTarget = client.target(mostLikedBooksUri);
            webTarget.resolveTemplate("startDate", startDate);
            webTarget.resolveTemplate("endDate", endDate);
            webTarget.resolveTemplate("numberOfEntries", numberOfEntries);
            bookIds = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Integer>>() {
            });
        } catch (IOException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bookIds;
    }

    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }

    @Override
    public Rating getRating(Integer accountId, Integer storyId) {
        HashMap<String, Object> ratingValues = new HashMap<>();
        ratingValues.put("accountId", accountId);
        ratingValues.put("storyId", storyId);
        String mostLikedBooksUri = uri + "getRating/{accountId}/{storyId}";
        webTarget = client.target(mostLikedBooksUri).resolveTemplates(ratingValues);
        response = webTarget.request().get();
        return response.readEntity(Rating.class);
    }
}
