let page = 1;
let totalPage;
const pageSize = 10;

const container = document.getElementById("data-container");
const msg = container.getAttribute("data-msg");
const userRole = container.getAttribute("data-role");
const nonce = container.getAttribute("data-nonce");

$(document).ready(function (e) {
    getFaqList();
    let leftBtn = $('.left-button');
    let rightBtn = $('.right-button');

    // 이전 버튼 클릭 시 페이지를 감소시키고 FAQ 목록을 다시 가져옴
    leftBtn.click(function() {
        if (page > 1) {
            page--; // 페이지 감소
            getFaqList();
        }
        if (page === 1) {
            leftBtn.prop('disabled', true); // 첫 페이지로 돌아오면 왼쪽 버튼 비활성화
        }
    });

    // 다음 버튼 클릭 시 페이지를 증가시키고 FAQ 목록을 다시 가져옴
    rightBtn.click(function() {
        if (page < totalPage) page++;
        getFaqList(); // FAQ 목록 다시 가져오기

        leftBtn.prop('disabled', false); // 다음 페이지로 이동했으므로 왼쪽 버튼 활성화
    });

    // 왼쪽 버튼은 첫 페이지에서는 비활성화
    if (page === 1) {
        leftBtn.prop('disabled', true);
    }
});

// FAQ 목록 비동기적으로 가져오기 -> AJAX 이용하여 서버에 요청, 받아와서 화면에 출력
function getFaqList() {
    console.log(page);
    console.log(nonce)

    let dataSend = {
        faqDto: {
            faq_type: $("select[name=category]").val()
        },
        searchBoardCondition: {
            page: page,
            pageSize: pageSize
        }
    };

    $.ajax({
        type: "POST",
        data: JSON.stringify(dataSend),
        url: "/board/list",
        dataType: "json",
        contentType: "application/json; charset=utf-8",

        // 콜백함수 -> 성공시 받은 데이터를 이용하여 FAQ 목록을 동적으로 생성하여 화면에 출력
        success: function (data) {
            console.log(data)
            let faqList = data['faqList'];
            totalPage = data['pageHandler'].totalPage; // 서버에서 받은 총 페이지 수
            if (faqList.length === 0) {
                alert("보여줄 게시물이 없습니다.");
                return; // 호출 중단
            }

            // displayData 변수에 HTML 코드 문자열로 누적
            let displayData = "";

            // for 루프를 통해 서버에서 받아온 FAQ 데이터 순회하며 HTML 코드 생성
            for (let FaqDto of faqList) {
                // FAQ 세부 내용을 접을 수 있는 collapse -> BootStrap 사용
                displayData += "<div class='card-header' nonce='" + nonce + "'>";
                displayData += "<a class='card-link' data-toggle='collapse' href='#collapseOne" + FaqDto.faq_id + "' nonce='" + nonce + "'>";
                if (dataSend['faqDto'].faq_type === '전체') {
                    displayData += "<span style='width: 75px; display: inline-block;' nonce='" + nonce + "'>" + FaqDto.faq_id + "</span>";
                } else {
                    displayData += "<span style='width: 75px; display: inline-block;' nonce='" + nonce + "'>" + FaqDto.rowNum + "</span>";
                }
                displayData += "<span style='width: 150px; display: inline-block;' class='" + FaqDto.faq_type + "' nonce='" + nonce + "'>" + FaqDto.faq_type + "</span>";
                displayData += "<span style='width: 840px; display: inline;' nonce='" + nonce + "'>" + FaqDto.faq_title + "</span></a>";
                displayData += "</div>";
                displayData += "<div id='collapseOne" + FaqDto.faq_id + "' class='collapse' data-parent='#accordion' nonce='" + nonce + "'>";
                displayData += "<div class='card-body' nonce='" + nonce + "'>";
                displayData += "<div class='card_answer' nonce='" + nonce + "'>";

                // 이미지가 있는 경우 이미지를 추가
                if (FaqDto.imageList && FaqDto.imageList.length > 0) {
                    for (let image of FaqDto.imageList) {
                        let fileCallPath = encodeURIComponent(image.uploadPath + "/s_" + image.uuid + "_" + image.fileName);
                        displayData += "<img src='/display?fileName=" + fileCallPath + "'>";
                    }
                    displayData += "<br/><br/>"
                }
                displayData += FaqDto.faq_con
                displayData += "</div>";

                if (userRole === 'ADMIN') {
                    displayData += "<div style='text-align: right;' nonce='" + nonce + "'>";
                    displayData += "<a href='faq_write?mode=edit&faq_id=" + FaqDto.faq_id + "' style='font-size:9pt; color: darkgray; text-decoration: none;' nonce='" + nonce + "'>수정 |</a>";
                    displayData += "<a onclick='faq_delete(" + FaqDto.faq_id + ")' style='font-size:9pt; color: red; text-decoration: none;' nonce='" + nonce + "'> 삭제</a>";
                    displayData += "</div>";
                }

                displayData += "</div></div>";

            }

            // FAQ 목록은 id= #type_faq 엘리먼트에 추가
            $("#type_faq").html(displayData);
        },

        // 콜백함수 -> 실패 시 경고창 출력
        error: function () {
            alert("실패했습니다. 개발자도구를 통해 오류를 확인하세요.");
        }
    });
}

if (msg === "WRT_OK") alert("게시물 등록이 완료되었습니다.");
if (msg === "MOD_OK") alert("게시물 수정이 완료되었습니다.");

function faq_delete(faq_id) {
    if (!confirm("정말 삭제하시겠습니까??")) return;
    alert("삭제가 완료되었습니다");

    let dataSend = {
        faq_id: faq_id
    };

    $.ajax({
        type: "POST",
        url: "/board/deleteFaq",
        data: JSON.stringify(dataSend),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            // 삭제가 성공하면 화면을 업데이트합니다.
            // 여기서는 새로운 게시물 목록을 가져오는 함수를 호출합니다.
            console.log(data);
            getFaqList();
        },

        error: function () {
            alert("불러오기 실패")
        }
    });
}

// 카테고리가 변경(새롭게 선택)될 때마다 change 이벤트 발생
$("select[name=category]").change(function(){
    page = 1;
    getFaqList();
});
