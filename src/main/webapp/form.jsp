<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 게시물 - Instagram</title>
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

        /* 메인 콘텐츠 */
        .main-container {
            max-width: 975px;
            margin: 80px auto 0;
            padding: 0 20px;
            display: flex;
            justify-content: center;
        }

        /* 폼 컨테이너 */
        .form-container {
            width: 100%;
            max-width: 550px;
            background-color: white;
            border: 1px solid var(--instagram-border);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .form-header {
            height: 60px;
            border-bottom: 1px solid var(--instagram-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 16px;
        }

        .form-title {
            font-size: 16px;
            font-weight: 600;
            flex: 1;
            text-align: center;
            margin: 0;
        }

        .form-back {
            font-size: 16px;
            color: #262626;
            text-decoration: none;
        }

        /* 업로드 영역 */
        .upload-container {
            display: flex;
            flex-direction: column;
        }

        .preview-area {
            width: 100%;
            aspect-ratio: 1 / 1;
            background-color: #f8f8f8;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: #8e8e8e;
            cursor: pointer;
            position: relative;
            overflow: hidden;
            border-bottom: 1px solid var(--instagram-border);
        }

        .preview-area i {
            font-size: 48px;
            margin-bottom: 12px;
        }

        .preview-text {
            font-size: 20px;
            font-weight: 300;
        }

        .preview-subtext {
            font-size: 14px;
            margin-top: 8px;
        }

        #preview-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .file-input {
            display: none;
        }

        /* 폼 내용 */
        .form-content {
            padding: 16px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }

        .form-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #262626;
        }

        .form-control {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid var(--instagram-border);
            border-radius: 3px;
            font-size: 14px;
            resize: none;
        }

        .form-control:focus {
            outline: none;
            border-color: #a8a8a8;
        }

        .form-control::placeholder {
            color: #8e8e8e;
        }

        .caption-count {
            margin-top: 4px;
            font-size: 12px;
            text-align: right;
            color: #8e8e8e;
        }

        /* 버튼 스타일 */
        .btn-submit {
            width: 100%;
            padding: 10px 0;
            background-color: var(--instagram-blue);
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-submit:hover {
            background-color: #0085e0;
        }

        .btn-submit:disabled {
            background-color: #b2dffc;
            cursor: not-allowed;
        }

        /* 태그 입력 스타일 */
        .tags-container {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 8px;
        }

        .tag {
            background-color: #efefef;
            border-radius: 3px;
            padding: 4px 8px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }

        .tag i {
            margin-left: 6px;
            font-size: 12px;
            cursor: pointer;
        }

        /* 이미지가 선택된 후 상태 */
        .has-image .preview-icon,
        .has-image .preview-text,
        .has-image .preview-subtext {
            display: none;
        }

        .has-image #preview-image {
            display: block;
        }

        /* 변경 버튼 */
        .change-image {
            position: absolute;
            bottom: 16px;
            right: 16px;
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 8px 12px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            display: none;
        }

        .has-image .change-image {
            display: block;
        }

        /* 반응형 스타일 */
        @media (max-width: 735px) {
            .form-container {
                max-width: 100%;
                border: none;
                border-radius: 0;
            }

            .main-container {
                padding: 0;
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
    </div>
</header>

<!-- 메인 콘텐츠 -->
<div class="main-container">
    <div class="form-container">
        <div class="form-header">
            <a href="guestbook" class="form-back">
                <i class="fas fa-arrow-left"></i>
            </a>
            <h1 class="form-title">새 게시물 만들기</h1>
            <div style="width: 24px;"></div> <!-- 균형을 위한 빈 공간 -->
        </div>

        <form action="guestbook" method="post" enctype="multipart/form-data" id="post-form">
            <div class="upload-container">
                <div class="preview-area" id="preview-area">
                    <i class="far fa-images preview-icon"></i>
                    <div class="preview-text">사진을 여기에 끌어다 놓으세요</div>
                    <div class="preview-subtext">또는 클릭하여 컴퓨터에서 선택</div>
                    <img id="preview-image" src="#" alt="미리보기 이미지">
                    <button type="button" class="change-image" id="change-image">사진 변경</button>
                </div>

                <input type="file" name="image" id="image" class="file-input" accept="image/*">

                <div class="form-content">
                    <div class="form-group">
                        <label class="form-label" for="name">사용자 이름</label>
                        <input type="text" id="name" name="name" class="form-control" placeholder="사용자 이름 입력..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="content">내용</label>
                        <textarea id="content" name="content" class="form-control" rows="3" placeholder="문구 입력..." maxlength="2200" required></textarea>
                        <div class="caption-count" id="caption-count">0/2,200</div>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="tags">태그</label>
                        <input type="text" id="tags-input" class="form-control" placeholder="#태그 입력... (공백으로 구분)">
                        <input type="hidden" id="tags" name="tags" value="">
                        <div class="tags-container" id="tags-container"></div>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn-submit" id="submit-btn">공유하기</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    // 이미지 프리뷰 처리
    const previewArea = document.getElementById('preview-area');
    const fileInput = document.getElementById('image');
    const previewImage = document.getElementById('preview-image');
    const changeImageBtn = document.getElementById('change-image');

    previewArea.addEventListener('click', function() {
        fileInput.click();
    });

    changeImageBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        fileInput.click();
    });

    fileInput.addEventListener('change', function() {
        if (this.files && this.files[0]) {
            const reader = new FileReader();

            reader.onload = function(e) {
                previewImage.src = e.target.result;
                previewArea.classList.add('has-image');
            }

            reader.readAsDataURL(this.files[0]);
        }
    });

    // 내용 글자수 카운트
    const contentTextarea = document.getElementById('content');
    const captionCount = document.getElementById('caption-count');

    contentTextarea.addEventListener('input', function() {
        const count = this.value.length;
        captionCount.textContent = `${count}/2,200`;
    });

    // 태그 처리
    const tagsInput = document.getElementById('tags-input');
    const tagsContainer = document.getElementById('tags-container');
    const tagsHidden = document.getElementById('tags');
    let tags = [];

    tagsInput.addEventListener('keydown', function(e) {
        if (e.key === ' ' && this.value.trim() !== '') {
            const tagText = this.value.trim();

            // # 접두사가 없으면 추가
            const formattedTag = tagText.startsWith('#') ? tagText : `#${tagText}`;

            if (!tags.includes(formattedTag)) {
                tags.push(formattedTag);
                updateTags();
            }

            this.value = '';
        }
    });

    function updateTags() {
        // 태그 UI 업데이트
        tagsContainer.innerHTML = '';
        tags.forEach((tag, index) => {
            const tagElement = document.createElement('div');
            tagElement.className = 'tag';
            tagElement.innerHTML = `${tag} <i class="fas fa-times" data-index="${index}"></i>`;
            tagsContainer.appendChild(tagElement);
        });

        // 히든 입력 필드 업데이트
        tagsHidden.value = tags.join(' ');

        // 삭제 버튼 이벤트 추가
        document.querySelectorAll('.tag i').forEach(icon => {
            icon.addEventListener('click', function() {
                const index = parseInt(this.getAttribute('data-index'));
                tags.splice(index, 1);
                updateTags();
            });
        });
    }

    // 폼 제출 전 유효성 검사
    const form = document.getElementById('post-form');
    const submitBtn = document.getElementById('submit-btn');

    form.addEventListener('submit', function(e) {
        const nameField = document.getElementById('name');
        const contentField = document.getElementById('content');

        if (nameField.value.trim() === '' || contentField.value.trim() === '') {
            e.preventDefault();
            alert('사용자 이름과 내용을 입력해주세요.');
        }
    });
</script>

</body>
</html>