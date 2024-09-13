<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="today" value="<%= new java.util.Date() %>" />
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>


<!-- 공지사항 관리자 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <link rel="stylesheet" href="${contextPath}/resources/common/css/styles.css">
    <link rel="stylesheet" href="${contextPath}/resources/admin/order/css/orderList.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/board/board.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/board/board2.css">
</head>

<body class="sb-nav-fixed">
<%@ include file="../../include/top_side_nav.jspf" %>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="page-title">전체 공지사항 조회</div>
            <button class="notice_btn" onclick="location.href='<c:url value="notice_write"/>'" type="button">등록하기</button>
            <div class="card">
                <div class="card-body">
                    <form action="<c:url value='/admin/notice'/>" class="form-inline mb-4">
                        <select class="form-control mr-2" name="option">
                            <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
                            <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
                        </select>
                        <input type="text" name="keyword" class="form-control mr-2" <c:out value="${ph.sc.keyword}" />
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
                               href="<c:url value='notice_view?notice_id=${notice.notice_id}&page=${page}&pageSize=${pageSize}'/>">${notice.notice_title}</a>
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
                                        onclick="location.href='<c:url value="notice_write?mode=edit&notice_id=${notice.notice_id}&page=${page}&pageSize=${pageSize}"/>'">수정하기
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
    let msg = "${message}";
    if (msg === "WRT_OK") alert("게시물 등록이 완료되었습니다.");
    if (msg === "MOD_OK") alert("게시물 수정이 완료되었습니다.");
    if (msg === "DEL_OK") alert("게시물 삭제가 완료되었습니다.");

    function notice_delete(notice_id) {
        let frm = document.getElementById('form');
        if (!confirm("정말 삭제하시겠습니까?")) {
            return false;
        } else {
            frm.action = "<c:url value='deleteNotice?notice_id=" + notice_id + "&page=" + ${page} + "&pageSize=" + ${pageSize} + "'/>";
            frm.submit(); // 폼 제출
        }
    }
</script>

</body>

</html>
