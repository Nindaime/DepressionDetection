/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.UserModule;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import javafx.collections.FXCollections;
import javafx.scene.chart.AreaChart;
import javafx.scene.chart.Axis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Tooltip;

/**
 *
 * @author PETER-PC
 */
public class UserMentalHealthVisualizer extends AreaChart{
//    public enum VisualizerType {userVariability, userInstability, userDiagnosisHistory};
//    private VisualizerType visualizerType;
    private final byte[] userVariabilityDataStream;
    private final byte[] userInstabilityDataStream;
    private final byte[] userDiagnosisHistoryDataStream;
    private final String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
    private final byte bound = 5;
    
    public UserMentalHealthVisualizer(Axis xAxis, Axis yAxis, byte[] userVariabilityDataStream, byte[] userInstabilityDataStream, byte[] userDiagnosisHistory) {
        super(xAxis, yAxis);
        this.userDiagnosisHistoryDataStream = userDiagnosisHistory;
        this.userVariabilityDataStream = userVariabilityDataStream;
        this.userInstabilityDataStream = userInstabilityDataStream;
    }

    public void displayUserDiagnosisHistory(){
        XYChart.Series<String,Number> seriesUserVariability = new XYChart.Series<>();
        seriesUserVariability.setName("User Mental Health History");
        
        int byteIndex = 0;
        
        for(byte b: userDiagnosisHistoryDataStream){
            int monthIndex = byteIndex % 12;
            seriesUserVariability.getData().add(new XYChart.Data(months[monthIndex], b));
            byteIndex++;
        }
        
//        for(Data<String, Number> entry: seriesUserVariability.getData())
//            Tooltip.install(entry.getNode(), new Tooltip("Tooltip String"));
        
        getData().add(seriesUserVariability);
        
    }
    
    public void displayUserMentalVariability(){
        XYChart.Series<String, Number> seriesUserVariability = new XYChart.Series<>();
        seriesUserVariability.setName("User Mental Health Variability");
        
        XYChart.Series<String, Number> seriesUserVariabilityUpperBound = new XYChart.Series<>();
        seriesUserVariability.setName("Healthy User Mental Health Variability");
       
        XYChart.Series<String, Number> seriesUserVariabilityLowerBound = new XYChart.Series<>();
        seriesUserVariability.setName("Unhealthy User Mental Health Variability");
        
        byte[] sortedArray = new byte[userVariabilityDataStream.length];
        int index = 0;
        for(byte b: userVariabilityDataStream){
            sortedArray[index] = b;
            index++;
        }
        
        //derive the bounds which define a healthy range of user mental health variability
        Arrays.sort(sortedArray);
        byte upperbound = (byte)(sortedArray[sortedArray.length] - bound);
        byte lowerbound = (byte)(sortedArray[0] + bound);
                
        int byteIndex = 0;
        for(byte b: userVariabilityDataStream){
            int monthIndex = byteIndex % 12;
            seriesUserVariability.getData().add(new XYChart.Data(months[monthIndex], b));
            seriesUserVariabilityUpperBound.getData().add(new XYChart.Data(months[monthIndex], upperbound));
            seriesUserVariabilityLowerBound.getData().add(new XYChart.Data(months[monthIndex], lowerbound));
            byteIndex++;
        }
        
        getData().addAll(seriesUserVariability, seriesUserVariabilityUpperBound, seriesUserVariabilityLowerBound);
    }
    
    public void displayUserMentalInstability(){
        XYChart.Series<String, Number> seriesUserInstability = new XYChart.Series<>();
        seriesUserInstability.setName("User Mental Health Instability");
        
        XYChart.Series<String, Number> seriesUserInstabilityUpperBound = new XYChart.Series<>();
        seriesUserInstability.setName("Healthy User Mental Health Instability");
       
        XYChart.Series<String, Number> seriesUserInstabilityLowerBound = new XYChart.Series<>();
        seriesUserInstability.setName("Unhealthy User Mental Health Instability");
        
        byte[] sortedArray = new byte[userInstabilityDataStream.length];
        int index = 0;
        for(byte b: userInstabilityDataStream){
            sortedArray[index] = b;
            index++;
        }
        
        //derive the bounds which define a healthy range of user mental health instability
        Arrays.sort(sortedArray);
        byte upperbound = (byte)(sortedArray[sortedArray.length] - bound);
        byte lowerbound = (byte)(sortedArray[0] + bound);
                
        int byteIndex = 0;
        for(byte b: userInstabilityDataStream){
            int monthIndex = byteIndex % 12;
            seriesUserInstability.getData().add(new XYChart.Data(months[monthIndex], b));
            seriesUserInstabilityUpperBound.getData().add(new XYChart.Data(months[monthIndex], upperbound));
            seriesUserInstabilityLowerBound.getData().add(new XYChart.Data(months[monthIndex], lowerbound));
            byteIndex++;
        }
        
        getData().addAll(seriesUserInstability, seriesUserInstabilityUpperBound, seriesUserInstabilityLowerBound);
    }
    
}
