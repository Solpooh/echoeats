<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="today" value="<%= new java.util.Date() %>" />

<!-- 공지사항 관리자 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link href="<c:url value='/resources/common/css/styles.css' />" rel="stylesheet"/>
    <link href="<c:url value='/resources/admin/order/css/orderList.css' />" rel="stylesheet"/>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.esm.js"></script>
    <script nomodule src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/themes/default.css"/>
</head>
<style>
    .table {
        width: 100%;
        text-align: center;
        margin-top: -35px;
        margin-bottom: 20px;
    }

    .table th {
        padding: 10px;
        font-size: 11pt;
        vertical-align: middle;
    }

    .table td {
        font-size: 10.5pt;
        height: 55px;
        padding-top: 17px;
        border-bottom: 1px solid lightgray;
    }

    .date {
        color: gray;
    }

    .n_title,
    .n_title:hover {
        text-decoration: none;
        color: black;
    }

    .notice_btn {
        padding: 0px 10px;
        text-align: center;
        overflow: hidden;
        width: 120px;
        height: 44px;
        border-radius: 3px;
        color: rgb(255, 255, 255);
        background-color: #9a30ae;
        border: 0px none;
        font-size: small;
        float: right;
    }

    .notice_btn:hover {
        background-color: #7F208D;
    }

    .search-option > option {
        text-align: center;
    }

    table {
        margin-top: -35px;
    }

    .paging-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 4rem;
    }

    .paging {
        display: flex;
    }

    .page {
        color: black;
        padding: 6px;
        margin-right: 10px;
        font-size: 14px;
    }
    .paging-active {
        background-color: #4CAF50;
        color: white;
    }


    .page-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .col-md-8 {
        margin-top: 20px;
        flex: 0 0 auto;
        width: 80.666667%;
    }

    .card-body {
        text-align: center; /* 추가: 가로 정렬 중앙 정렬 */
    }

    .btn-primary {
        margin-top: 5px; /* 추가: 버튼과 인풋 사이의 간격 조절 */
    }

    .notice_btn {
        padding: 0px 10px;
        text-align: center;
        overflow: hidden;
        width: 120px;
        height: 44px;
        border-radius: 3px;
        color: rgb(255, 255, 255);
        background-color: #4CAF50;
        border: 0px none;
        font-size: small;
        float: right;
        margin-top: -53px;
    }

    .notice_btn:hover {
        background-color: #45a049;
    }

    .modify_btn,
    .delete_btn {
        padding: 0px 5px; /* 크기 조정 */
        text-align: center;
        overflow: hidden;
        width: 80px;
        height: 30px;
        border-radius: 3px;
        font-size: 12px;
        margin-left: 5px; /* 간격 조정 */
    }

    .modify_btn {
        background-color: #4CAF50;
        color: #fff;
    }

    .delete_btn {
        background-color: #9A30AE;
        color: #fff;
    }
</style>

<body class="sb-nav-fixed">
<%@ include file="../../include/top_side_nav.jspf" %>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="page-title">전체 공지사항 조회</div>
            <button class="notice_btn" onclick="location.href='notice_write'" type="button">등록하기</button>
            <div class="card">
                <div class="card-body">
                    <form action="<c:url value="/admin/notice"/>" class="form-inline mb-4">
                        <select class="form-control mr-2" name="option">
                            <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
                            <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
                        </select>
                        <input type="text" name="keyword" class="form-control mr-2" value="${ph.sc.keyword}"
                               placeholder="검색어를 입력해주세요">
                        <button type="submit" class="btn btn-primary">검색</button>
                    </form>
                </div>
            </div>

            <table class="table mt-4">
                <thead>
                <tr>
                    <th style="width: 10%">번호</th>
                    <th>제목</th>
                    <th style="width: 15%">작성자</th>
                    <th style="width: 20%">작성일</th>
                    <th style="width: 10%">작업</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="notice" items="${list}">
                    <c:set var="isToday" value="${fn:substring(today, 0, 10) eq fn:substring(notice.notice_date, 0, 10)}" />
                    <tr>
                        <td>${notice.notice_id}</td>
                        <td>
                            <a class="n_title"
                               href="notice_view?notice_id=${notice.notice_id}&page=${page}&pageSize=${pageSize}">${notice.notice_title}</a>
                        </td>
                        <td>에코잇츠</td>
                        <td class="date">
                            <c:choose>
                                <c:when test="${isToday}">
                                    <fmt:formatDate value="${notice.notice_date}" pattern="HH:mm" />
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatDate value="${notice.notice_date}" pattern="yyyy-MM-dd" />
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form id="form" class="form" method="post">
                            <!-- 수정, 삭제 버튼 -->
                                <button class="modify_btn" type="button"
                                        onclick="location.href='notice_modify?notice_id=${notice.notice_id }&page=${page}&pageSize=${pageSize}'">수정하기
                                </button>
                                <button class="delete_btn" type="button" onclick="notice_delete(${notice.notice_id})">삭제하기</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>


            <div class="paging-container">
                <div class="paging">
                    <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
                        <div>게시물이 없습니다.</div>
                    </c:if>
                    <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                        <c:if test="${ph.showPrev}">
                            <a class="page"
                               href="<c:url value='/admin/notice${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt;</a>
                        </c:if>
                        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                            <a class="page ${i==ph.sc.page? "paging-active" : ""}"
                               href="<c:url value='/admin/notice${ph.sc.getQueryString(i)}'/>">${i}</a>
                        </c:forEach>
                        <c:if test="${ph.showNext}">
                            <a class="page" href="<c:url value='/admin/notice${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt;</a>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function notice_delete(notice_id) {
        let frm = document.getElementById('form');
        if (!confirm("정말 삭제하시겠습니까?")) {
            return false;
        } else {
            frm.action = "deleteNotice?notice_id=" + notice_id + "&page=" + ${page} + "&pageSize=" + ${pageSize};
            frm.submit(); // 폼 제출을 잊지 마세요.
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/resources/common/js/scripts.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-area-demo.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-bar-demo.js' />"></script>
<script src="<c:url value='/resources/common/js/datatables-simple-demo.js' />"></script>
</body>

</html>
