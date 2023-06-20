/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ServiceLayers;

import Models.Application;
import java.util.List;

/**
 *
 * @author jarro
 */
public class ApplicationService_Impl implements ApplicationService_Interface{

    @Override
    public List<Application> getApplications() {
        return null;
    }

    @Override
    public Boolean addApplication(Application application) {
        return false;
    }

    @Override
    public Boolean deleteApplication(Integer accountId) {
        return false;
    }
    
}
