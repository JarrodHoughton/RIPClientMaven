/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Utils.GetProperties;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

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
//        properties = new GetProperties("C:\\Users\\jarro\\OneDrive\\Documents\\NetBeansProjects\\RIPClient\\src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/readers/";
    }
    
    @Override
    public Boolean userExists(String email) {
        String getUserSaltUri = uri + "userExists/{email}";
        webTarget = client.target(getUserSaltUri).resolveTemplate("email", email);
        response = webTarget.request(MediaType.APPLICATION_JSON).get();
        return response.readEntity(Boolean.class);
    }

    @Override
    public String setVerified(Integer readerId) {
        String setVerifiedUri = uri + "setVerified/{readerId}";
        webTarget = client.target(setVerifiedUri).resolveTemplate("readerId", readerId);
        response = webTarget.request(MediaType.APPLICATION_JSON).get();
        return response.readEntity(String.class);
    }

    @Override
    public Boolean isVerified(Integer readerId) {
        String isVerifiedUri = uri + "isVerified/{readerId}";
        webTarget = client.target(isVerifiedUri).resolveTemplate("readerId", readerId);
        response = webTarget.request(MediaType.APPLICATION_JSON).get();
        return response.readEntity(Boolean.class);
    }
    
    @Override
    public String getVerifyToken(Integer readerId) {
        String getVerifyTokenUri = uri + "getVerifyToken/{readerId}";
        webTarget = client.target(getVerifyTokenUri).resolveTemplate("readerId", readerId);
        response = webTarget.request(MediaType.APPLICATION_JSON).get();
        return response.readEntity(String.class);
    }   
}
