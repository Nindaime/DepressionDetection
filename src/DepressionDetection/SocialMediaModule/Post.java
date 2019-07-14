/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DepressionDetection.SocialMediaModule;

import java.util.Date;
import javafx.scene.image.ImageView;

/**
 *
 * @author PETER-PC
 */
public class Post {
    private int postID;
    private Date PostTime;
    public enum PostType {Image, Text};
    private PostType postType;
    private String postCaption;
    private String posterUsername;
    private ImageView postImage = new ImageView();
    private String postText;

    public Post(int postID, Date PostTime, PostType postType, String postCaption, String posterUsername, String postText) {
        this.postID = postID;
        this.PostTime = PostTime;
        this.postType = postType;
        this.postCaption = postCaption;
        this.posterUsername = posterUsername;
        this.postText = postText;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public Date getPostTime() {
        return PostTime;
    }

    public void setPostTime(Date PostTime) {
        this.PostTime = PostTime;
    }

    public PostType getPostType() {
        return postType;
    }

    public void setPostType(PostType postType) {
        this.postType = postType;
    }

    public String getPostCaption() {
        return postCaption;
    }

    public void setPostCaption(String postCaption) {
        this.postCaption = postCaption;
    }

    public String getPosterUsername() {
        return posterUsername;
    }

    public void setPosterUsername(String posterUsername) {
        this.posterUsername = posterUsername;
    }

    public ImageView getPostImage() {
        return postImage;
    }

    public void setPostImage(ImageView postImage) {
        this.postImage = postImage;
    }

    public String getPostText() {
        return postText;
    }

    public void setPostText(String postText) {
        this.postText = postText;
    }
    
}
