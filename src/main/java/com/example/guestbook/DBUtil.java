package com.example.guestbook;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    private static final Dotenv dotenv = Dotenv.configure()
            .filename(".env")
            .ignoreIfMissing() // Render에는 파일 없으므로 무시
            .load();

    private static final String url = System.getenv("DB_URL") != null ?
            System.getenv("DB_URL") : dotenv.get("DB_URL");

    private static final String user = System.getenv("DB_USER") != null ?
            System.getenv("DB_USER") : dotenv.get("DB_USER");

    private static final String password = System.getenv("DB_PASSWORD") != null ?
            System.getenv("DB_PASSWORD") : dotenv.get("DB_PASSWORD");

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
}
