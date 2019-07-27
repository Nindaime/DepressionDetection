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
public class AdminUser extends User{

    public AdminUser(int USERID, String USERNAME, UserType USERTYPE) {
        super(USERID, USERNAME, USERTYPE);
    }

    @Override
    public int compareTo(User o) {
        if(this.getUSERID() > o.getUSERID())
            return 1;
        else if(this.getUSERID() < o.getUSERID())
            return -1;
        else
            return 0;
    }
    
}
