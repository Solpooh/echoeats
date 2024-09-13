<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:scriptlet> pageContext.setAttribute("newline", "\n"); </jsp:scriptlet>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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
  <link rel="stylesheet" href="${contextPath}/resources/product/css/main-css.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/board/board.css">
  <style>
    .main {
      text-align: center;
    }
  </style>
</head>
<body>
<div class="container-fluid">
  <div class="row" style="padding-top:50px; padding-bottom: 50px">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
      <div class="main" style="border-bottom:2px solid black">
        <h4>공지사항 </h4>
        <p style="color: darkgrey; font-weight: bolder;"> 에코잇츠의 새로운 소식들과 유용한 정보들을 한곳에서 확인하세요</p>
      </div>
      <div>
        <table class="table">
          <tbody>
          <tr>
            <td class="tbody_td" style="width: 10%; background-color: #4CAF50; vertical-align: middle; text-align: left; padding-left: 20px;">
              제목</td>
            <td style="text-align: left; vertical-align: middle; letter-spacing: -1px; padding-left: 20px;">
              <c:out value="${notice.notice_title}"/></td>
          </tr>
          <tr>
            <td class="tbody_td" style="width: 10%; background-color: #4CAF50; vertical-align: middle; text-align: left; padding-left: 20px;">
              작성자</td>
            <td style="text-align: left; vertical-align: middle; letter-spacing: -1px; padding-left: 20px;">
              에코잇츠</td>
          </tr>
          <tr>
            <td class="tbody_td" style="width: 10%; background-color: #4CAF50; vertical-align: middle; text-align: left; padding-left: 20px;">
              작성일</td>
            <td class="date"style="text-align: left; vertical-align: middle; letter-spacing: -1px; padding-left: 20px;">
              <fmt:formatDate value="${notice.notice_date}" pattern="yyyy-MM-dd HH:mm" /></td>
          </tr>
          </tbody>
          <tfoot>

          <tr style="border-top: 2px solid #FEF7FF;">
            <td colspan="2" style="padding-top: 25px; padding-bottom: 50px; height: 350px;" >
              <%--이미지가 있으면 이미지 출력--%>
              <c:if test="${not empty notice.imageList}">
                <c:forEach var="image" items="${notice.imageList}">
                  <c:url var="fileCallPath" value="/display">
                    <c:param name="fileName" value="${image.uploadPath}/${image.uuid}_${image.fileName}" />
                  </c:url>
                  <img src="<c:out value='${fileCallPath}'/>" alt="Notice Image">
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
      <button class="list_btn" type="button" onclick="location.href='<c:url value='/board/notice?page=${page}&pageSize=${pageSize}'/>'">목록</button>
    </div>
  </div>
  <div class="col-sm-2"></div>
</div>
</body>
<footer>
  <%@ include file="../../include/footer.jspf" %>
</footer>
</html>
