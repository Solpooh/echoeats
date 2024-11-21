// For 수정 모드
const mode = container.getAttribute("data-mode");
const itemId = container.getAttribute("data-faqId") || container.getAttribute("data-noticeId");
const type = container.getAttribute("data-type");

// 파일 삭제 및 관리용 DataTransfer 객체 생성
const dataTransfer = new DataTransfer();

$('#imageUpload').on('change', function (event) {
    const data = event.target.files;

    if (!data.length) {
        $('#imageUpload').removeAttr('name');

    } else {
        $('#imageUpload').attr('name', 'uploadFile');

        $.each(data, function (index, file) {
            // 선택된 파일 추가
            dataTransfer.items.add(file);

            const reader = new FileReader();

            reader.onload = function () {
                const dataURL = reader.result;

                // 썸네일 이미지 생성
                const previewImage = $('<img>').attr('src', dataURL).addClass('thumbnailPreview');
                const deleteButton = $('<div class="imgDeleteBtn">x</div>');

                // 썸네일과 삭제 버튼을 컨테이너에 추가
                const previewWrapper = $('<div class="preview-wrapper"></div>').append(previewImage).append(deleteButton);
                $('.preview-container').append(previewWrapper);

                // 삭제 버튼 클릭 시 썸네일 삭제
                deleteButton.on('click', function () {
                    // 해당 파일 제거
                    for (let i = 0; i < dataTransfer.items.length; i++) {
                        if (dataTransfer.items[i].getAsFile() === file) {
                            dataTransfer.items.remove(i);
                            break;
                        }
                    }
                    previewWrapper.remove();

                    // 파일 목록 업데이트
                    $('#imageUpload')[0].files = dataTransfer.files;
                });
            };

            reader.readAsDataURL(file);
        });
    }
});

if (mode === 'edit') {
    $.getJSON("/getImageList", {item_id: itemId, mode: type}, function (data) {
        // 이미지 데이터가 있는 경우 처리
        if (data && data.length > 0) {
            data.forEach(imageDto => {
                const { uploadPath, uuid, fileName } = imageDto;
                // S3 URL 생성
                const fileUrl = "https://ecoeats-fileupload.s3.ap-northeast-2.amazonaws.com/"
                    + encodeURIComponent(`${uploadPath}/${uuid}_${fileName}`);

                // 이미지 및 삭제 버튼 생성
                const previewImage = $('<img>')
                    .attr('src', fileUrl)
                    .css({maxWidth: '300px', margin: '10px'})
                    .addClass('thumbnailPreview');

                const deleteButton = $('<div class="imgDeleteBtn">x</div>');

                // 썸네일과 삭제 버튼을 묶는 래퍼 생성
                const previewWrapper = $('<div class="preview-wrapper"></div>')
                    .append(previewImage)
                    .append(deleteButton);

                // 프리뷰 컨테이너에 추가
                $('.preview-container').append(previewWrapper);

                deleteButton.on('click', function () {
                    // 해당 파일 제거
                    for (let i = 0; i < dataTransfer.items.length; i++) {
                        if (dataTransfer.items[i].getAsFile() === file) {
                            dataTransfer.items.remove(i);
                            break;
                        }
                    }
                    previewWrapper.remove();

                    // 파일 목록 업데이트
                    $('#imageUpload')[0].files = dataTransfer.files;
                });
            });
        }
    });
}