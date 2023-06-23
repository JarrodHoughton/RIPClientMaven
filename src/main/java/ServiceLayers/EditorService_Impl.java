/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Editor;
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
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jarro
 */
public class EditorService_Impl implements EditorService_Interface{
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;

    public EditorService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/editor/";
    }
    
    @Override
    public List<Editor> getAllEditors() {
        List<Editor> editors = null;
        try {
            String ggetAllEditorsUri = uri + "getAllEditors";
            webTarget = client.target(ggetAllEditorsUri);
            editors = mapper.readValue(webTarget.request().get(String.class), new TypeReference<List<Editor>>() {});
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return editors;
    }

    @Override
    public String addEditor(Editor editor) {
        try {
            String addEditorUri = uri + "registerEditor";
            webTarget = client.target(addEditorUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(editor)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }

    @Override
    public String deleteEditor(Integer editorId) {
        String deleteEditorUri = uri + "deleteEditor/{editorId}";
        webTarget = client.target(deleteEditorUri).resolveTemplate("editorId", editorId);
        response = webTarget.request().get();
        return response.readEntity(String.class);
    }

    @Override
    public String updateEditor(Editor editor) {
        try {
            String updateEditorUri = uri + "updateEditor";
            webTarget = client.target(updateEditorUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(editor)));
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }
    
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }
}
