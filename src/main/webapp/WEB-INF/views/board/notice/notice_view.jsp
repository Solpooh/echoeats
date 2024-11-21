<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:scriptlet> pageContext.setAttribute("newline", "\n"); </jsp:scriptlet>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="nonce" value="${requestScope.cspNonce}" />


<!-- 공지사항 상세 조회 페이지 -->
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>공지사항 - 컬리</title>
  <%@ include file="../../include/bootstrap.jspf" %>
  <header>
    <%@ include file="../../include/header.jspf" %>
  </header>
  <link rel="stylesheet" href="${contextPath}/resources/product/css/main-css.css" nonce="${nonce}">
  <link rel="stylesheet" href="${contextPath}/resources/board/css/board.css" nonce="${nonce}">
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
      <div class="main" style="text-align: center" nonce="${nonce}">
        <h4>공지사항 </h4>
        <p> 에코잇츠의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요</p>
      </div>
      <div>
        <table class="table">
          <tbody>
          <tr>
            <td class="tbody_td">
              제목</td>
            <td class="tbody_val" nonce="${nonce}">
              <c:out value="${notice.notice_title}"/></td>
          </tr>
          <tr>
            <td class="tbody_td">
              작성자</td>
            <td class="tbody_val" nonce="${nonce}">
              에코잇츠</td>
          </tr>
          <tr>
            <td class="tbody_td">
              작성일</td>
            <td class="tbody_val">
              <fmt:formatDate value="${notice.notice_date}" pattern="yyyy-MM-dd HH:mm" /></td>
          </tr>
          </tbody>
          <tfoot>

          <tr>
            <td colspan="2" style="padding-top: 25px; padding-bottom: 50px; height: 350px;" nonce="${nonce}">
              <%-- 이미지가 있으면 S3 URL로 이미지 출력 --%>
              <c:if test="${not empty notice.imageList}">
                <c:forEach var="image" items="${notice.imageList}">
                  <%-- S3 객체 URL을 동적으로 생성 --%>
                  <c:set var="fileCallPath" value="https://ecoeats-fileupload.s3.ap-northeast-2.amazonaws.com/${image.uploadPath}/${image.uuid}_${image.fileName}" />
                  <img src="${fileCallPath}" alt="Notice Image" style="max-width: 300px; margin: 10px;">
                </c:forEach>
                <br/><br/>
              </c:if>


            <%--내용 출력--%>
              <c:out value="${fn:replace(notice.notice_con, newline, '<br>')}" escapeXml="false"/>
            </td>
          </tr>
          </tfoot>
        </table>
      </div>
      <button class="list_btn" type="button" id="listButton">목록</button>
    </div>
  </div>
  <div class="col-sm-2"></div>
</div>

<script src="${contextPath}/resources/board/js/noticeList.js" nonce="${nonce}"></script>

</body>
<footer>
  <%@ include file="../../include/footer.jspf" %>
</footer>
</html>
