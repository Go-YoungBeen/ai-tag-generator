package com.example.guestbook;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;
import java.util.List;

@WebServlet("/")
@MultipartConfig  // ✅ 파일 업로드 처리 가능하게 해줌
public class GuestbookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Message> messages = MessageRepository.getAllMessages();
        request.setAttribute("messages", messages);
        request.getRequestDispatcher("/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String content = request.getParameter("content");

        // ✅ 이미지 처리
        Part filePart = request.getPart("image");
        String imagePath = null;

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            // 실제 저장 경로 (webapp/uploads)
            String uploadDir = getServletContext().getRealPath("/uploads");
            File uploadFolder = new File(uploadDir);
            if (!uploadFolder.exists()) uploadFolder.mkdirs();

            File saveFile = new File(uploadFolder, fileName);

            try (InputStream in = filePart.getInputStream();
                 FileOutputStream out = new FileOutputStream(saveFile)) {
                byte[] buffer = new byte[1024];
                int len;
                while ((len = in.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }
            }

            // DB에 저장할 경로 (상대 경로)
            imagePath = "uploads/" + fileName;
        }

        // LLM 태그 생성
        String tags = LLMService.generateTags(content);

        // ✅ 이미지 경로 포함한 메시지 저장
        Message message = new Message(name, content, tags, imagePath);
        MessageRepository.addMessage(message);

        response.sendRedirect(request.getContextPath() + "/guestbook");
    }
}
