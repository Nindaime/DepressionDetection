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
import javafx.scene.chart.AreaChart;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Pane;
import javafx.scene.text.Text;

/**
 * FXML Controller class
 *
 * @author PETER-PC
 */
public class ViewMentalHealthStatusController implements Initializable {



    @FXML
    private AnchorPane anchorPane;

    @FXML
    private Pane backArrowPane;

    @FXML
    private Pane closePane;

    @FXML
    private ImageView imageView;

    @FXML
    private Text userName;

    @FXML
    private AreaChart<?, ?> areaChart;

    @FXML
    private Text healthReportTitle;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }

}
