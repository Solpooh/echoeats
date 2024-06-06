<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>에코잇츠</title>
    <link rel="stylesheet" href="/resources/product/css/main-css.css">
    <link rel="stylesheet" href="/resources/product/css/footer.css">
    <link rel="stylesheet" href="/resources/css/member/grade.css">
    <link rel="stylesheet" href="/resources/css/member/mypage.css">
    <link rel="stylesheet" href="/resources/css/board/review.css">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <style>
        /*데이터없을경우*/
        .noData {
            padding-top: 50px;
        }
        #fillbtn {
            background-color: #692498;
            color: white;
            width: 200px;
            height: 56px;
        }
        .modal {
            display: none;
        }
        .css-1omzzwx, .css-17cmttl {
            color: #00C73C;
        }


    </style>
</head>

<body>
<%@ include file="../include/header.jspf" %>
<%@ include file="../include/mypage.jspf" %>
<!-- --------------------------------------------------->
        <div class="css-171zbec eug5r8l0 content">
            <div class="col-sm-6">
                <div class="mypage-top3">
                    <div>
                        <div id="category-name" style="display: inline-block; margin-bottom: 9px;">
                            <h4 style="margin-right: 20px;">상품후기</h4>
                        </div>
                        <div>
                            <ul class="menuInfoList">
                                <li class="menuInfo">상품에 대한 후기를 남기는 공간입니다.</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- 내용 -->
                <div class="mypage-top4">
                    <!-- 버튼 메뉴 영역 -->
                    <div role="tablist" aria-orientation="horizontal" class="d-flex align-content-between" data-reach-tab-list="">
                        <button class="reviewBtn chk " id="beforeWrite" type="button">작성 가능 후기</button>
                        <button class="reviewBtn chk " id="written" type="button">작성한 후기</button>
                    </div>
                    <!-- 작성가능 후기 영역 (tab1)-->
                    <div class="beforeWriteArea hide">
                        <div class="d-flex align-content-lg-between" style="padding:10px 0px; border-bottom: 1px solid black;">
                            <div style="width: 780px; font-weight: bold;">총 <span id="reviewCnt"></span>개</div>
                        </div>
                        <div id="reviewArea">
                            <!-- 작성가능 후기 -->
                        </div>
                    </div> <!-- beforeWriteArea -->
                    <!-- !!!작성한 후기 영역(tab2) -->
                    <div class="writtenArea hide">
                        <div class="d-flex align-content-lg-between" style="padding:10px 0px; border-bottom: 1px solid black;">
                            <div style="width: 780px; font-weight: bold;">총 <span id="writeReviewCnt"></span>개</div>
                        </div>
                        <div id="writeReviewArea">
                            <!-- 작성한 후기 -->
                        </div><!-- writeReviewArea 반복종료 -->
                    </div> <!-- writtenArea 닫힘 -->
                </div>	   <!-- mypage-top4 -->
            </div> <!-- col-sm-6 -->
        </div>
    </div>
    <!-- 마이페이지 콘텐츠 영역 -->

</div>
<script>

    $('#point2_btn').on("click", function(){
        window.open("/point/all","_blank")
    });

    $('#myPageSideCp').on("click", function () {
        window.location.href = "/coupon";
    });

    $(function() {
        // 작성가능후기 + 작성한후기 구분
        let beforeWriteArea = document.querySelector('.beforeWriteArea');
        let writtenArea = document.querySelector('.writtenArea');
        console.log("before writeArea" + beforeWriteArea);
        beforeWriteArea.classList.remove('hide');
        writtenArea.classList.add('hide');

        // 작성가능후기, 작성한후기 버튼 속성지정
        $('#beforeWrite').attr('style', "background-color: #00C73C");
        $('#written').attr('style', "color: #00C73C");

        var reviewInfo = {
            mem_id: '${loginMember}',
            reviewStatus: 'N'
        }
        console.log("reviewInfo: " + reviewInfo.mem_id);
        showBeforeWrite(reviewInfo);

        // 작성 가능한 리뷰
        $('#beforeWrite').click(function() {
            console.log("작성 가능한리뷰 클릭");
            beforeWriteArea.classList.remove('hide'); // 보이기
            writtenArea.classList.add('hide');  // 숨김
            $('#beforeWrite').attr('style', "background-color:  #00C73C");
            $('#written').attr('style', "color:  #00C73C");
            var reviewInfo = {
                mem_id: '${loginMember}',
                reviewStatus : 'N'
            }
            console.log("reviewInfo :" + reviewInfo.mem_id)
            showBeforeWrite(reviewInfo);
        });

        function showBeforeWrite(reviewInfo) {
            $.ajax({
                type: "POST",
                data: JSON.stringify(reviewInfo),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/mypage1/getMemberReview",
                success: function(data) {
                    console.log("리뷰목록 불러오기");
                    console.log(data);

                    let htmlTag = "";
                    let reviewCnt = data.length;
                    console.log("작성 가능한 리뷰 개수 :" + reviewCnt);

                    if(data.length == 0) {
                        console.log("작성 가능한 리뷰가 없습니다");
                        htmlTag += '<div class="orderList">';
                        htmlTag += '<div class="text-center noData "><h4><b>작성 가능한 리뷰가 없습니다.</b></h4>';
                        htmlTag += '<br>';
                        htmlTag += '</div>';
                        htmlTag += '</div>';
                    } else {
                        $.each(data, function(index, reviewList){
                            htmlTag += '<div class="reviewGrp">';
                            htmlTag += '<div class="review-container" id="review' + index + '">';
                            htmlTag += '<div id="reviewContent' + index + '">';
                            htmlTag += '<li class="d-flex inquiryPro-row" style="padding: 10px; display: flex; align-items: center; justify-content: space-between;">';
                            htmlTag +=      '<div class="pro_img" style="flex: 1;"><img src="' + data[index].ori_filename + '" id="image'+index+'" style="width: 60px; height: 60px; border-radius: 5px;"></div>';

                            htmlTag += '<div class="pro_title" style="flex: 3; text-align: left; margin-left: -80px;">'; // 너비 조정
                            htmlTag += 		'<div class="pro_name font-weight-bold">'+ data[index].prod_name + '</div>';
                            htmlTag += 		'<div class="delivery-status" style="font-weight: 300; font-size: 0.9em;">'+ data[index].review_date + " " + data[index].deliveryStatus + '</div>';
                            htmlTag += '</div>';
                            htmlTag += '<div class="write_review" style="flex: 1; text-align: right;">'; // 너비 조정 및 오른쪽 정렬
                            htmlTag += '<button type="button" class="trigger btn font-weight-bold" id="writeReviewBtn" data-toggle="modal" data-target="#reviewModal' + index + '" style="border: 1px solid lightgray; width: 100px; height: 36px; font-size: small; color: #666666;">후기작성</button>';
                            htmlTag += '</div>';
                            htmlTag += '</li>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';

                            // console.log(htmlTag);
                            // 모달창
                            htmlTag += '<div class="modal fade" id="reviewModal' + index + '">';
                            htmlTag += '<div class="modal-dialog modal-dialog-centered">';
                            htmlTag += '<div class="modal-content">';
                            htmlTag += '<div class="modal-header">';
                            htmlTag += '<h4 class="modal-title">후기 작성</h4>';
                            htmlTag += '</div>';
                            htmlTag += '<div class="modal-body">';
                            htmlTag += '<form name="reviewFrm" id="reviewFrm' + index + '" method="post" style="margin: 0px;" enctype="multipart/form-data">';
                            htmlTag += '<input type="hidden" name="ord_id" id="ord_id" value="'+data[index].ord_id+'">';
                            htmlTag += '<input type="hidden" name="prod_id" id="prod_id" value="'+data[index].prod_id+'">';
                            htmlTag += '<input type="hidden" name="mem_id" id="mem_id" value="'+data[index].mem_id+'">';
                            htmlTag += '<input type="hidden" name="prod_name" id="prod_name" value="' + data[index].prod_name + '">';

                            htmlTag += '<div class="productInfo d-flex align-items-center justify-content-end" style="margin-bottom: 20px;">'; // 오른쪽 정렬을 위해 justify-content-end 사용
                            // 이게 지금 이미지가 랜덤이 나옴
                            // htmlTag +=      '<div class="writeProImg" style="flex: 1;"><img src="' + reviewList.ori_filename + '" style="width: 60px; height: 60px; border-radius: 5px;"></div>';
                            htmlTag += '<div class="writeProImg" style="flex: 1;"><img src="' + data[index].ori_filename + '" id="image'+index+'" style="width: 60px; height: 60px; border-radius: 5px;"></div>';
                            htmlTag += '<div class="writeProName" style="margin-left: 10px;">'+ data[index].prod_name + '</div>';
                            htmlTag += '</div>';


                            htmlTag += '<div class="writeArea">';
                            htmlTag += '<label for="review_content" style="width: 100%; text-align: left; margin-bottom: 10px;">내용</label>';
                            htmlTag += '<textarea id="review_content" name="review_content" style="width: 100%; height: 150px; padding: 10px; border: 1px solid #ccc; border-radius: 5px;" placeholder="상품 특성에 맞는 후기를 작성해주세요. 예) 레시피, 겉포장 속 실제 구성품 사진, 플레이팅, 화장품 사용자의 피부타입 등" required></textarea>';
                            htmlTag += '</div>';
                            htmlTag += '<div>'
                            htmlTag += ' </div>';
                            htmlTag += '<div class="filebox d-flex align-content-between" style="margin-top:20px">';
                            htmlTag += '<div style="width: 90px; text-align: left; margin-top: 15px; ">사진첨부</div>';

                            htmlTag += '<div class="fileIconBox" style="margin-right: 20px;">';
                            htmlTag += '<label for="file"><img src="https://cdn-icons-png.flaticon.com/512/1829/1829371.png" style="width: 60px; height: 60px;" alt="카메라" ></label>';
                            htmlTag += '</div>';
                            htmlTag += '<div><input type="file" id="file"  name="ori_filename" onchange="setThumbnail(event)"></div>';
                            htmlTag += '<div style="border: 1px solid #00C73C;">';
                            <%--htmlTag += '<label for="thumb"><img class="thumb" src="${pageContext.request.contextPath }/resources/images/" style="width: 60px; height: 60px;"></label>';--%>
                            htmlTag += '<div id="preview"></div>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';

                            htmlTag += '<div class="buttonBox" style="text-align: center; padding-top: 20px;">';
                            htmlTag += '<input type="button" id="write_review" value="작성하기" onclick="writeProReview('+index+')" style="background-color: #4CAF50; color: white; border: none; padding: 10px 20px; margin-right: 10px; border-radius: 5px;">';

                            // htmlTag += '<button type="button" class="closeReviewModal" style="background-color: #f44336; color: white; border: none; padding: 10px 20px; border-radius: 5px;">닫기</button>';
                            htmlTag += '<button type="button" class="closeReviewModal" data-dismiss="modal" style="background-color: #f44336; color: white; border: none; padding: 10px 20px; border-radius: 5px;">닫기</button>';
                            htmlTag += '</div>';

                            htmlTag += '</form>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';

                        });
                    }
                    $("#reviewArea").html(htmlTag);
                    $("#reviewCnt").html(reviewCnt);
                },
                error: function() {
                    alert("리뷰 목록 불러오기 실패");
                }
            });
        }

        // 모달을 열 때, 해당 모달만을 타겟팅하기 위해 data-target 속성을 활용합니다.
        $(document).on("click", ".trigger", function() {
            var targetModalSelector = $(this).data('target'); // 이 버튼이 타겟팅하는 모달의 selector를 가져옵니다.
            $(targetModalSelector).show(); // 해당 모달만 표시합니다.
        });

        // 모달을 닫을 때, 이벤트가 발생한 모달만 닫습니다.
        $(document).on("click", ".closeReviewModal", function(event) {
            event.stopPropagation(); // 이벤트 전파를 중단합니다.
            var modalToClose = $(this).closest('.modal'); // 이벤트가 발생한 '닫기' 버튼에 가장 가까운 모달을 찾습니다.
            modalToClose.hide(); // 해당 모달만 숨깁니다.
        });




        // 작성한 리뷰
        $('#written').click(function() {
            console.log("작성한리뷰 클릭");
            writtenArea.classList.remove('hide'); // 보이기
            beforeWriteArea.classList.add('hide'); // 숨김
            $('#written').attr('style', "background-color: #00C73C");
            $('#beforeWrite').attr('style', "color: #00C73C;");

            var reviewInfo = {
                mem_id: '${loginMember}',
                reviewStatus: 'Y'
            }
            console.log("reviewInfo: " + reviewInfo.mem_id);
            showWritten(reviewInfo);
        });

        function showWritten(reviewInfo) {
            $.ajax({
                type: "POST",
                data: JSON.stringify(reviewInfo),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: "/mypage1/seeMyReview",

                success: function(data) {
                    console.log("작성한리뷰목록불러오기");

                    console.log(data);
                    let writeReviewCnt = data.length;
                    console.log ("작성한 리뷰 갯수 : " + writeReviewCnt)

                    let htmlTag = "";
                    if (data.length === 0) {
                        console.log("작성한 리뷰 없음")
                        htmlTag += '<div class="orderList">';
                        htmlTag += '<div class="text-center noData "><h4><b>작성한 리뷰가 없습니다.</b></h4>';
                        htmlTag += '<br><br>';
                        htmlTag += '</div>';
                        htmlTag += '</div>';
                    } else {
                        $.each(data, function(index, reviewList){
                            htmlTag += '<div class="review-container">';
                            htmlTag += '<li class="d-flex inquiryPro-row" style="padding: 20px; display: flex; align-items: center; justify-content: space-between;">'; // Flexbox 적용

                            htmlTag += '<div style="flex-grow: 1;">';
                            htmlTag += '<div class="pro_title" style="width: 560px; text-align: left; padding-left: 20px">';
                            htmlTag += '<div class="pro_name font-weight-bold" style="font-size: 15px">' + reviewList.prod_name + '</div>';
                            htmlTag += '<div class="review_date" style="font-weight: 300; font-size: 0.9em; margin-bottom: 20px;">' + reviewList.review_date + "작성" + '</div>';
                            htmlTag += '<div>' + reviewList.review_content + '</div>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';

                            htmlTag += '<div class="write_review" style="margin-top: 13px;">'
                                + '<button type="button" class="trigger btn font-weight-bold reviewMdfyBtn" id="writeReviewBtn" data-toggle="modal" data-target="#wtReviewModal' + index + '" style="border: 1px solid lightgray; width: 100px; height: 36px; font-size: small; color: #666666;">후기수정</button>'
                                + '</div>';
                            htmlTag += '</li>';
                            htmlTag += '</div>';


                            // 모달창
                            htmlTag += '<div class="modal fade" id="wtReviewModal'+index+'">';
                            htmlTag += '<div class="modal-dialog modal-dialog-centered">';
                            htmlTag += '<div class="modal-content">';
                            htmlTag += '<div class="modal-header">';
                            htmlTag += '<h4 class="modal-title">작성한 후기</h4>';
                            htmlTag += '</div>';

                            htmlTag += '<div class="modal-body">';

                            htmlTag += '<form name="mdfyReviewFrm" id="mdfyReviewFrm"  method="post" style="margin: 0px;">';
                            htmlTag += `<input type="hidden" name="review_id" id="review_id" value="${reviewList.review_id}">`;
                            htmlTag += `<input type="hidden" name="ord_id" id="ord_id" value="${reviewList.ord_id}">`;
                            htmlTag += `<input type="hidden" name="prod_id" id="prod_id" value="${reviewList.prod_id}">`;
                            htmlTag += `<input type="hidden" name="mem_id" id="mem_id" value="${reviewList.mem_id}">`;


                            htmlTag += '<div class="productInfo d-flex align-items-center justify-content-end" style="margin-bottom: 20px;">'; // 오른쪽 정렬
                            <%--htmlTag += '<div class="writeProImg"><img src="${pageContext.request.contextPath }/resources/images/'+ reviewList.thumOriFilename +'" style="width: 60px; height: 60px; border-radius: 5px;"></div>';--%>
                            htmlTag += '<div class="writeProName" style="margin-left: 10px;">'+ reviewList.prod_name + '</div>';
                            htmlTag += '</div>';

                            htmlTag += '<div class="writeArea d-flex">';
                            htmlTag += '<div>'
                            htmlTag += 		'<label for="R_content" style="width: 80px; text-align: left;  margin: 0px; margin-right: 20px;" >내용</label> ';
                            htmlTag += '</div>';

                            htmlTag += '<div>'
                            htmlTag += '<textarea type="text" id="writtenReview" name="review_content" style="background-color:white;" readonly>'+ reviewList.review_content +'</textarea>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';

                            htmlTag += '<div class="filebox d-flex align-content-between" style="margin-top:20px">';

                            htmlTag += '<div class="fileIconBox" style="margin-right: 20px;">';
                            htmlTag += '</div>';

                            htmlTag += '<div class="buttonBox" style="text-align: center; padding-top: 20px;">';
                            htmlTag += '<input type="button" id="write_review" value="수정하기" onclick="modifyReview()" style="background-color: #4CAF50; color: white; border: none; padding: 10px 20px; margin-right: 10px; border-radius: 5px;">';
                            htmlTag += '<button type="button" class="closeReviewModal" style="background-color: #f44336; color: white; border: none; padding: 10px 20px; border-radius: 5px; margin-left: 5px;">닫기</button>';

                            htmlTag += '</div>';

                            htmlTag += '</form>';
                            htmlTag += '</div>';

                            htmlTag += '</div>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';
                            htmlTag += '</div>';

                        });
                    }
                    $("#writeReviewArea").html(htmlTag);
                    $("#writeReviewCnt").html(writeReviewCnt);
                },
                error: function() {
                    alert("작성리뷰 불러오기 실패");
                }
            });
        }

    });

    $(document).on("click", ".reviewMdfyBtn", function () {
        // 리뷰수정

    });

    // function showPreview(event) {
    //     var reader = new FileReader();
    //     reader.onload = function() {
    //         var output = document.getElementById('preview');
    //         output.innerHTML = '<img src="' + reader.result + '" style="width: 100px; height: 100px;"/>'; // 썸네일 크기 조정
    //     };
    //     reader.readAsDataURL(event.target.files[0]);
    // }

    function writeProReview(index) {
        // // 리뷰 작성 실행
        var reviewFrm = document.querySelector("#reviewFrm"+index);
        reviewFrm.action = "writeProReview";
        console.log("reviewFrm", reviewFrm);
        reviewFrm.submit();
    }


    function modifyReview(){
        // 수정활성화
        $('#writtenReview').removeAttr('readonly');
        $('#writtenReview').css('border', '3px solid #692498');
        mdfyReviewFrm = document.getElementById("mdfyReviewFrm");
        mdfyReviewFrm.action ="modifyProReview";
        mdfyReviewFrm.submit();
    }

</script>
</body>

<footer>
    <%@include file="../include/footer.jspf" %>
</footer>
</html>