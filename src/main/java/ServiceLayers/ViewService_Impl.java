/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.View;
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
public class ViewService_Impl implements ViewService_Interface {
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;
    
    public ViewService_Impl(){
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/view/";
    }
    
    @Override
    public String addView(View view) {
        String addViewUri = uri + "addView";
        try {            
            webTarget = client.target(addViewUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(view)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public List<Integer> getMostViewedStoriesInATimePeriod(Integer numberOfEntries, Timestamp startDate, Timestamp endDate) {
        List<Integer> bookIds = new ArrayList<>();
        HashMap<String, Object> details = new HashMap<>();
        try {            
            String mostViewedBooksUri = uri + "getMostViewedStories/{numberOfEntries}/{startDate}/{endDate}";
            details.put("numberOfEntries", numberOfEntries);
            details.put("startDate", startDate);
            details.put("endDate", endDate);
            webTarget = client.target(mostViewedBooksUri).resolveTemplates(details);
            bookIds = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Integer>>(){});
        } catch (IOException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);            
        }
        return bookIds;
    }

    @Override
    public Integer getTheViewsOnAStoryInATimePeriod(Integer storyId, Timestamp startDate, Timestamp endDate) {
        String getViewsOnStoryUri = uri + "getTheViewOnAStory/{storyId}/{startDate}/{endDate}";
        HashMap<String, Object> details = new HashMap<>();
        details.put("storyId", storyId);
        details.put("startDate", startDate);
        details.put("endDate", endDate);
        webTarget = client.target(getViewsOnStoryUri).resolveTemplates(details);
        response = webTarget.request().get();
        return response.readEntity(Integer.class);
    }

    @Override
    public Boolean isViewAlreadyAdded(View view) {
        try {
            String isViewAddedUri = uri + "isViewAlreadyAdded";
            webTarget = client.target(isViewAddedUri);
            response= webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(view)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(LikeService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(Boolean.class);
    }
    
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }
    
}
