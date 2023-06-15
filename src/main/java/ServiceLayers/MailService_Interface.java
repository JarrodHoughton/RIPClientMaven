/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package ServiceLayers;

/**
 *
 * @author jarro
 */
public interface MailService_Interface {
    public Boolean sendMail(String serverEmail, String serverPassword, String userEmail, String email, String subject);
}
