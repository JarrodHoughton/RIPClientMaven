package ServiceLayers;

import Models.Reader;
import Utils.GetProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import jakarta.ws.rs.client.Entity;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.io.IOException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MailService_Impl implements MailService_Interface {
    private Client client;
    private WebTarget webTarget;
    private ObjectMapper mapper;
    private Response response;
    private GetProperties properties;
    private String uri;

    public MailService_Impl() {
        client = ClientBuilder.newClient();
        mapper = new ObjectMapper();
        properties = new GetProperties("src\\java\\Properties\\config.properties");
        uri = "http://localhost:8080/RIPServerMaven/RIP/mail/";
    }
    
    @Override
    public String sendMail(String recipientEmail, String emailContent, String subject) {
        try {
            HashMap<String, String> emailDetails = new HashMap<>();
            emailDetails.put("recipient", recipientEmail);
            emailDetails.put("content", emailContent);
            emailDetails.put("subject", subject);
            String sendMailUri = uri + "sendMail";
            webTarget = client.target(sendMailUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(emailDetails)));
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return response.readEntity(String.class);
    }
    
    @Override
    public String sendVerficationEmail(Reader reader) {
        try {
            String sendVerficationEmailUri = uri + "sendVerificationEmail";
            webTarget = client.target(sendVerficationEmailUri);
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
