<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.example.guestbook.Message" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instagram-Style MyFeed</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --instagram-font: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            --instagram-border: #dbdbdb;
            --instagram-light-bg: #fafafa;
            --instagram-blue: #0095f6;
            --instagram-red: #ed4956;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--instagram-font);
            background-color: var(--instagram-light-bg);
            color: #262626;
        }

        /* 헤더 스타일 */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 60px;
            background-color: white;
            border-bottom: 1px solid var(--instagram-border);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 0 20px;
            z-index: 100;
        }

        .header-container {
            max-width: 975px;
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 8px;
        }

        .search-bar {
            background-color: var(--instagram-light-bg);
            border-radius: 8px;
            border: 1px solid var(--instagram-border);
            padding: 8px 16px;
            width: 268px;
            font-size: 14px;
            color: #8e8e8e;
            display: flex;
            align-items: center;
        }

        .search-bar i {
            margin-right: 8px;
            color: #8e8e8e;
        }

        .search-input {
            border: none;
            background: transparent;
            outline: none;
            width: 100%;
        }

        .header-actions {
            display: flex;
            align-items: center;
            gap: 22px;
        }

        .header-icon {
            font-size: 22px;
            cursor: pointer;
        }

        /* 메인 콘텐츠 스타일 */
        .main-container {
            max-width: 975px;
            margin: 80px auto 0;
            padding: 0 20px;
            display: flex;
        }

        .feed {
            max-width: 614px;
            width: 100%;
            margin: 0 auto;
        }

        .story-bar {
            background-color: white;
            border: 1px solid var(--instagram-border);
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 24px;
            display: flex;
            overflow-x: auto;
            scrollbar-width: none;
        }

        .story-bar::-webkit-scrollbar {
            display: none;
        }

        .story {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-right: 20px;
            cursor: pointer;
        }

        .story-avatar {
            width: 66px;
            height: 66px;
            border-radius: 50%;
            background: linear-gradient(45deg, #FCAF45, #E95950, #C13584, #833AB4);
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 8px;
        }

        .story-avatar-inner {
            width: 62px;
            height: 62px;
            border-radius: 50%;
            background-color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .story-avatar-inner i {
            font-size: 32px;
            color: #8e8e8e;
        }

        .story-username {
            font-size: 12px;
            color: #262626;
            max-width: 74px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .post {
            background-color: white;
            border: 1px solid var(--instagram-border);
            border-radius: 8px;
            margin-bottom: 12px;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 16px;
        }

        .post-user {
            display: flex;
            align-items: center;
        }

        .post-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #efefef;
            margin-right: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .post-avatar i {
            font-size: 18px;
            color: #8e8e8e;
        }

        .post-username {
            font-weight: 600;
            font-size: 14px;
        }

        .post-more {
            font-size: 16px;
            cursor: pointer;
        }

        /* 이미지 컨테이너 스타일 수정 */
        .post-image {
            width: 100%;
            position: relative;
            background-color: #efefef;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            aspect-ratio: 1 / 1; /* 1:1 비율 유지 */
        }

        .post-image i {
            font-size: 48px;
            color: #8e8e8e;
        }

        /* 이미지 스타일 추가 */
        .post-image img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 컨테이너를 꽉 채우도록 */
            position: absolute;
            top: 0;
            left: 0;
        }

        .post-actions {
            display: flex;
            justify-content: space-between;
            padding: 8px 16px;
        }

        .post-action-left {
            display: flex;
            gap: 16px;
        }

        .post-action-icon {
            font-size: 24px;
            cursor: pointer;
        }

        .post-content {
            padding: 0 16px 16px;
        }

        .post-likes {
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 8px;
        }

        .post-caption {
            font-size: 14px;
            margin-bottom: 8px;
        }

        .post-username-caption {
            font-weight: 600;
            margin-right: 4px;
        }

        .post-tags {
            color: var(--instagram-blue);
            font-size: 14px;
            margin-bottom: 8px;
        }

        .post-time {
            font-size: 10px;
            color: #8e8e8e;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .post-comment-section {
            display: flex;
            border-top: 1px solid var(--instagram-border);
            padding: 16px;
        }

        .post-comment-input {
            flex: 1;
            border: none;
            outline: none;
            padding: 0;
            font-size: 14px;
        }

        .post-comment-button {
            color: var(--instagram-blue);
            font-weight: 600;
            font-size: 14px;
            background: none;
            border: none;
            cursor: pointer;
            opacity: 0.3;
        }

        /* 글쓰기 버튼 */
        .floating-button {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: auto;
            height: auto;
            padding: 15px 25px;
            border-radius: 10px;
            background-color: var(--instagram-blue);
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            cursor: pointer;
            z-index: 90;
            font-size: 20px;
            font-weight: bold;
            color: white;
            text-decoration: none;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            }
            50% {
                transform: scale(1.05);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            }
            100% {
                transform: scale(1);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            }
        }

        .floating-button i {
            color: white;
            font-size: 24px;
            margin-right: 10px;
        }

        /* 삭제 버튼 스타일 */
        .delete-button {
            background: none;
            border: none;
            color: var(--instagram-red);
            font-size: 12px;
            cursor: pointer;
            padding: 8px 0;
            font-weight: 600;
            display: flex;
            align-items: center;
        }

        .delete-button i {
            margin-right: 4px;
        }

        /* 비어있을 때 메시지 */
        .empty-feed {
            background-color: white;
            border: 1px solid var(--instagram-border);
            border-radius: 8px;
            padding: 40px 20px;
            text-align: center;
        }

        .empty-feed i {
            font-size: 48px;
            color: #8e8e8e;
            margin-bottom: 16px;
        }

        .empty-feed-text {
            font-size: 16px;
            color: #8e8e8e;
            margin-bottom: 16px;
        }

        /* 반응형 스타일 */
        @media (max-width: 735px) {
            .search-bar {
                display: none;
            }

            .main-container {
                padding: 0;
            }

            .feed {
                max-width: 100%;
            }

            .post {
                border-radius: 0;
                border-left: none;
                border-right: none;
            }
        }
    </style>
</head>
<body>

<!-- 헤더 -->
<header class="header">
    <div class="header-container">
        <div class="logo">
            <i class="fas fa-camera"></i>
            <span>MyFeed</span>
        </div>

        <div class="search-bar">
            <i class="fas fa-search"></i>
            <input type="text" class="search-input" placeholder="검색">
        </div>

        <div class="header-actions">
            <i class="fas fa-home header-icon"></i>
            <i class="far fa-paper-plane header-icon"></i>
            <i class="far fa-compass header-icon"></i>
            <i class="far fa-heart header-icon"></i>
            <i class="far fa-user header-icon"></i>
        </div>
    </div>
</header>

<!-- 메인 콘텐츠 -->
<div class="main-container">
    <div class="feed">
        <!-- 스토리 바 -->
        <div class="story-bar">
            <div class="story">
                <div class="story-avatar">
                    <div class="story-avatar-inner">
                        <i class="fas fa-plus"></i>
                    </div>
                </div>
                <div class="story-username">내 스토리</div>
            </div>
            <div class="story">
                <div class="story-avatar">
                    <div class="story-avatar-inner">
                        <i class="far fa-user"></i>
                    </div>
                </div>
                <div class="story-username">user1</div>
            </div>
            <div class="story">
                <div class="story-avatar">
                    <div class="story-avatar-inner">
                        <i class="far fa-user"></i>
                    </div>
                </div>
                <div class="story-username">user2</div>
            </div>
            <div class="story">
                <div class="story-avatar">
                    <div class="story-avatar-inner">
                        <i class="far fa-user"></i>
                    </div>
                </div>
                <div class="story-username">user3</div>
            </div>
            <div class="story">
                <div class="story-avatar">
                    <div class="story-avatar-inner">
                        <i class="far fa-user"></i>
                    </div>
                </div>
                <div class="story-username">user4</div>
            </div>
        </div>

        <!-- 게시물 목록 -->
        <%
            List<Message> messages = (List<Message>) request.getAttribute("messages");
            if (messages != null && !messages.isEmpty()) {
                for (Message msg : messages) {
        %>
        <div class="post">
            <div class="post-header">
                <div class="post-user">
                    <div class="post-avatar">
                        <i class="far fa-user"></i>
                    </div>
                    <div class="post-username"><%= msg.getName() %></div>
                </div>
                <div class="post-more">
                    <i class="fas fa-ellipsis-h"></i>
                </div>
            </div>

            <div class="post-image">
                <% if (msg.getImagePath() != null && !msg.getImagePath().isEmpty()) { %>
                <img src="<%= request.getContextPath() + "/" + msg.getImagePath() %>" alt="게시물 이미지" />
                <% } else { %>
                <i class="far fa-image"></i>
                <% } %>
            </div>

            <div class="post-actions">
                <div class="post-action-left">
                    <i class="far fa-heart post-action-icon"></i>
                    <i class="far fa-comment post-action-icon"></i>
                    <i class="far fa-paper-plane post-action-icon"></i>
                </div>
                <div>
                    <i class="far fa-bookmark post-action-icon"></i>
                </div>
            </div>

            <div class="post-content">
                <div class="post-likes">좋아요 0개</div>
                <div class="post-caption">
                    <span class="post-username-caption"><%= msg.getName() %></span>
                    <%= msg.getContent() %>
                </div>
                <div class="post-tags"><%= msg.getTags() %></div>
                <div class="post-time">
                    <%= new java.text.SimpleDateFormat("yyyy.MM.dd HH:mm").format(msg.getCreatedAt()) %>
                </div>


                <form action="delete" method="get">
                    <input type="hidden" name="id" value="<%= msg.getId() %>">
                    <button type="submit" class="delete-button">
                        <i class="far fa-trash-alt"></i>삭제하기
                    </button>
                </form>
            </div>

            <div class="post-comment-section">
                <input type="text" class="post-comment-input" placeholder="댓글 달기...">
                <button class="post-comment-button">게시</button>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="empty-feed">
            <i class="far fa-images"></i>
            <div class="empty-feed-text">게시물이 없습니다</div>
            <div>첫 번째 게시물을 작성해보세요!</div>
        </div>
        <%
            }
        %>
    </div>
</div>

<!-- 플로팅 글쓰기 버튼 -->
<a href="form.jsp" class="floating-button">
    <i class="fas fa-pencil-alt"></i>글쓰러가기
</a>

</body>
</html>