/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.QuestionnaireModule;

import java.util.Date;

/**
 *
 * @author PETER-PC
 */
public class QuestionnaireBuilder {
    private byte[][] questionMapping;
    
    
    
    //retreive questions from databases based on depressionType 
    //and build question objects
    //use database utility class retrieve values from database
    public void getQuestionsFromDB(DepressionType depressionType){}
    
    //invoke this method in the getQuestionsFromDB method
    public void getAnswersFromDB(String questionID){}
    
    //Generate Major General Questionnaire Mapping
    public void generateGeneral_QuestionnaireMapping(){}
    
    //Generate Seasonal Affective Disorder Questionnaire Mapping
    public void generateSAD_QuestionnaireMapping(){}
    
    //Generate Persistent Depressive Disorder Questionnaire Mapping
    public void generatePDD_QuestionnaireMapping(){}
    
    //Generate Postpartum Depression Questionnaire Mapping
    public void generatePPD_QuestionnaireMapping(){}
    
    //Generate Premenstrual Dysphoric Disorder Questionnaire Mapping
    public void generatePMDD_QuestionnaireMapping(){}
    
    //Generate Situational Depression Questionnaire Mapping
    public void generateSD_QuestionnaireMapping(){}
    
    //Generate Atypical Depression Questionnaire Mapping
    public void generateAD_QuestionnaireMapping(){}
    
    //Generate Major Depressive Disorder Questionnaire Mapping
    public void generateMDD_QuestionnaireMapping(){}
    
    //Generate Psychotic Depression Questionnaire Mapping
    public void generatePD_QuestionnaireMapping(){}
    
    //Generate Bipolar Disorder Questionnaire Mapping
    public void generateBD_QuestionnaireMapping(){}
}
