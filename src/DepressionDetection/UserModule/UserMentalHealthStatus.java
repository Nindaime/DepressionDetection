/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.UserModule;

import DepressionDetection.QuestionnaireModule.Diagnosis;
import javafx.scene.chart.NumberAxis;

/**
 *
 * @author PETER-PC
 */
public class UserMentalHealthStatus {
    private byte[] userVariability;
    private byte[] userInstability;
    private byte[] userDiagnosisHistory;
    private UserMentalHealthVisualizer visualzer;
    private Diagnosis diagnosis;

    public UserMentalHealthStatus(byte[] userVariability, byte[] userInstability, byte[] userDiagnosisHistory, UserMentalHealthVisualizer visualzer, Diagnosis diagnosis) {
        this.userVariability = userVariability;
        this.userInstability = userInstability;
        this.userDiagnosisHistory = userDiagnosisHistory;
        this.visualzer = new UserMentalHealthVisualizer(new NumberAxis(), new NumberAxis(), userVariability, userInstability, userDiagnosisHistory);
        this.diagnosis = diagnosis;
    }

    public byte[] getUserVariability() {
        return userVariability;
    }

    public void setUserVariability(byte[] userVariability) {
        this.userVariability = userVariability;
    }

    public byte[] getUserInstability() {
        return userInstability;
    }

    public void setUserInstability(byte[] userInstability) {
        this.userInstability = userInstability;
    }

    public byte[] getUserDiagnosisHistory() {
        return userDiagnosisHistory;
    }

    public void setUserDiagnosisHistory(byte[] userDiagnosisHistory) {
        this.userDiagnosisHistory = userDiagnosisHistory;
    }

    public UserMentalHealthVisualizer getVisualzer() {
        return visualzer;
    }

    public void setVisualzer(UserMentalHealthVisualizer visualzer) {
        this.visualzer = visualzer;
    }

    
}
