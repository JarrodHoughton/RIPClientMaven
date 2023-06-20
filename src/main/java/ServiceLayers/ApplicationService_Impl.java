/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Application;
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
public class ApplicationService_Impl implements ApplicationService_Interface{
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;

    public ApplicationService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/applications/";
    }
    
    
    @Override
    public List<Application> getApplications() {
        List<Application> applications;
        try {
            String getgetApplicationsUri = uri + "getApplications";
            webTarget = client.target(getgetApplicationsUri);
            applications = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Application>>(){});
        } catch (IOException ex) {
            Logger.getLogger(GenreService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return applications;
    }

    @Override
    public String addApplication(Application application) {
        try {
            String addApplicationUri = uri + "addApplication";
            webTarget = client.target(addApplicationUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(application)));
        } catch (IOException ex) {
            Logger.getLogger(GenreService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public String deleteApplication(Integer accountId) {
        String deleteApplicationUri = uri + "deleteApplication/{readerId}";
        webTarget = client.target(deleteApplicationUri).resolveTemplate("readerId", accountId);
        response = webTarget.request().get();
        return response.readEntity(String.class);
    }
 
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }
}
