/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Reader;
import Utils.GetProperties;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jarro
 */
public class ReaderService_Impl implements ReaderService_Interface{
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private final String uri;

    public ReaderService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("C:\\Users\\jarro\\OneDrive\\Documents\\NetBeansProjects\\RIPClient\\src\\java\\Properties\\config.properties");
        uri = properties.get("uri") + "readers/";
    }
    
    @Override
    public Boolean userExists(String email) {
        String getUserSaltUri = uri + "userExists/{email}";
        webTarget = client.target(getUserSaltUri).resolveTemplate("email", email);
        response = webTarget.request(MediaType.APPLICATION_JSON).get();
        return response.readEntity(Boolean.class);
    }
    
}
