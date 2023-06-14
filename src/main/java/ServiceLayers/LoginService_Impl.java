/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Editor;
import Models.Reader;
import Models.Writer;
import Utils.GetProperties;
import Utils.PasswordEncryptor;
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
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jarro
 */
public class LoginService_Impl implements LoginService_Interface{
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private final String uri;

    public LoginService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("C:\\Users\\jarro\\OneDrive\\Documents\\NetBeansProjects\\RIPClient\\src\\java\\Properties\\config.properties");
        uri = properties.get("uri") + "login/";
    }
    
    @Override
    public HashMap getUserSalt(String email) {
        HashMap<String, String> details = null;
        try {
            String getUserSaltUri = uri + "getUserSalt/{email}";
            webTarget = client.target(getUserSaltUri).resolveTemplate("email", email);
            details = mapper.readValue(webTarget.request(MediaType.APPLICATION_JSON).get(String.class), new TypeReference<HashMap<String, String>>(){});
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return details;
    }

    @Override
    public Reader loginReader(Reader reader) {
        try {
            reader.setPasswordHash(PasswordEncryptor.hashPassword(reader.getPasswordHash(), reader.getSalt()));
            String loginReaderUri = uri + "getUser";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(reader)));
            reader = response.readEntity(Reader.class);
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reader;
    }

    @Override
    public Writer loginWriter(Writer writer) {
        try {
            writer.setPasswordHash(PasswordEncryptor.hashPassword(writer.getPasswordHash(), writer.getSalt()));
            String loginReaderUri = uri + "getUser";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(writer)));
            writer = response.readEntity(Writer.class);
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return writer;
    }

    @Override
    public Editor loginEditor(Editor editor) {
        try {
            editor.setPasswordHash(PasswordEncryptor.hashPassword(editor.getPasswordHash(), editor.getSalt()));
            String loginReaderUri = uri + "getUser";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(editor)));
            editor = response.readEntity(Editor.class);
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return editor;
    }

    @Override
    public String register(Reader reader) {
        try {
            String loginReaderUri = uri + "register";
            webTarget = client.target(loginReaderUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(reader)));
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }
    
    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }
}
