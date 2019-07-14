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
public class Diagnosis {
    private DepressionType depressionType;
    private Date timeDiagnosed;

    public Diagnosis(DepressionType depressionType, Date timeDiagnosed) {
        this.depressionType = depressionType;
        this.timeDiagnosed = timeDiagnosed;
    }

    public Diagnosis() {
        this.timeDiagnosed = new Date();
    }

    public DepressionType getDepressionType() {
        return depressionType;
    }

    public void setDepressionType(DepressionType depressionType) {
        this.depressionType = depressionType;
    }

    public Date getTimeDiagnosed() {
        return timeDiagnosed;
    }

    public void setTimeDiagnosed(Date timeDiagnosed) {
        this.timeDiagnosed = timeDiagnosed;
    }
    
    
    
}
