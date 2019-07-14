/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.QuestionnaireModule;

/**
 *
 * @author PETER-PC
 */
public class Answer {
    private int answerID;
    private String answerText;
    private float impactScore;
    private int questionID;

    public Answer(int answerID, String answerText, int questionID) {
        this.answerID = answerID;
        this.answerText = answerText;
        this.questionID = questionID;
        impactScore = 0;
        Question.getQuestionList().get(questionID).getAnswers().add(this);
    }

    public int getAnswerID() {
        return answerID;
    }

    public void setAnswerID(int answerID) {
        this.answerID = answerID;
    }

    public String getAnswerText() {
        return answerText;
    }

    public void setAnswerText(String answerText) {
        this.answerText = answerText;
    }

    public float getImpactScore() {
        return impactScore;
    }

    public void setImpactScore(float impactScore) {
        this.impactScore = impactScore;
    }

    public int getQuestionID() {
        return questionID;
    }

    public void setQuestionID(int questionID) {
        this.questionID = questionID;
    }
    
}
