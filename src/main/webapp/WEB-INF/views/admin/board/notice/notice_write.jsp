<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="nonce" value="${requestScope.cspNonce}" />

<!-- 공지사항 관리자 등록 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="${contextPath}/resources/common/css/styles.css" nonce="${nonce}"/>
    <link rel="stylesheet" href="${contextPath}/resources/admin/order/css/orderList.css" nonce="${nonce}"/>
    <link rel="stylesheet" href="${contextPath}/resources/board/css/board.css" nonce="${nonce}"/>
</head>
<body class="sb-nav-fixed">
<%@ include file="../../include/top_side_nav.jspf" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-6">
            <div class="main">
                <h4>공지사항 ${mode == 'new' ? '작성' : '수정'}
                    <span> 에코잇츠의 새로운 소식들과 유용한 정보들을 ${mode == 'new' ? '등록' : '수정'}하세요</span>
                </h4>
            </div>
            <div>
                <form name="frm" method="post" onsubmit="return saveNotice()">
                    <table class="table">
                        <thead>
                        <tr>
                            <th style="width: 10%">제목</th>
                            <th>
                                <input type="hidden" name="mode" value="<c:out value='${mode}'/>">
                                <c:if test="${mode == 'edit'}">
                                    <input type="hidden" name="notice_id" value="<c:out value='${notice.notice_id}'/>">
                                    <input type="hidden" name="page" value="<c:out value='${sc.page}'/>">
                                    <input type="hidden" name="pageSize" value="<c:out value='${sc.pageSize}'/>">
                                </c:if>
                                <input type="text" class="form-control" name="notice_title" value="${mode == 'new' ? '' : fn:escapeXml(notice.notice_title)}">
                                <div id="titleMessage"></div> <!-- 제목 검증 메시지 -->
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="font-weight: bolder">내용</td>
                            <td>
                                <textarea class="form-control" rows="18" id="content" name="notice_con"><c:out value="${mode == 'new' ? '' : notice.notice_con}"/></textarea>
                                <div id="contentMessage"></div> <!-- 내용 검증 메시지 -->
                                <span id="counter">(0 /3000자)</span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <!-- 이미지 input 추가 -->
                    <div class="form-section">
                        <div class="form_section_title">
                            <label></label>
                            <div class="form-section-content">
                                <input type="file" id="fileItem" name="uploadFile" multiple>
                                <div id="uploadResult">

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- -->
                    <div class="submit_btn">
                        <button class="back_btn" type="button" onclick="location.href='<c:url value="notice${sc.getQueryString()}"/>'">취소</button>
                        <button class="notice_btn" type="submit" onclick="saveNotice()">
                            ${mode == 'new' ? '등록' : '수정'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div id="data-container" data-nonce="${nonce}" data-mode="${mode}" data-noticeId="${notice.notice_id}"></div>

</div>

<script src="${contextPath}/resources/board/js/noticeCRUD.js" nonce="${nonce}"></script>

</body>
</html>
