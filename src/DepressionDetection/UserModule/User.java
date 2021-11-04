/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.UserModule;

/**
 *
 * @author PETER-PC
 */
public abstract class User implements Comparable<User>{
    private final int USERID;
    private final String USERNAME;
    public enum UserType {Admin, SocialMediaUser};
    private final UserType USERTYPE;

    public User(int USERID, String USERNAME, UserType USERTYPE) {
        this.USERID = USERID;
        this.USERNAME = USERNAME;
        this.USERTYPE = USERTYPE;
    }

    public static UserType getUserTypeFromString(String type){
        switch (type){
            case "Admin":
                return UserType.Admin;
            default:
                return UserType.SocialMediaUser;
        }
    }
    public int getUSERID() {
        return USERID;
    }

    public String getUSERNAME() {
        return USERNAME;
    }

    public UserType getUSERTYPE() {
        return USERTYPE;
    }  
    
}
