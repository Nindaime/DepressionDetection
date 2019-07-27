/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.GUIComponents;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextField;

/**
 * FXML Controller class
 *
 * @author PETER-PC
 */
public class RegistrationPageController implements Initializable {

    /**
     * Initializes the controller class.
     */
    @FXML
    private TextField txtusername; 
    
    @FXML 
    private TextField txtpassword; 
    
    @FXML
    private TextField txtgender; 
    
    @FXML 
    private TextField txtage; 
    
    @FXML
    private TextField txtusertype; 
    
    @FXML 
    private TextField txtonlinestatus;
    
    @FXML
    private TextField txtrelationship; 
    
    @FXML 
    private TextField txteducation; 
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        
       
    }    
    
}
