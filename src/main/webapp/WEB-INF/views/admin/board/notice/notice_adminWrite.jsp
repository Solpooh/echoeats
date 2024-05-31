<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:scriptlet> pageContext.setAttribute("newline", "\n"); </jsp:scriptlet>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 공지사항 관리자 등록 페이지 -->
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link href="<c:url value='/resources/common/css/styles.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/admin/order/css/orderList.css' />" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.esm.js"></script>
    <script nomodule src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/themes/default.css" />
    <style>
        h4 {
            font-weight: bolder;
        }
        h4 span {
            vertical-align: middle;
            font-size: small;
            color: #999;
        }
        .main {
            padding-bottom: 24px;
            padding-top: 24px;
        }
        .table {
            width: 100%;
            text-align: center;
        }
        .title {
            width: 100%;
            vertical-align: middle;
            padding-bottom: 9px;
            border-color: lightgray;
            border-width: 1px;
        }
        .back_btn {
            padding: 0px 10px;
            text-align: center;
            overflow: hidden;
            width: 120px;
            height: 44px;
            border-radius: 3px;
            color: rgb(255, 255, 255);
            background-color: #4CAF50;
            border: 0px none;
            font-size: small;
        }
        .notice_btn {
            padding: 0px 10px;
            text-align: center;
            overflow: hidden;
            width: 120px;
            height: 44px;
            border-radius: 3px;
            color: rgb(255, 255, 255);
            background-color: #4CAF50;
            border: 0px none;
            font-size: small;
        }
        .col-sm-6 {
            max-width: 900px;
            width: 100%;
            margin: 0 auto;
        }
        .back_btn:hover {
            background-color: #7F208D;
        }
    </style>
</head>
<body class="sb-nav-fixed">
<%@ include file="../../include/top_side_nav.jspf" %>
<div class="container-fluid">
    <div class="row" style="padding-top:50px; padding-bottom: 50px">
        <div class="col-sm-6">
            <div class="main" style="border-bottom:2px solid black">
                <h4>공지사항 작성<span> 에코잇츠의 새로운 소식들과 유용한 정보들을 등록하세요</span></h4>
            </div>
            <div>
                <form name="frm" method="post">
                    <table class="table">
                        <thead>
                        <tr style="height: 60px;">
                            <th style="width: 10%; vertical-align: middle; border-color: white;">제목</th>
                            <th style="vertical-align: left; border-bottom-color: white;">
                                <input type="text" class="title" name="notice_title" placeholder="제목을 입력하세요.">
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td style="font-weight: bolder;">내용</td>
                            <td>
                                <textarea class="form-control" rows="18" id="content" name="notice_con" placeholder="내용을 입력하세요."></textarea>
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
                        <button class="back_btn" type="button" onclick="location.href='notice'"
                                style="width: 120; height: 44; border-radius: 3;">취소</button>
                        <button class="notice_btn" type="button" onclick="check_notice()"
                                style="width: 120; height: 44; border-radius: 3;">등록</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    //textarea 글자수 제한
    $('.form-control').keyup(function (e) {
        var content = $(this).val();
        $('#counter').html("(" + content.length + "자 / 2000자)");    //글자수 실시간 카운팅

        if (content.length > 2000) {
            alert("최대 2000자까지 입력 가능합니다.");
            $(this).val(content.substring(0, 2000));
            $('#counter').html("(2000 / 2000자)");
        }
    });

    //제목,내용 미입력시 알림
    function check_notice() {
        let frm = document.frm;
        console.log(frm);
        if (frm.notice_title.value === "" || frm.notice_con.value === "") {
            if (frm.notice_title.value === "") {
                alert("제목을 입력해주세요.");
            } else if (frm.notice_con.value === "") {
                alert("내용을 입력해주세요.");
            }
            return false;
        } else {
            frm.action="insertNotice"
            frm.submit();
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/resources/common/js/scripts.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-area-demo.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-bar-demo.js' />"></script>
<script src="<c:url value='/resources/common/js/datatables-simple-demo.js' />"></script>
</body>
</html>
