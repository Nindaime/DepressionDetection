/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.GUIComponents;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextField;

/**
 * FXML Controller class
 *
 * @author PETER-PC
 */
public class LoginPageController implements Initializable {

    /**
     * Initializes the controller class.
     */
    @FXML
    private TextField txtusernamelog; 
    
    @FXML 
    private TextField txtpasswordlog; 
    
    @FXML 
    private TextField txtlabel; 
    
    //@Override
    public void initialize(ActionEvent event) {
        // TODO
        if(txtusernamelog.getText().equals("user")&& txtpasswordlog.getText().equals("password")){
        txtlabel.setText("Login Successful");
        }else{
       txtlabel.setText("Login Failed");
    }    
    
}
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    
}
