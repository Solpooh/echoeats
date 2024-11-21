<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="nonce" value="${requestScope.cspNonce}" />

<!-- FAQ 사용자 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoEats-FAQ</title>
    <%@ include file="../../include/bootstrap.jspf" %>
    <link rel="stylesheet" href="${contextPath}/resources/product/css/main-css.css" nonce="${nonce}">
    <link rel="stylesheet" href="${contextPath}/resources/board/css/board.css" nonce="${nonce}">
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
                        <div id="option" class="dropdown">
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
                <button class="faq_btn" type="button" id="registerButton">등록하기</button>
            </sec:authorize>

            <div id="data-container" data-nonce="${nonce}" data-msg="${message}" data-role='<sec:authorize access="hasAuthority('ADMIN')">ADMIN</sec:authorize>'></div>

        </div>
    </div>
</div>
</body>

<script src="${contextPath}/resources/board/js/faqList.js" nonce="${nonce}"></script>
<footer>
    <%@ include file="../../include/footer.jspf" %>
</footer>
</html>