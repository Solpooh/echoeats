<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:scriptlet> pageContext.setAttribute("newline", "\n"); </jsp:scriptlet>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!-- 공지사항 관리자 등록 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="stylesheet" href="${contextPath}/resources/common/css/styles.css" />
    <link rel="stylesheet" href="${contextPath}/resources/admin/order/css/orderList.css" />
    <link rel="stylesheet" href="${contextPath}/resources/css/board/board.css" />
</head>
<body class="sb-nav-fixed">
<%@ include file="../../include/top_side_nav.jspf" %>
<div class="container-fluid">
    <div class="row" style="padding-top:50px; padding-bottom: 50px">
        <div class="col-sm-6">
            <div class="main" style="border-bottom:2px solid black">
                <h4>공지사항 <c:out value="${mode == 'new' ? '작성' : '수정'}"/>
                    <span> 에코잇츠의 새로운 소식들과 유용한 정보들을 <c:out value="${mode == 'new' ? '등록' : '수정'}"/>하세요</span>
                </h4>
            </div>
            <div>
                <form name="frm" method="post" onsubmit="return saveNotice()">
                    <table class="table">
                        <thead>
                        <tr style="height: 60px;">
                            <th style="width: 10%; vertical-align: middle; border-color: white;">제목</th>
                            <th style="vertical-align: left; border-bottom-color: white;">
                                <input type="hidden" name="mode" value="<c:out value='${mode}'/>">
                                <c:if test="${mode == 'edit'}">
                                    <input type="hidden" name="notice_id" value="<c:out value='${notice.notice_id}'/>">
                                    <input type="hidden" name="page" value="<c:out value='${sc.page}'/>">
                                    <input type="hidden" name="pageSize" value="<c:out value='${sc.pageSize}'/>">
                                </c:if>
                                <input type="text" class="title" name="notice_title" value="${mode == 'new' ? '' : notice.notice_title}">
                                <div id="titleMessage" style="color: red;"></div> <!-- 제목 검증 메시지 -->
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="font-weight: bolder;">내용</td>
                            <td>
                                <textarea class="form-control" rows="18" id="content" name="notice_con">${mode == 'new' ? '' : notice.notice_con}</textarea>
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

                    <!-- -->
                    <div style="text-align: right;">
                        <button class="back_btn" type="button" onclick="location.href='<c:url value="notice${sc.getQueryString()}"/>'"
                                style="width: 120; height: 44; border-radius: 3;">취소</button>
                        <button class="notice_btn" type="submit" onclick="saveNotice()"
                                style="width: 120; height: 44; border-radius: 3;">
                            <c:out value="${mode == 'new' ? '등록' : '수정'}"/>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        <c:if test="${mode == 'edit'}">
        let item_id = '<c:out value="${notice.notice_id}"/>';
        let uploadResult = $("#uploadResult");
        $.getJSON("<c:url value='/getImageList'/>", {item_id: item_id, mode: "notice"}, function (data) {
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
    });

    //textarea 글자수 제한
    $('.form-control').keyup(function () {
        let content = $(this).val();
        $('#counter').html("(" + content.length + "자 / 2000자)");    //글자수 실시간 카운팅

        if (content.length > 2000) {
            alert("최대 2000자까지 입력 가능합니다.");
            $(this).val(content.substring(0, 2000));
            $('#counter').html("(2000 / 2000자)");
        }
    });

    function saveNotice() {
        let frm = document.frm;
        let title = frm.notice_title.value.trim();
        let content = frm.notice_con.value.trim();

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
            frm.action = "<c:url value='insertNotice'/>";
            return true;  // 폼을 제출합니다.
        } else {
            return false;  // 폼 제출을 중단합니다.
        }
    }


    // 이미지
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
            url: '<c:url value='/uploadImage'/>',
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
</body>
</html>
