<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="nonce" value="${requestScope.cspNonce}" />

<!-- FAQ 등록/수정 페이지 -->
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FAQ 등록</title>
  <%@ include file="../../include/bootstrap.jspf" %>
  <link rel="stylesheet" href="${contextPath}/resources/product/css/main-css.css" nonce="${nonce}">
  <link rel="stylesheet" href="${contextPath}/resources/board/css/board.css" nonce="${nonce}">
</head>
<body>
<%@ include file="../../include/header.jspf" %>
<div class="container-fluid">
  <div class="row">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
      <div class="main" id="faqMain">
        <h4>FAQ ${mode == "new" ? "등록" : "수정"}</h4>
      </div>
      <form name="frm" method="post" onsubmit="return saveFaq()">
        <table class="table">
          <thead>
          <tr>
            <th class="title-header">제목</th>
            <th class="title-input">
              <input type="hidden" name="mode" value="${mode}">
              <c:if test="${mode == 'edit'}">
              <input type="hidden" name="faq_id" value="${faq.faq_id}">
              </c:if>
              <input class="form-control" type="text" name="faq_title" value="${mode == 'new' ? '' : fn:escapeXml(faq.faq_title)}" />
              <div id="titleMessage"></div> <!-- 제목 검증 메시지 -->
            </th>
          </tr>
          <tr>
            <th class="category-header">카테고리</th>
            <th class="category-input">
              <select class="form-control" name="faq_type">
                <option value="회원">회원</option>
                <option value="주문/결제/대량주문">주문/결제/대량주문</option>
                <option value="배송">배송</option>
                <option value="상품">상품</option>
              </select>
            </th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td class="content-header">내용</td>
            <td>
              <textarea class="form-control" rows="18" id="comment" name="faq_con"><c:out value="${mode == 'new' ? '' : faq.faq_con}" /></textarea>
              <div id="contentMessage"></div> <!-- 내용 검증 메시지 -->
              <span id="counter">(0 /2000자)</span>
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

        <div style="text-align: right;">
          <button class="back_btn" type="button" onclick="location.href='${contextPath}/board/faq'">
            취소
          </button>
          <button class="notice_btn" type="submit" onclick="saveFaq()">
            ${mode == 'new' ? '등록' : '수정'}
          </button>
        </div>
      </form>
    </div>
    <div class="col-sm-2"></div>
  </div>

  <div id="data-container" data-nonce="${nonce}" data-mode="${mode}" data-faqId="${faq.faq_id}"></div>

</div>
</body>

<script src="${contextPath}/resources/board/js/faqCRUD.js" nonce="${nonce}"></script>
<footer>
  <%@ include file="../../include/footer.jspf" %>
</footer>
</html>
