/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.DatabaseConnection;

import DepressionDetection.QuestionnaireModule.Answer;
import DepressionDetection.QuestionnaireModule.Questionnaire;
import DepressionDetection.SocialMediaModule.Comment;
import DepressionDetection.SocialMediaModule.Post;
import DepressionDetection.UserModule.SocialMediaUser;
import DepressionDetection.UserModule.User;
import DepressionDetection.UserModule.UserMentalHealthStatus;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author PETER-PC
 */
public class DatabaseUtilityClass {
    
    //add database utility methods as required

    
    public static List<User> getUserList(){
        String sql = "SELECT * FROM User ORDER BY USERID";
        List<User> userList = new ArrayList<>();
        try(Connection connection = DBUtil.getConnection()){

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    int USERID = resultSet.getInt("Userid");
                    String USERNAME = resultSet.getString("Username");
                    String USERTYPE = resultSet.getString("Usertype");
                    SocialMediaUser.RelationshipStatus rsStatus = SocialMediaUser.
                            getRelationshipStatusFromString(resultSet.getString("RelationshipStatus"));
                    SocialMediaUser.Gender gender = SocialMediaUser.getGenderFromString(resultSet.getString("Gender"));
                    String[] friendlist = getFriendList(resultSet.getInt("UserId"));

                    User user = new SocialMediaUser(rsStatus, gender, friendlist, USERID, USERNAME, User.getUserTypeFromString(USERTYPE));
                    userList.add(user);
                }

        }catch(Exception exception) {
            exception.printStackTrace();
        }

        return userList;
    }
    
    public static String[] getFriendList(int userid){
        String sql = "SELECT * FROM FRIENDS WHERE USER = ?";
        ArrayList<String> friendList = new ArrayList<>();
        try(Connection connection = DBUtil.getConnection()){
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userid);
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next())
                friendList.add(resultSet.getString("Username"));

            return (String[])friendList.toArray();
        } catch(Exception exception) {
           exception.printStackTrace();
        }

    }
    
    public static ArrayList<String> getUserActivity(int userId){
        String sql = "SELECT * FROM ActivityTable WHERE User_ID = ?";
        ArrayList<String> userActivity = new ArrayList<>();
        try(Connection connection = DBUtil.getConnection()){

            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String activityName = resultSet.getString();
                String activityTime = resultSet.getString();
                resultSet.close();

                userActivity.add(activityName);
                userActivity.add(activityTime);
                resultSet.close();

            }

        } catch(Exception exception) {
            exception.printStackTrace();
        }

        return userActivity;

    }
    
    public static UserMentalHealthStatus getUserMentalHealthStatus(int userID){
        String  sql = "SELECT * FROM UserMentalHealthStatus WHERE User_ID = ?";
        Connection connection = DBUtil.getConnection();
        try (PreparedStatement preparedStatement =
                connection.prepareStatement(sql)){
            preparedStatement.setInt(1, userID);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                byte[] Variability = resultSet.getBytes();
                byte[] Instability = resultSet.getBytes();
                byte[] DiagnosisHistory = resultSet.getBytes();
                String CurrDeprTypeID = resultSet.getString();

                resultSet.close();

                UserMentalHealthStatus mentalHealthStatus =
                        new UserMentalHealthStatus(Variability, Instability, DiagnosisHistory, currDeprTypeID, null);


                return mentalHealthStatus;
            } else {
                resultSet.close();
                return null;
            } catch (SQLException e) {
                throw new Exception(e.getMessage());
            }
        }
    }
    
    public static ArrayList<Answer> getQuestionnaireResult(){
        String sql = "SELECT * FROM QuestionnaireSession ORDER BY QuestionnaireSessionID";
        ArrayList<Answer> questionnaireResult = new ArrayList<>();
        try(Connection connection = DBUtil.getConnection()){

            PreparedStatement preparedStatement =
                         connection.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery()){
                while (resultSet.next()) {
                    int userID = resultSet.getInt();
                    String answerID = resultSet.getString();
                    int questionID = resultSet.getInt();

                    Questionnaire questionnaire = new Questionnaire(userID, answerID, questionID);
                    questionnaireResult.add(questionnaire);
                }
            }
        }catch(Exception exception) {
            exception.printStackTrace();
        }
        return questionnaireResult;
    }
    
    public static List<Post> getPostsClassification(){
        String sql = "SELECT * FROM Post ORDER BY postID";
        List<Post> postList = new ArrayList<>();
        Connection connection = DBUtil.getConnection();

        try (PreparedStatement preparedStatement =
                     connection.prepareStatement(sql));
        ResultSet resultSet = preparedStatement.executeQuery()){
            while (resultSet.next()) {
                int postID = resultSet.getInt();
                String posterUsername = resultSet.getString();
                String PostTime = resultSet.getString();
                String PostType = resultSet.getString();
                String PostCaption = resultSet.getString();
                String PostImage = resultSet.getString();
                String PostText = resultSet.getString();


                Post post = new Post(postID, posterUsername, PostTime, PostType, PostCaption, PostImage, PostText);
                postList.add(post);
            }
            return postList;
        }catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }
    }
    
    public static List<Comment> getPost_Comments(String username){
        String sql = "SELECT * FROM Comments ORDER BY commenterUsername";
        List<Comment> postComments = new ArrayList<>();
        Connection connection = DBUtil.getConnection();

        try (PreparedStatement preparedStatement =
                     connection.prepareStatement(sql));
        ResultSet resultSet = preparedStatement.executeQuery()){
            while (resultSet.next()) {
                int postID = resultSet.getInt();
                String commenterUsername = resultSet.getString();
                String commentTime = resultSet.getString();
                String CommentText = resultSet.getString();

                Comment comment = new Comment(postID, commenterUsername, commentTime, CommentText);
                postComments.add(comment);
            }
            return postComments;
        }catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }
    }
    
    //use switch statement to alternate results
    public static UserMentalHealthStatus getQuestionnaireByDepressionType(String depressionType){
        String  sql = "SELECT * FROM QuestionnaireQ WHERE DepressionTypeID = ?";
        Connection connection = DBUtil.getConnection();
        switch (depressionType) {
            case "General":
                try (PreparedStatement preparedStatement =
                        connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Seasonal Affective Disorder":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Persistent Depressive Disorder":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Premenstrual Dysphoric Disorder":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Situational Depression":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Atypical Depression":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Major Depressive Disorder":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Psychotic Depression":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            case "Bipolar Disorder":
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;
            default:
                try (PreparedStatement preparedStatement =
                             connection.prepareStatement(sql)) {
                    ResultSet rs =preparedStatement.executeQuery();
                    if (rs.next()) {
                        int questionId = rs.getInt();
                        String questionText = rs.getString();

                        rs.close();

                        UserMentalHealthStatus mentalHealthStatus =
                                new UserMentalHealthStatus(questionId, questionText);
                        return mentalHealthStatus;
                    } else{
                        rs.close();
                        return null;
                    }
                } catch (SQLException exception) {
                    throw new Exception(exception.getMessage());
                }
                break;


        }
    }

    public static UserMentalHealthStatus getQuestionnaireBySessionID(int sessionID) {

    }

    public static SocialMediaUser getSocialMediaUserProfile(int userId){
        String sql = "SELECT * FROM User WHERE User_ID = ?";
        Connection connection = DBUtil.getConnection();

        try (PreparedStatement preparedStatement =
                     connection.prepareStatement(sql));
        ResultSet resultSet = preparedStatement.executeQuery()){
            while (resultSet.next()) {
                String username = resultSet.getString();
                String password = resultSet.getString();
                int age = resultSet.getInt();
                String userType = resultSet.getString();
                String relationshipStatus = resultSet.getString();
                String gender = resultSet.getString();
                String [] friendList = resultSet.getString();

                SocialMediaUser socialMediaUser = new SocialMediaUser(userId, username, password,
                        age, gender, relationshipStatus, friendList);

            }
            return socialMediaUser;
        }catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }
    }
}