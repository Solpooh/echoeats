const container = document.getElementById("data-container");
const msg = container.getAttribute("data-msg");
const paging = container.getAttribute("data-paging");
const nonce = container.getAttribute("data-nonce");

const mode = container.getAttribute("data-mode");
const notice_id = container.getAttribute("data-noticeId");

$(document).ready(function () {
    if (mode === 'edit') {
        $.getJSON("/getImageList", {item_id: notice_id, mode: "notice"}, function (data) {
            console.log(data);

            let str = "";
            data.forEach((obj, index) => {
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                str += "<div id='result_card'>";
                str += "<img src='/display?fileName=" + fileCallPath + "'>";
                str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
                str += "<input type='hidden' name='imageList[" + index + "].fileName' value='" + obj.fileName + "'>";
                str += "<input type='hidden' name='imageList[" + index + "].uuid' value='" + obj.uuid + "'>";
                str += "<input type='hidden' name='imageList[" + index + "].uploadPath' value='" + obj.uploadPath + "'>";
                str += "</div>";

                $("#uploadResult").append(str);
            })
        });

        // 초기화 함수: 모든 .form-control 요소의 글자 수를 초기화
        $('.form-control').each(function () {
            let content = $(this).val();
            $('#counter').html("(" + content.length + "자 / 3000자)"); // 글자 수 초기화

            if (content.length > 3000) {
                $(this).val(content.substring(0, 3000));
                $('#counter').html("(3000 / 3000자)");
            }
        });
    }
});

$('.form-control').keyup(function (e) {
    let content = $(this).val();
    $('#counter').html("(" + content.length + "자 / 3000자)");    // 글자수 실시간 카운팅

    // 3000자 초과 작성시 3000자로 고정
    if (content.length > 3000) {
        alert("최대 2000자까지 입력 가능합니다.");
        $(this).val(content.substring(0, 3000));
        $('#counter').html("(3000 / 3000자)");
    }
});

function saveNotice() {
    let frm = document.frm;
    let title = frm.notice_title.value.trim();
    let content = frm.notice_con.value.trim();

    // 기존 메시지 초기화
    document.getElementById("titleMessage").innerText = "";
    document.getElementById("contentMessage").innerText = "";

    let isValid = true;

    // 제목이 비어있는 경우
    if (title === "") {
        document.getElementById("titleMessage").innerText = "제목을 입력해주세요.";
        isValid = false;
    }

    // 내용이 비어있는 경우
    if (content === "") {
        document.getElementById("contentMessage").innerText = "내용을 입력해주세요.";
        isValid = false;
    }

    // 검증이 모두 통과되었을 경우에만 폼 제출
    if (isValid) {
        frm.action = "insertNotice";
        return true;  // 폼을 제출합니다.
    } else {
        return false;  // 폼 제출을 중단합니다.
    }
}
// 이미지
let regex = new RegExp("(.*?)\.(jpg|png)$");
let maxSize = 1048576; //1MB
function fileCheck(fileName, fileSize){
    if(fileSize >= maxSize){
        alert("파일 사이즈 초과");
        return false;
    }
    if(!regex.test(fileName)){
        alert("해당 종류의 파일은 업로드할 수 없습니다.");
        return false;
    }
    return true;
}

$("input[type='file']").on("change", function(e) {
    if ($(".imgDeleteBtn").length > 0) {
        deleteFile(); // 필요에 따라 파일 삭제 처리
    }

    let formData = new FormData();
    let fileInput = $('input[name="uploadFile"]');
    let fileList = fileInput[0].files;
    console.log(fileList);

    for (let i = 0; i < fileList.length; i++) {
        formData.append("uploadFile", fileList[i]);
    }

    $.ajax({
        url: '/uploadImage',
        processData: false,
        contentType: false,
        data: formData,
        type: 'POST',
        dataType: 'json',
        success: function(result) {
            console.log(result);
            showUploadImage(result);
        },
        error: function(result) {
            alert("이미지 파일이 아닙니다");
        }
    });
});

function showUploadImage(data) {
    if (!data || data.length === 0) return;

    let uploadResult = $("#uploadResult");
    data.forEach((obj, index) => {
        let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

        let str = "";

        str += "<div id='result_card'>";
        str += "<img src='/display?fileName=" + fileCallPath + "'>";
        str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
        str += "<input type='hidden' name='imageList[" + index + "].fileName' value='" + obj.fileName + "'>";
        str += "<input type='hidden' name='imageList[" + index + "].uuid' value='" + obj.uuid + "'>";
        str += "<input type='hidden' name='imageList[" + index + "].uploadPath' value='" + obj.uploadPath + "'>";
        str += "</div>";

        uploadResult.append(str);
    });
}
// 동적으로 click event 거는 방법
$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
    deleteFile();
});

function deleteFile() {
    $("#result_card").remove();
}

if (msg === "WRT_OK") alert("게시물 등록이 완료되었습니다.");
if (msg === "MOD_OK") alert("게시물 수정이 완료되었습니다.");
if (msg === "DEL_OK") alert("게시물 삭제가 완료되었습니다.");

function notice_delete(id) {
    let frm = document.getElementById('form');
    if (!confirm("정말 삭제하시겠습니까?")) {
        return false;
    } else {
        frm.action = "deleteNotice" + paging + "&notice_id=" + id;
        frm.submit(); // 폼 제출
    }
}
