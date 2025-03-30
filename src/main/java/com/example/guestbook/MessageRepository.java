package com.example.guestbook;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageRepository {


    public static void addMessage(Message message) {
        String sql = "INSERT INTO messages (name, content, tags, image_path) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, message.getName());
            pstmt.setString(2, message.getContent());
            pstmt.setString(3, message.getTags());
            pstmt.setString(4, message.getImagePath()); // ✅ 추가
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ 모든 메시지 조회 (SELECT) - imagePath 포함
    public static List<Message> getAllMessages() {
        List<Message> list = new ArrayList<>();
        String sql = "SELECT id, name, content, tags, image_path, created_at FROM messages ORDER BY created_at DESC";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String content = rs.getString("content");
                String tags = rs.getString("tags");
                String imagePath = rs.getString("image_path");
                Timestamp createdAt = rs.getTimestamp("created_at");  // ✅

                list.add(new Message(id, name, content, tags, imagePath, createdAt));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public static void deleteMessage(int id) {
        String sql = "DELETE FROM messages WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
