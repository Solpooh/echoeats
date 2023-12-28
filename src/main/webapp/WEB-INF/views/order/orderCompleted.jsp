<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>OrderCompleted</title>
    <link rel="stylesheet" href="/resources/product/css/main-css.css">
    <link href="/resources/order/css/orderCompletedStyle.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/resources/product/css/footer.css">
</head>
<body>
<%@ include file="../include/header.jspf" %>
<div class="css-ugqv3j e146m4rf2">
    <div class="css-1uom1od e146m4rf0">
        <div class="css-1icxyy0 e1ax7ftx3">
            <div class="css-fnh15r e190vd4y4">
                <div class="css-yb4g98 e190vd4y3">
                    <p class="css-14is9qy e190vd4y0">${mem_name}님의 주문이 완료되었습니다.</p>
                    <p class="css-114oz6p e190vd4y2">내일 새벽에 만나요!<br></p>
                </div>
            </div>
            <div class="css-1va7zlz epyeklp6">
                <div class="css-1l8u1wr epyeklp3">${address.addr} ${address.dtl_addr}</div>
                <div class="css-qnijoc epyeklp2"></div>
                <div class="css-1hh4r05 epyeklp5">
                    <span class="css-1h6pllp epyeklp1">주문번호</span>
                    <p class="css-ciygyc epyeklp0">${payment.ord_id}</p>
                </div></div>
<%--            <div class="css-8qz8ia e13kpt4l4">--%>
<%--                <div class="css-1feuezi e13kpt4l3">--%>
<%--                    <span class="css-152kj31 e13kpt4l2">첫 구매 감사혜택 1.</span>--%>
<%--                    <span class="css-il3y9x e13kpt4l1">무료배송</span>--%>
<%--                    <p class="css-m2n2y e13kpt4l0">2만원 이상 주문 시, 다음 날 오전부터 한 달간 적용</p>--%>
<%--                </div><div class="css-1feuezi e13kpt4l3">--%>
<%--                <span class="css-152kj31 e13kpt4l2">첫 구매 감사혜택 2.</span>--%>
<%--                <span class="css-il3y9x e13kpt4l1">결제금액 5% 적립</span>--%>
<%--                <p class="css-m2n2y e13kpt4l0">다음 날 오전부터 한 달간 적용</p>--%>
<%--            </div></div>--%>
            <div class="css-1wa7vj6 epyeklp4">
                <div class="css-1a1jcfo ea1mry77">
                    <span class="css-vmo0an ea1mry76">결제금액</span>
                    <span class="css-21ugym ea1mry73">${payment.tot_pay_price}<span class="css-hfgifi ea1mry72">원</span></span>
                </div>
                <div class="css-1a1jcfo ea1mry77">
                    <span class="css-vmo0an ea1mry76">적립금</span>
                    <span class="css-13515y6 ea1mry75"><span class="css-r9z3y0 ea1mry74">+${payment.reserves}<span class="css-hfgifi ea1mry72">원</span></span</span></div></div>
            <div class="css-1dslxe3 e1ax7ftx2">
                <ul>
                    <li class="css-dnq4jd ejr204i0">[주문완료] 상태일 경우에만 주문내역 상세페이지에서 주문 취소가 가능합니다.</li>
                    <li class="css-dnq4jd ejr204i0">엘리베이터 이용이 어려운 경우 6층 이상부터는 공동 현관 앞 또는 경비실로 대응 배송 될 수 있습니다.</li>
                    <li class="css-dnq4jd ejr204i0">실제 출입 정보가 다를 경우, 부득이하게 1층 공동현관 앞 또는 경비실 앞에 배송될 수 있습니다.</li>
                    <li class="css-dnq4jd ejr204i0">주문 / 배송 및 기타 문의가 있을 경우, 1:1 문의에 남겨주시면 신속히 해결해드리겠습니다.</li>
                </ul>
            </div>
            <div class="css-a0s0c2 e1ax7ftx0">
                <button id="orderDetailBtn"class="css-o6ldsh e4nu7ef3" type="button">
                    <span class="css-nytqmg e4nu7ef1">주문 상세보기</span></button>
                <button id="continueBtn" class="css-6682oh e4nu7ef3" type="button">
                    <span class="css-nytqmg e4nu7ef1">쇼핑 계속하기</span></button>
            </div>
        </div>
    </div>
    <%@ include file="../include/footer.jspf" %>
</div>
<script>
    document.getElementById("orderDetailBtn").addEventListener('click',function (){
       window.location.href = "/mypage/order";
    });
    document.getElementById("continueBtn").addEventListener('click',function (){
        window.location.href = "/main";
    });

</script>
</body>
</html>