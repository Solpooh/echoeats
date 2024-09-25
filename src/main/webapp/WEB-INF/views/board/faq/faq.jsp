<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- FAQ 사용자 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoEats-FAQ</title>
    <%@ include file="../../include/bootstrap.jspf" %>
    <link rel="stylesheet" href="${contextPath}/resources/product/css/main-css.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/board/board.css">
</head>
<header>
    <%@ include file="../../include/header.jspf" %>
</header>
<body>
<%@ include file="../../include/boardMenu.jspf" %>
        <div class="board"> <!--게시판 (화면 중앙)-->
            <div class="board-top"> <!--게시판 상단1-->
                <div class="board-top-content">
                    <h2 class="Notice1">자주하는 질문
                    <span class="Notice2">고객님들께서 가장 자주하시는 질문을 모두 모았습니다.</span>
                        <div id="option" class="dropdown" style="width: 260px; border-radius: 0; padding-bottom: 0.5cm; padding-left: 110px; float: right" >
                            <select name="category" class="form-control">
                                <option value="전체" selected="selected">전체</option>
                                <option value="회원">회원</option>
                                <option value="주문/결제/대량주문">주문/결제/대량주문</option>
                                <option value="배송">배송</option>
                                <option value="상품">상품</option>
                            </select>
                        </div>
                    </h2>
                </div>
            </div>
            <div class="css-e23nfx e16adls21"> <!--게시판 상단2-->
                <div width="70" class="css-hyfxhw e16adls20">번호</div>
                <div width="135" class="css-1cn1979 e16adls20">카테고리</div>
                <div class="css-1ym8aqm e16adls20">제목</div>
            </div>
            <!-- ajax로 데이터를 전달할 공간 -->
            <div class="faq_a">
                <div id="accordion">
                    <div class="card" id="type_faq">

                    </div>
                </div>
            </div>
            <div class="board-footer"> <!--게시판 하단-->
                <div class="board-footer-button">
                    <button type="button" class="left-button">이전</button>
                    <button type="button" class="right-button">다음</button>
                </div>
            </div>

            <sec:authorize access="hasAuthority('ADMIN')">
                <button class="faq_btn" type="button" onclick="location.href='faq_write'">등록하기</button>
            </sec:authorize>
        </div>
    </div>
</div>
<!-- JavaScript -->
<script>
    let msg = "${message}";
    if (msg === "WRT_OK") alert("게시물 등록이 완료되었습니다.");
    if (msg === "MOD_OK") alert("게시물 수정이 완료되었습니다.");

    let userRole = '<sec:authorize access="hasAuthority('ADMIN')">ADMIN</sec:authorize>';

    const pageSize = 10;
    let page = 1;
    let totalCnt;
    let totalPage;

    $(document).ready(function(e) {
        getFaqList();
        let leftBtn = $('.left-button');
        let rightBtn = $('.right-button');

        // 다음 버튼 클릭 시 페이지를 증가시키고 FAQ 목록을 다시 가져옴
        rightBtn.click(function() {
            if (totalPage > page) page++;
            getFaqList(); // FAQ 목록 다시 가져오기

            leftBtn.prop('disabled', false); // 다음 페이지로 이동했으므로 왼쪽 버튼 활성화
        });

        // 이전 버튼 클릭 시 페이지를 감소시키고 FAQ 목록을 다시 가져옴
        leftBtn.click(function() {
            if (page > 0) page--; // 페이지 감소
            getFaqList(); // FAQ 목록 다시 가져오기
            if (page === 1) {
                leftBtn.prop('disabled', true); // 페이지가 1이면 왼쪽 버튼 비활성화
            }
        });
    });

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

    // FAQ 목록 비동기적으로 가져오기 -> AJAX 이용하여 서버에 요청, 받아와서 화면에 출력
    function getFaqList() {
        let dataSend = {
            faq_type: $("select[name=category]").val(), // 선택된 카테고리 가져옴.
            page: page,
            pageSize: pageSize,
        };

        $.ajax({
            type: "POST",
            data: JSON.stringify(dataSend),
            url: "/board/list",
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            // 콜백함수 -> 성공시 받은 데이터를 이용하여 FAQ 목록을 동적으로 생성하여 화면에 출력
            success: function (data) {
                console.log(data);
                let faqList = data['faqList'];

                if (faqList.length === 0) {
                    alert("게시물이 없습니다.");
                    return; // 호출 중단
                }
                totalCnt = data['totalCnt'];
                totalPage = data['totalPage'];

                // displayData 변수에 HTML 코드 문자열로 누적
                let displayData = "";

                // for 루프를 통해 서버에서 받아온 FAQ 데이터 순회하며 HTML 코드 생성
                for (let FaqDto of faqList) {
                    // FAQ 세부 내용을 접을 수 있는 collapse -> BootStrap 사용
                    displayData += "<div class='card-header'>";
                    displayData += "<a class='card-link' data-toggle='collapse' href='#collapseOne" + FaqDto.faq_id + "'>";
                    if (dataSend.faq_type === '전체') {
                        displayData += "<span style='width: 75px; display: inline-block;'>" + FaqDto.faq_id + "</span>";
                    } else {
                        displayData += "<span style='width: 75px; display: inline-block;'>" + FaqDto.rownum + "</span>";
                    }                    displayData += "<span style='width: 150px; display: inline-block;' class='" + FaqDto.faq_type + "'>" + FaqDto.faq_type + "</span>";
                    displayData += "<span style='width: 840px; display: inline;'>" + FaqDto.faq_title + "</span></a>";
                    displayData += "</div>";
                    displayData += "<div id='collapseOne" + FaqDto.faq_id + "' class='collapse' data-parent='#accordion'>";
                    displayData += "<div class='card-body'>";
                    displayData += "<div class='card_answer'>";

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
                        displayData += "<div style='text-align: right;'>";
                        displayData += "<a href='faq_write?mode=edit&faq_id=" + FaqDto.faq_id + "' style='font-size:9pt; color: darkgray; text-decoration: none;'>수정 |</a>";
                        displayData += "<a onclick='faq_delete(" + FaqDto.faq_id + ")' style='font-size:9pt; color: red; text-decoration: none;'> 삭제</a>";
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
    // 카테고리가 변경(새롭게 선택)될 때마다 change 이벤트 발생
    $("select[name=category]").change(function(){
        page = 1;
        getFaqList();
    });

</script>
</body>
<footer>
    <%@ include file="../../include/footer.jspf" %>
</footer>
</html>