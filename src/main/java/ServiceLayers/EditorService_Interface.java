/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package ServiceLayers;

import Models.Editor;
import java.util.List;

/**
 *
 * @author jarro
 */
public interface EditorService_Interface {
    public List<Editor> getAllEditors();
    public String addEditor(Editor editor);
    public String deleteEditor(Integer editorId);
    public String updateEditor(Editor editor);
}
