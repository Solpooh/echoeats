const container = document.getElementById("data-container");
const msg = container.getAttribute("data-msg");
const paging = container.getAttribute("data-paging");
const nonce = container.getAttribute("data-nonce");

// const mode = container.getAttribute("data-mode");
const notice_id = container.getAttribute("data-noticeId");

$(document).ready(function () {
    // URL 쿼리스트링 가져오기
    function getQueryString() {
        let queryString = window.location.search;
        // 쿼리스트링이 없다면 기본값을 추가
        if (!queryString) {
            queryString = '?page=1&pageSize=10'; // 기본값을 추가
        }
        return queryString;
    }

    // 등록하기 버튼 클릭 이벤트
    $('#registerButton').on('click', function () {
        location.href = 'notice_write';
    });

    // 수정하기 버튼 클릭 이벤트 - 이벤트 위임 방식
    $(document).on('click', '#editButton', function () {
        const noticeId = $(this).data('notice_id');
        location.href = `notice_write${getQueryString()}&mode=edit&notice_id=${noticeId}`;
    });

    // 삭제하기 버튼 클릭 이벤트
    $(document).on('click', '#deleteButton', function () {
        const noticeId = $(this).data('notice_id');
        notice_delete(noticeId);
    });

    // 작성 폼 제출 이벤트 핸들러
    $('#noticeForm').on('submit', function (event) {
        if (!saveNotice()) event.preventDefault();
    });

    // 취소 버튼 클릭 이벤트
    $('#cancelButton').on('click', function () {
        location.href = `notice${getQueryString()}`;
    });

    // 등록/수정 버튼 클릭 이벤트
    $('#submitButton').on('click', function () {
        $('#noticeForm').submit();
    });

    // 검색 keyword가 비어있을 경우
    $('#searchForm').on('submit', function(event) {
        const keyword = $('input[name="keyword"]').val().trim(); // 검색어를 가져옴

        if (keyword === "") {  // 검색어가 비어 있으면
            alert("검색어를 입력해 주세요.");  // 경고 메시지 띄우기
            event.preventDefault();  // 폼 제출 막기
        }
    });

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

// 동적으로 click event 거는 방법
$("#thumbnailPreview").on("click", ".imgDeleteBtn", function(e){
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
