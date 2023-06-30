/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Writer;
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
 * @author Jarrod
 */
public class WriterService_Impl implements WriterService_Interface{
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;

    public WriterService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/writer/";
    }
    
    @Override
    public String addWriter(Integer readerId) {
        String addWriterUri = uri + "addWriter/{readerId}";
        webTarget = client.target(addWriterUri).resolveTemplate("readerId", readerId);
        response = webTarget.request().get();
        return response.readEntity(String.class);
    }

    @Override
    public List<Writer> getAllWriters() {
        List<Writer> writers = null;
        String getAllWritersUri = uri + "getAllWriters";
        try {
            webTarget = client.target(getAllWritersUri);
            writers = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Writer>>(){});
        } catch (IOException ex) {
            Logger.getLogger(WriterService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        return writers;
    }

    @Override
    public Writer getWriter(Integer writerId) {
        String getWriterByIdUri = uri + "getWriterById/{writerId}";
        webTarget = client.target(getWriterByIdUri).resolveTemplate("writerId", writerId);
        response = webTarget.request().get();
        return response.readEntity(Writer.class);
    }

    @Override
    public Writer getWriter(String email) {
        String getWriterByEmailUri = uri + "getWriterByEmail/{email}";
        webTarget = client.target(getWriterByEmailUri).resolveTemplate("email", email);
        response = webTarget.request().get();
        return response.readEntity(Writer.class);
    }

    @Override
    public String updateWriter(Writer writer) {
        try {
            String updateWriterUri = uri + "updateWriter";
            webTarget = client.target(updateWriterUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(writer)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(WriterService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong connecting to server.";
        }
        return response.readEntity(String.class);
    }

    @Override
    public String blockWriters(List<Integer> writerIds) {
        try {
            String blockWritersUri = uri + "blockWriters";
            webTarget = client.target(blockWritersUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(writerIds)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(WriterService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong connecting to server.";
        }
        return response.readEntity(String.class);
    }
    
    @Override
    public String addWriters(List<Integer> writerIds) {
        try {
            String addWritersUri = uri + "addWriters";
            webTarget = client.target(addWritersUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(writerIds)));
        } catch (JsonProcessingException ex) {
            Logger.getLogger(WriterService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong connecting to server.";
        }
        return response.readEntity(String.class);
    }
    
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }
}
