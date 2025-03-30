package com.example.guestbook;

import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import io.github.cdimascio.dotenv.Dotenv;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;

public class LLMService {
    private static final Dotenv dotenv = Dotenv.configure()
            .filename(".env")   // ✅ resources 내 .env 로드
            .load();


    private static final String API_KEY = System.getenv("GROQ_API_KEY");

    private static final String API_URL = "https://api.groq.com/openai/v1/chat/completions";
    private static final String SYSTEM_PROMPT = "문장을 읽고 관련 해시태그 3~5개를 생성해줘. 각 태그는 '#'으로 시작하고 쉼표로 구분해서 출력해.반드시 한글로";

    public static String generateTags(String message) {
        try {
            String requestBody = String.format("""
            {
              "model": "llama3-8b-8192",
              "messages": [
                {"role": "system", "content": "%s"},
                {"role": "user", "content": "%s"}
              ]
            }
            """, SYSTEM_PROMPT, message);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(API_URL))
                    .header("Content-Type", "application/json")
                    .header("Authorization", "Bearer " + API_KEY)
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody, StandardCharsets.UTF_8))
                    .build();

            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            String responseBody = response.body();
            System.out.println("[LLM 응답] " + responseBody);

            JsonObject json = JsonParser.parseString(responseBody).getAsJsonObject();
            if (json.has("error")) {
                return "#LLM오류: " + json.getAsJsonObject("error").get("message").getAsString();
            }

            JsonArray choices = json.getAsJsonArray("choices");
            if (choices == null || choices.size() == 0) {
                return "#LLM응답없음";
            }

            JsonObject messageObj = choices.get(0).getAsJsonObject().getAsJsonObject("message");
            return messageObj.get("content").getAsString().trim();

        } catch (Exception e) {
            e.printStackTrace();
            return "#오류발생";
        }
    }
}
