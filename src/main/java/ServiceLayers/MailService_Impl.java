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
import java.util.List;
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
            return "Something went wrong connecting to the server.";
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
            return "Something went wrong connecting to the server.";
        }
        return response.readEntity(String.class);
    }

    private String toJsonString(Object obj) throws JsonProcessingException {
        return mapper.writeValueAsString(obj);
    }

    @Override
    public String sendReferralEmail(String recipientEmail, String recipientName) {
        String sendReferralEmailUri = uri + "sendReferralEmail/{recipientEmail}/{recipientName}";
        HashMap<String, Object> referralDetails = new HashMap<>();
        referralDetails.put("recipientEmail", recipientEmail);
        referralDetails.put("recipientName", recipientName);
        webTarget = client.target(sendReferralEmailUri).resolveTemplates(referralDetails);
        response = webTarget.request().get();
        return response.readEntity(String.class);
    }

    @Override
    public String notifyApprovedWriters(List<Integer> accountIds, Boolean approved) {
        try {
            String sendVerficationEmailUri = uri;
            if (approved) {
                sendVerficationEmailUri += "notifyApprovedWriters";
            } else {
                sendVerficationEmailUri += "notifyRejectedWriters";
            }
            webTarget = client.target(sendVerficationEmailUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(accountIds)));
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong connecting to the server.";
        }
        return response.readEntity(String.class);
    }

    @Override
    public String notifyWriterOfStorySubmission(Integer writerId, Boolean approved) {
        String notifyUri = uri + "notifyWriterOfStorySubmission/{writerId}/{approved}";
        HashMap<String, Object> notifDetails = new HashMap<>();
        notifDetails.put("writerId", writerId);
        notifDetails.put("approved", approved);
        webTarget = client.target(notifyUri).resolveTemplates(notifDetails);
        response = webTarget.request().get();
        return response.readEntity(String.class);
    }

    @Override
    public String notifyBlockedWriters(List<Integer> accountIds) {
        try {
            String notifyBlockedWritersUri = uri + "notifyBlockedWriters";
            webTarget = client.target(notifyBlockedWritersUri);
            response = webTarget.request(MediaType.APPLICATION_JSON).post(Entity.json(toJsonString(accountIds)));
        } catch (IOException ex) {
            Logger.getLogger(LoginService_Impl.class.getName()).log(Level.SEVERE, null, ex);
            return "Something went wrong connecting to the server.";
        }
        return response.readEntity(String.class);
    }
}
