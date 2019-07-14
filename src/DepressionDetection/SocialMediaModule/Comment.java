/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.SocialMediaModule;

import java.util.Date;

/**
 *
 * @author PETER-PC
 */
public class Comment {
    private int postID;
    private String commenterUsername;
    private Date commentTime;
    private String CommentText;

    public Comment(int postID, String commenterUsername, Date commentTime, String CommentText) {
        this.postID = postID;
        this.commenterUsername = commenterUsername;
        this.commentTime = commentTime;
        this.CommentText = CommentText;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getCommenterUsername() {
        return commenterUsername;
    }

    public void setCommenterUsername(String commenterUsername) {
        this.commenterUsername = commenterUsername;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getCommentText() {
        return CommentText;
    }

    public void setCommentText(String CommentText) {
        this.CommentText = CommentText;
    }
    
}
