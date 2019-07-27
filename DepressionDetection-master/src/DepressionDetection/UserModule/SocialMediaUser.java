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
public class SocialMediaUser extends User{
    public enum RelationshipStatus {Single, Dating, Married};
    private RelationshipStatus relationshipStatus;
    public enum Gender {Male, Female};
    private Gender gender;
    private String[] friendList;

    public SocialMediaUser(RelationshipStatus relationshipStatus, Gender gender, String[] friendList, int USERID, String USERNAME, UserType USERTYPE) {
        super(USERID, USERNAME, USERTYPE);
        this.relationshipStatus = relationshipStatus;
        this.gender = gender;
        this.friendList = friendList;
    }

    public RelationshipStatus getRelationshipStatus() {
        return relationshipStatus;
    }

    public void setRelationshipStatus(RelationshipStatus relationshipStatus) {
        this.relationshipStatus = relationshipStatus;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public String[] getFriendList() {
        return friendList;
    }

    public void setFriendList(String[] friendList) {
        this.friendList = friendList;
    }
    
    @Override
    public int compareTo(User o) {
        if (this.getUSERID() > o.getUSERID()) 
            return 1;
        else if (this.getUSERID() < o.getUSERID()) 
            return -1;
        else 
            return 0;
    }
}
