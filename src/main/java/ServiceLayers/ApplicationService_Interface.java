/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package ServiceLayers;

import Models.Application;
import java.util.List;

/**
 *
 * @author jarro
 */
public interface ApplicationService_Interface {
    public List<Application> getApplications();
    public Boolean addApplication(Application application);
    public Boolean deleteApplication(Integer accountId);
}
