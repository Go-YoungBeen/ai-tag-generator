package com.example.guestbook;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    private static final Dotenv dotenv = Dotenv.configure()
            .filename(".env")   // ✅ resources 내 .env 로드
            .load();
    // classpath 에서 .env 자동 탐색


    private static final String url = dotenv.get("DB_URL");
    private static final String user = dotenv.get("DB_USER");
    private static final String password = dotenv.get("DB_PASSWORD");

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, password);
    }
}
