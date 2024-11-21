const container = document.getElementById("data-container");
const nonce = container.getAttribute("data-nonce");

$(document).ready(function() {
    // 취소 버튼 클릭 이벤트
    $('#cancelButton').on('click', function () {
        location.href = 'faq';
    });

    // 등록/수정 버튼 클릭 이벤트
    $('#submitButton').on('click', function () {
        $('#faqForm').submit();
    });

    // 작성 폼 제출 이벤트 핸들러
    $('#faqForm').on('submit', function (event) {
        if (!$('#imageUpload')[0].files.length) {
            $('#imageUpload').removeAttr('name');
        }
        if (!saveFaq()) event.preventDefault();
    });


    if (mode === 'edit') {
        // 초기화 함수: 모든 .form-control 요소의 글자 수를 초기화
        $('.form-control').each(function () {
            let content = $(this).val();
            $('#counter').html("(" + content.length + "자 / 2000자)"); // 글자 수 초기화

            if (content.length > 2000) {
                $(this).val(content.substring(0, 2000));
                $('#counter').html("(2000 / 2000자)");
            }
        });
    }
});

$('.form-control').keyup(function (e) {
    let content = $(this).val();
    $('#counter').html("(" + content.length + "자 / 2000자)");    // 글자수 실시간 카운팅

    // 2000자 초과 작성시 2000자로 고정
    if (content.length > 2000) {
        alert("최대 2000자까지 입력 가능합니다.");
        $(this).val(content.substring(0, 2000));
        $('#counter').html("(2000 / 2000자)");
    }
});

function saveFaq() {
    let frm = document.frm;
    let title = frm.faq_title.value.trim();
    let content = frm.faq_con.value.trim();

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
        frm.action = "saveFaq";
        return true;  // 폼을 제출합니다.
    } else {
        return false;  // 폼 제출을 중단합니다.
    }
}