<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- FAQ 등록/수정 페이지 -->
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FAQ 등록</title>
  <%@ include file="../../include/bootstrap.jspf" %>
  <link rel="stylesheet" href="${contextPath}/resources/product/css/main-css.css">
  <link rel="stylesheet" href="${contextPath}/resources/css/board/board.css">
  <style>
    .main {
      text-align: center;
    }
  </style>
</head>
<body>
<%@ include file="../../include/header.jspf" %>
<div class="container-fluid">
  <div class="row" style="padding-top:50px; padding-bottom: 50px">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
      <div class="main" style="border-bottom:2px solid black">
        <h4>FAQ ${mode == "new" ? "등록" : "수정"}</h4>
      </div>
      <form name="frm" method="post" onsubmit="return saveFaq()">
        <table class="table">
          <thead>
          <tr style="height: 60px;">
            <th style="width: 10%; vertical-align: middle; border-color: white;">제목</th>
            <th style="vertical-align: middle; border-bottom-color: white;">
              <input type="hidden" name="mode" value="${mode}">
              <c:if test="${mode == 'edit'}">
              <input type="hidden" name="faq_id" value="${faq.faq_id}">
              </c:if>
              <input type="text" class="title" name="faq_title" value="${mode == 'new' ? '' : faq.faq_title}">
              <div id="titleMessage" style="color: red;"></div> <!-- 제목 검증 메시지 -->
            </th>
          </tr>
          <tr>
            <th style="white-space: nowrap; width: 10%; vertical-align: middle; border-color: white; font-size: 15px">카테고리</th>
            <th style="vertical-align: middle; border-bottom-color: white;">
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
            <td style="font-weight: bolder;">내용</td>
            <td>
              <textarea class="form-control" rows="18" id="comment" name="faq_con">${mode == 'new' ? '' : faq.faq_con}</textarea>
              <div id="contentMessage" style="color: red;"></div> <!-- 내용 검증 메시지 -->
              <span style="color:#aaa; float: right;" id="counter">(0 /2000자)</span>
            </td>
          </tr>
          </tbody>
        </table>
        <!-- 이미지 input 추가 -->
        <div class="form-section">
          <div class="form_section_title">
            <label></label>
            <div class="form-section-content">
              <input type="file" id="fileItem" name="uploadFile" style="height: 30px;" multiple>
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
</div>
<%@ include file="../../include/footer.jspf" %>
<script>
  $(document).ready(function() {
    <c:if test="${mode == 'edit'}">
      let item_id = '<c:out value="${faq.faq_id}"/>';
      let uploadResult = $("#uploadResult");
      $.getJSON("/getImageList", {item_id: item_id, mode: "faq"}, function (data) {
        console.log(data);

        let str = "";
        data.forEach((obj, index) => {
        let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
          str += "<div id='result_card'>";
          str += "<img src='/display?fileName=" + fileCallPath + "'>";
          str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
          str += "<input type='hidden' name='imageList[" + index + "].fileName' value='" + obj.fileName + "'>";
          str += "<input type='hidden' name='imageList[" + index + "].uuid' value='" + obj.uuid + "'>";
          str += "<input type='hidden' name='imageList[" + index + "].uploadPath' value='" + obj.uploadPath + "'>";
          str += "</div>";

          uploadResult.append(str);
        })
      });

    // 초기화 함수: 모든 .form-control 요소의 글자 수를 초기화
    $('.form-control').each(function () {
      let content = $(this).val();
      $('#counter').html("(" + content.length + "자 / 2000자)"); // 글자 수 초기화

      if (content.length > 2000) {
        $(this).val(content.substring(0, 2000));
        $('#counter').html("(2000 / 2000자)");
      }
    });
    </c:if>
  })

  $('.form-control').keyup(function (e) {
    let content = $(this).val();
    $('#counter').html("(" + content.length + "자 / 2000자)");    //글자수 실시간 카운팅

    if (content.length > 2000) {
      alert("최대 2000자까지 입력 가능합니다.");
      $(this).val(content.substring(0, 2000));
      $('#counter').html("(2000 / 2000자)");
    }
  });

  function saveFaq() {
    let frm = document.frm;
    let title = frm.faq_title.value.trim();
    let content = frm.faq_con.value.trim();

    // 기존 메시지 초기화
    document.getElementById("titleMessage").innerText = "";
    document.getElementById("contentMessage").innerText = "";

    let isValid = true;

    // 제목이 비어있는 경우
    if (title === "") {
      document.getElementById("titleMessage").innerText = "제목을 입력해주세요.";
      isValid = false;
    }

    // 내용이 비어있는 경우
    if (content === "") {
      document.getElementById("contentMessage").innerText = "내용을 입력해주세요.";
      isValid = false;
    }

    // 검증이 모두 통과되었을 경우에만 폼 제출
    if (isValid) {
      frm.action = "saveFaq";
      return true;  // 폼을 제출합니다.
    } else {
      return false;  // 폼 제출을 중단합니다.
    }
  }

  let regex = new RegExp("(.*?)\.(jpg|png)$");
  let maxSize = 1048576; //1MB

  function fileCheck(fileName, fileSize){
    if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
    }
    if(!regex.test(fileName)){
      alert("해당 종류의 파일은 업로드할 수 없습니다.");
      return false;
    }
    return true;
  }

  $("input[type='file']").on("change", function(e) {
    if ($(".imgDeleteBtn").length > 0) {
      deleteFile(); // 필요에 따라 파일 삭제 처리
    }

    let formData = new FormData();
    let fileInput = $('input[name="uploadFile"]');
    let fileList = fileInput[0].files;
    console.log(fileList);

    for (let i = 0; i < fileList.length; i++) {
      formData.append("uploadFile", fileList[i]);
    }

    $.ajax({
      url: '/uploadImage',
      processData: false,
      contentType: false,
      data: formData,
      type: 'POST',
      dataType: 'json',
      success: function(result) {
        console.log(result);
        showUploadImage(result);
      },
      error: function(result) {
        alert("이미지 파일이 아닙니다");
      }
    });
  });

  function showUploadImage(data) {
    if (!data || data.length === 0) return;

    let uploadResult = $("#uploadResult");
    data.forEach((obj, index) => {
      let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

      let str = "";

      str += "<div id='result_card'>";
      str += "<img src='/display?fileName=" + fileCallPath + "'>";
      str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
      str += "<input type='hidden' name='imageList[" + index + "].fileName' value='" + obj.fileName + "'>";
      str += "<input type='hidden' name='imageList[" + index + "].uuid' value='" + obj.uuid + "'>";
      str += "<input type='hidden' name='imageList[" + index + "].uploadPath' value='" + obj.uploadPath + "'>";
      str += "</div>";

      uploadResult.append(str);
    });
  }
  // 동적으로 click event 거는 방법
  $("#uploadResult").on("click", ".imgDeleteBtn", function(e){
    deleteFile();
  });

  function deleteFile() {
    $("#result_card").remove();
  }

</script>
</html>
