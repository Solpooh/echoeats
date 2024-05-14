<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- FAQ 등록 페이지 -->
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EcoEats-FAQ 등록</title>
  <%@ include file="../include/bootstrap.jspf" %>
  <link rel="stylesheet" href="/resources/product/css/main-css.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/projectPratice.css">
  <style>
  </style>
</head>
<header>
  <%@ include file="../include/header.jspf" %>
</header>
<body>
<%--<%@ include file="../include/boardMenu.jspf" %>--%>
<div class="container-fluid">
  <div class="row" style="padding-top:50px; padding-bottom: 50px">
    <div class="col-sm-2"></div>
    <div class="col-sm-2">
    </div>
    <div class="col-sm-6">
      <div class="main" style="border-bottom:2px solid black">
        <h4>자주하는 질문 등록</h4>
      </div>
      <div>
        <form name="frm" method="post" action="${pageContext.request.contextPath}/board/insertFaq">
          <table class="table">
            <thead>
            <tr style="height: 60px;">
              <th style="width: 10%; vertical-align: middle; border-color: white;">제목</th>
              <th style="vertical-align: middle; border-bottom-color: white;">
                <input type="text" class="title" name="faq_title" placeholder=" 제목을 입력하세요.">
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
                <textarea class="form-control" rows="18" id="comment" name="faq_con" placeholder="내용을 입력하세요.">
                </textarea>
                <span style="color:#aaa; float: right;" id="counter">(0 /2000자)</span>
              </td>
            </tr>
            </tbody>
          </table>
          <div class="form-section">
            <div class="form_section_title">
              <label></label>
              <div class="form-section-content">
                <input type="file" id="fileItem" name="uploadFile" style="height: 30px;" multiple>
                <div id="uploadResult">
<%--                  <div id="result_card">--%>
<%--                    <div class="imgDeleteBtn">x</div>--%>
<%--                    <img src="/board/display?fileName=test.png">--%>
<%--                  </div>--%>
                </div>
              </div>
            </div>
          </div>
          <div style="text-align: right;">
            <button class="back_btn" type="button" onclick="location.href='${pageContext.request.contextPath}/board/faq_admin'">취소</button>
            <button class="notice_btn" type="submit" onclick="check_faq()">등록</button>
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="col-sm-2"></div>
</div>
</body>
<footer>
    <%@ include file="../include/footer.jspf" %>
</footer>
<script>
  //textarea 글자수 제한
  $('.form-control').keyup(function (e) {
    let content = $(this).val();
    $('#counter').html("(" + content.length + "자 / 2000자)");    //글자수 실시간 카운팅

    if (content.length > 2000) {
      alert("최대 2000자까지 입력 가능합니다.");
      $(this).val(content.substring(0, 2000));
      $('#counter').html("(2000 / 2000자)");
    }
  });

  //제목,내용 미입력시 알림
  function check_faq() {
      event.preventDefault();

      let frm = document.frm;

      if (frm.faq_title.value.trim() === "" || frm.faq_con.value.trim() === "") {
          if (frm.faq_title.value.trim() === "") {
              alert("제목을 입력해주세요.");
          } else if (frm.faq_con.value.trim() === "") {
              alert("내용을 입력해주세요.");
          }
      } else {
          frm.action = "insertFaq";
          frm.submit();
      }
  }

  // 파일 등록
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
    /* 이미지 존재시 삭제 => 근데 나 여러개 이미지 올릴건데?? 고민해보자 */
    if($(".imgDeleteBtn").length > 0){
      deleteFile();
    }

    let formData = new FormData(); // 가상의 <form> 태그, 서버로 첨부파일 전송위해 (화면이동 없이)
    let fileInput = $('input[name="uploadFile"]');
    // fileList객체 = input 태그의 files속성으로 얻음
    let fileList = fileInput[0].files;
    let fileObj = fileList[0];

    // if (!fileCheck(fileObj.name, fileObj.size)) {
    //   return false;
    // }
    for (let i = 0; i < fileList.length; i++) {
      formData.append("uploadFile", fileList[i]);
    }


    $.ajax({
      url: '/board/uploadAjaxAction',
      processData: false,
      contentType: false,
      data: formData,
      type: 'POST',
      dataType: 'json',
      success: function (result) {
        console.log(result);
        showUploadImage(result);
      },
      error : function(result){
        alert("이미지 파일이 아닙니다");
      }
    });
  });

  function showUploadImage(data) { // data에는 여러 이미지에 대한 dto값들이 담겨있음
    if (!data || data.length === 0) return;

    let uploadResult = $("#uploadResult");
    let obj = data[0];
    let str = "";
    let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

    str += "<div id='result_card'>";
    str += "<img src='/board/display?fileName=" + fileCallPath +"'>";
    str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
    str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
    str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
    str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
    str += "</div>";

    uploadResult.append(str);
  }

  /* 이미지 삭제 버튼 동작 */
  $("#uploadResult").on("click", ".imgDeleteBtn", function(e){

    deleteFile();

  });

  /* 파일 삭제 메서드 */
  function deleteFile(){
    let targetFile = $(".imgDeleteBtn").data("file");

    let targetDiv = $("#result_card, #uploadImages");

    $.ajax({
      url: '/board/deleteFile',
      data : {
        fileName : targetFile
      },
      dataType : 'text',
      type : 'POST',
      success : function(result){
        console.log(result);

        targetDiv.remove();
        $("input[type='file']").val("");

      },
      error : function(result){
        console.log(result);

        alert("파일을 삭제하지 못하였습니다.")
      }
    });
  }
</script>
</html>
