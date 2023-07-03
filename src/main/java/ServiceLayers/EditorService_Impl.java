/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Editor;
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
    private final Client client;
    private WebTarget webTarget;
    private final ObjectMapper mapper;
    private Response response;
    private final GetProperties properties;
    private final String uri;

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
            String getAllEditorsUri = uri + "getAllEditors";
            webTarget = client.target(getAllEditorsUri);
            response = webTarget.request().get();
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()) {
                editors = mapper.readValue(response.readEntity(String.class), new TypeReference<List<Editor>>() {});
            }else {
                System.err.println("Failed to retrieve all editors. Response status: " + response.getStatus());
            }                  
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }finally{
            closeResponse();
        }
        return editors;
    }

    @Override
    public String addEditor(Editor editor) {
        try {
            String addEditorUri = uri + "registerEditor";
            webTarget = client.target(addEditorUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(editor)));
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(String.class);
            }else {
                System.err.println("Failed to add editor. Response status: " + response.getStatus());
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "An erro occured while adding an editor. IOException was thrown";
        }finally{
            closeResponse();
        }
        return "System failed to add editor";
    }

    @Override
    public String deleteEditor(Integer editorId) {       
        try{
            String deleteEditorUri = uri + "deleteEditor/{editorId}";
            webTarget = client.target(deleteEditorUri).resolveTemplate("editorId", editorId);
            response = webTarget.request().get();
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(String.class);
            }else {
                System.err.println("Failed to add editor. Response status: " + response.getStatus());
            }
        }finally{
            closeResponse();
        }
        return "System failed to delete editor";
    }

    @Override
    public String updateEditor(Editor editor) {
        try {
            String updateEditorUri = uri + "updateEditor";
            webTarget = client.target(updateEditorUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(editor)));
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(String.class);
            }else {
                System.err.println("Failed to add editor. Response status: " + response.getStatus());
            }
        } catch (IOException ex) {
            Logger.getLogger(StoryService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            closeResponse();
        }
        return "System failed to update editor";
    }
    
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }

    @Override
    public Boolean searchForEditor(String accountEmail) {
        try{
            String searchForEditorUri = uri + "searchForEditor/{accountEmail}";
            webTarget = client.target(searchForEditorUri).resolveTemplate("accountEmail", accountEmail);
            response = webTarget.request().get();
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(Boolean.class);
            }else {
                    System.err.println("Failed to search for editor. Response status: " + response.getStatus());
            }
        }finally{
            closeResponse();
        }
        return false;
    }

    @Override
    public Editor getEditor(String accountEmail) {
        try{
            String getEditorUri = uri + "getEditorByEmail/{accountEmail}";
            webTarget = client.target(getEditorUri).resolveTemplate("accountEmail", accountEmail);
            response = webTarget.request().get();
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(Editor.class);
            }else {
                    System.err.println("Failed to search for editor. Response status: " + response.getStatus());
            }            
        }finally{
            closeResponse();
        }
        return null;
    }

    @Override
    public Editor getEditor(Integer editorId) {
        try{
            String getEditorUri = uri + "getEditorById/{editorId}";
            webTarget = client.target(getEditorUri).resolveTemplate("editorId", editorId);
            response = webTarget.request().get();
            
            if (response.getStatus() == Response.Status.OK.getStatusCode()){
                return response.readEntity(Editor.class);
            }else {
                    System.err.println("Failed to get for editor. Response status: " + response.getStatus());
            }            
        }finally{
            closeResponse();
        }
        return null;
    }
    
    private void closeResponse(){
        if (response != null) {
            response.close();
        }
    }
}
