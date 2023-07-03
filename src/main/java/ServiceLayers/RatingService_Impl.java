/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Rating;
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

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(String.class);
            } else {
                System.err.println("Failed to add the rating. Response status: " + response.getStatus());
                return "Rating not added";
            }
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Rating not added";
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }


    @Override
    public Boolean checkRatingExists(Rating rating) {
        String checkRatingExistsUri = uri + "checkRatingExists";
        webTarget = client.target(checkRatingExistsUri);
        try {
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(rating)));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(Boolean.class);
            } else {
                System.err.println("Failed to check if rating exists. Response status: " + response.getStatus());
                return null;
            }
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }


    @Override
    public String updateRatingValue(Rating rating) {
        String updateRatingValueUri = uri + "updateRatingValue";
        webTarget = client.target(updateRatingValueUri);
        try {
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(rating)));

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(String.class);
            } else {
                System.err.println("Failed to update rating value. Response status: " + response.getStatus());
                return "Rating value not updated";
            }
        } catch (JsonProcessingException ex) {
            Logger.getLogger(RatingService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Rating value not updated";
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }

    @Override
    public List<Integer> getTopHighestRatedStoriesInTimePeriod(Timestamp startDate, Timestamp endDate, Integer numberOfEntries) {
        List<Integer> bookIds = null;
        String mostLikedBooksUri = uri + "getTopHighestRatedStories/{startDate}/{endDate}/{numberOfEntries}";

        try {
            webTarget = client.target(mostLikedBooksUri)
                    .resolveTemplate("startDate", startDate)
                    .resolveTemplate("endDate", endDate)
                    .resolveTemplate("numberOfEntries", numberOfEntries);

            response = webTarget.request().get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                bookIds = response.readEntity(new GenericType<List<Integer>>() {
                });
            } else {
                // Handle error response
                System.err.println("Failed to get top highest rated stories. Response status: " + response.getStatus());
            }
        } finally {
            if (response != null) {
                response.close();
            }

        }

        return bookIds;
    }
    
    @Override
    public Rating getRating(Integer accountId, Integer storyId) {
        HashMap<String, Object> ratingValues = new HashMap<>();
        ratingValues.put("accountId", accountId);
        ratingValues.put("storyId", storyId);
        String getRatingUri = uri + "getRating/{accountId}/{storyId}";

        try {
            webTarget = client.target(getRatingUri).resolveTemplates(ratingValues);
            response = webTarget.request().get();

            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                return response.readEntity(Rating.class);
            } else {
                // Handle error response
                System.err.println("Failed to get rating. Response status: " + response.getStatus());
                return null; // Or throw an exception, depending on your requirement
            }
        } finally {
            if (response != null) {
                response.close();
            }
        }
    }

    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }


}
