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
public enum DepressionType {
    General(0, "No Depression Disorder"),
    SAD(100, "Seasonal Affective Disorder"),
    Dysthymia(200, "Persistent Depression Disorder"),
    PDD(300, "Postpartum Depression"),
    PMDD(400, "Premenstrual Dysphoric Disorder"),
    SD(500, "Situational Depression"),
    AD(600, "Atypical Depression"),
    MDD(700, "Major Depressive Disorder"),
    PD(800, "Pyschotic Depression"),
    BD(900, "Bipolar Disorder");
    
    private final int initialImpactScore;
    private final String diagnosisDescriptionText;

    private DepressionType(int initialImpactScore, String diagnosisDescriptionText) {
        this.initialImpactScore = initialImpactScore;
        this.diagnosisDescriptionText = diagnosisDescriptionText;
    }

    public static DepressionType getGeneral() {
        return General;
    }

    public static DepressionType getSAD() {
        return SAD;
    }

    public static DepressionType getDysthymia() {
        return Dysthymia;
    }

    public static DepressionType getPDD() {
        return PDD;
    }

    public static DepressionType getPMDD() {
        return PMDD;
    }

    public static DepressionType getSD() {
        return SD;
    }

    public static DepressionType getAD() {
        return AD;
    }

    public static DepressionType getMDD() {
        return MDD;
    }

    public static DepressionType getPD() {
        return PD;
    }

    public static DepressionType getBD() {
        return BD;
    }

    public int getInitialImpactScore() {
        return initialImpactScore;
    }

    public String getDiagnosisDescriptionText() {
        return diagnosisDescriptionText;
    }
    
    
}
