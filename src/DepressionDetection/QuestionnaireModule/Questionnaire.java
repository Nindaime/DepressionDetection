/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.QuestionnaireModule;

import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author PETER-PC
 */
public class Questionnaire {
    private Date sessionID;
    private int questionnaireUserID;
    private float cummulativeImpactScore;
    private Diagnosis diagnosis;
    private ArrayList<String> questions;

    public Questionnaire(Date sessionID, int questionnaireUserID) {
        this.sessionID = sessionID;
        this.questionnaireUserID = questionnaireUserID;
        this.cummulativeImpactScore = 0;
        this.diagnosis = new Diagnosis();//to-do
    }

    public Date getSessionID() {
        return sessionID;
    }

    public void setSessionID(Date sessionID) {
        this.sessionID = sessionID;
    }

    public int getQuestionnaireUserID() {
        return questionnaireUserID;
    }

    public void setQuestionnaireUserID(int questionnaireUserID) {
        this.questionnaireUserID = questionnaireUserID;
    }

    public float getCummulativeImpactScore() {
        return cummulativeImpactScore;
    }

    public void setCummulativeImpactScore(float cummulativeImpactScore) {
        this.cummulativeImpactScore = cummulativeImpactScore;
    }

    public Diagnosis getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(Diagnosis diagnosis) {
        this.diagnosis = diagnosis;
    }

    public void setQuestions(ArrayList<String> questions1) {
        this.questions = questions1;
    }

    public ArrayList<String> getQuestions() {
        return questions;
    }
    
    
    
}