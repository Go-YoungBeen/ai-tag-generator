package com.example.guestbook;
import java.sql.Timestamp;

public class Message {
    private int id;
    private String name;
    private String content;
    private String tags;
    private String imagePath;
    private Timestamp createdAt;

    public Message(int id, String name, String content, String tags, String imagePath,Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.content = content;
        this.tags = tags;
        this.imagePath = imagePath;
        this.createdAt = createdAt;
    }

    public Message(String name, String content, String tags, String imagePath) {
        this(-1, name, content, tags, imagePath, null);
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getContent() { return content; }
    public String getTags() { return tags; }
    public String getImagePath() { return imagePath; }
    public Timestamp getCreatedAt() { return createdAt; }
}

