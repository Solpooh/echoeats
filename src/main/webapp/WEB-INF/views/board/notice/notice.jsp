<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="today" value="<%= new java.util.Date() %>" />

<!-- 공지사항 사용자 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 - 에코잇츠</title>
    <%@ include file="../../include/bootstrap.jspf" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/product/css/main-css.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/board.css">
</head>
<body>
<header>
    <%@ include file="../../include/header.jspf" %>
</header>
<%@ include file="../../include/boardMenu.jspf" %>
<div class="board"> <!--게시판 (화면 중앙)-->
    <div class="board-top"> <!--게시판 상단1-->
        <div class="board-top-content">
            <h2 class="Notice1">공지사항</h2>
            <span class="Notice2">컬리의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요.</span>
        </div>
    </div>
    <div style="text-align:center">
        <div class="board-container">
            <div class="search-container">
                <form action="<c:url value="/board/notice"/>" class="search-form">
                    <select class="search-option" name="option">
                        <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
                        <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
                    </select>

                    <input type="text" name="keyword" class="search-input" value="${ph.sc.keyword}"
                           placeholder="검색어를 입력해주세요">
                    <input type="submit" class="search-button" value="검색">
                </form>
            </div>
        </div>
        <div>
            <table class="table">
                <thead>
                <tr style="height: 60px">
                    <th style="width: 10%; vertical-align: middle; border-top: 1px solid #4CAF50; border-bottom: 1px solid #4CAF50;">
                        번호
                    </th>
                    <th style="vertical-align: middle; border-top: 1px solid #4CAF50; border-bottom: 1px solid #4CAF50;">
                        제목
                    </th>
                    <th style="width: 15%; vertical-align: middle; border-top: 1px solid #4CAF50; border-bottom: 1px solid #4CAF50;">
                        작성자
                    </th>
                    <th style="width: 20%; vertical-align: middle; border-top: 1px solid #4CAF50; border-bottom: 1px solid #4CAF50;">
                        작성일
                    </th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="notice" items="${list}">
                    <c:set var="isToday" value="${fn:substring(today, 0, 10) eq fn:substring(notice.notice_date, 0, 10)}" />
                    <tr>
                        <td>${notice.notice_id }</td>
                        <td>
                            <a class="n_title"
                               href="notice_view?notice_id=${notice.notice_id}&page=${page}&pageSize=${pageSize}">${notice.notice_title }</a>
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
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <br>
            <div class="paging-container">
                <div class="paging">
                    <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
                        <div>게시물이 없습니다.</div>
                    </c:if>
                    <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                        <c:if test="${ph.showPrev}">
                            <a class="page"
                               href="<c:url value='/board/notice${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt;</a>
                        </c:if>
                        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                            <a class="page ${i==ph.sc.page? "paging-active" : ""}"
                               href="<c:url value='/board/notice${ph.sc.getQueryString(i)}'/>">${i}</a>
                        </c:forEach>
                        <c:if test="${ph.showNext}">
                            <a class="page" href="<c:url value='/board/notice${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt;</a>
                        </c:if>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<footer>
    <%@ include file="../../include/footer.jspf" %>
</footer>
</body>
</html>