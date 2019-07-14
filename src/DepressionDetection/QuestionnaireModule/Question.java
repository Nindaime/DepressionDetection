/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.QuestionnaireModule;

import java.util.ArrayList;

/**
 *
 * @author PETER-PC
 */
public class Question {
    private int questionID;
    private String questionText;
    private int[] followUpQuestionIDs;
    private int selectedAnswerID;
    private ArrayList<Answer> answers;
    private static ArrayList<Question> questionList;

    public Question(int questionID, String questionText, int[] followUpQuestionIDs) {
        this.questionID = questionID;
        this.questionText = questionText;
        this.followUpQuestionIDs = followUpQuestionIDs;
        selectedAnswerID = 0;
        if(answers == null)
            answers = new ArrayList<>();
        
        if(questionList == null)
            questionList = new ArrayList<>();
        
        questionList.add(this);
    }

    public ArrayList<Answer> getAnswers() {
        return answers;
    }

    public static ArrayList<Question> getQuestionList() {
        return questionList;
    }
    
    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public int[] getFollowUpQuestionIDs() {
        return followUpQuestionIDs;
    }

    public void setFollowUpQuestionIDs(int[] followUpQuestionIDs) {
        this.followUpQuestionIDs = followUpQuestionIDs;
    }

    public int getSelectedAnswerID() {
        return selectedAnswerID;
    }

    public void setSelectedAnswerID(int selectedAnswerID) {
        this.selectedAnswerID = selectedAnswerID;
    }
    
    
}
