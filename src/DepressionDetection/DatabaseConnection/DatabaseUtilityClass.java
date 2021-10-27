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
        Connection connection = DBUtil.getConnection();

        try(PreparedStatement preparedStatement =
                     connection.prepareStatement(sql));
            ResultSet resultSet = preparedStatement.executeQuery()){
            while (resultSet.next()) {
                int USERID = resultSet.getInt();
                String USERNAME = resultSet.getString();
                String USERTYPE = resultSet.getString();

                User user = new User(USERID, USERNAME, USERTYPE);
                userList.add(user);
            }
            return userList;
        }catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }
    }
    
    public static SocialMediaUser getFriendList(String username){
        String sql = "SELECT * FROM User WHERE USERNAME = ?";
        Connection connection = DBUtil.getConnection();
        try (PreparedStatement preparedStatement =
                connection.prepareStatement(sql)) {
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String [] friendList = resultSet.getString();
                resultSet.close();

                SocialMediaUser mediaUser = new SocialMediaUser(null, null, friendList, null, null, null);
                return mediaUser;

            } else {
                resultSet.close();
                return null;
            }
        } catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }

    }
    
    public static String getUserActivity(int userId){
        String sql = "SELECT * FROM ActivityTable WHERE User_ID = ?";
        Connection connection = DBUtil.getConnection();
        List<String> userActivity = new ArrayList<>();

        try (PreparedStatement preparedStatement =
                     connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String activityName = resultSet.getString();
                String activityTime = resultSet.getString();
                resultSet.close();

                userActivity.add(activityName);
                userActivity.add(activityTime);
                resultSet.close();
                return userActivity;

            } else {
                resultSet.close();
                return null;
            }
        } catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }

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
    
    public static List<Answer> getQuestionnaireResult){
        String sql = "SELECT * FROM QuestionnaireSession ORDER BY QuestionnaireSessionID";
        List<Answer> questionnaireResult = new ArrayList<>();
        Connection connection = DBUtil.getConnection();

        try (PreparedStatement preparedStatement =
                     connection.prepareStatement(sql));
        ResultSet resultSet = preparedStatement.executeQuery()){
            while (resultSet.next()) {
                int userID = resultSet.getInt();
                String answerID = resultSet.getString();
                int questionID = resultSet.getInt();

                Questionnaire questionnaire = new Questionnaire(userID, answerID, questionID);
                questionnaireResult.add(questionnaire);
            }
            return questionnaireResult;
        }catch(SQLException exception) {
            throw new Exception(exception.getMessage());
        }
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