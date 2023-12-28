<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>컬리</title>
    <link rel="stylesheet" href="/resources/css/member/point.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>

<body class="u75ne30 u75ne34">
<div id="__next">
    <main class="app">
        <div class="_2wzkdc1 _149xcwa1">
            <div class="u75ne30 t8y8263 hm8a9i0"></div>
            <div class="u75ne30 _1yn5z93 hm8a9i2"></div>
        </div>
        <header class="u75ne30 u75ne33 _2wzkdc1 _1cwllq51 _149xcwa1 _11jqbprd _1yyx8n03 _1496k3l1 _3dpgqx1 octrs51 q1m3k72">
            <div class="u75ne30 _1yyx8n00 _1496k3l1 _3dpgqx1 octrs51 _1qsm8w41 _11elurb1 _1f1neadg"></div>
            <div class="u75ne30 _2wzkdc1 _1c1ajx20 _149xcwa1 _1siu7xkj _1xjyd9v7 _1hh7yk87">
                <h1 class="u75ne30 _7qafms6 xch8s63 _1shy0uyp">적립금 내역</h1>
            </div>
            <button class="u75ne30 u75ne32 _15ozwg2 xjsnc60 _1yyx8n00 _3dpgqx1"><svg
                    xmlns="http://www.w3.org/2000/svg" width="44" height="44" fill="none" viewBox="0 0 44 44">
                <path stroke="#333333" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                      d="M25 30.485 16.515 22 25 13.515"></path>
            </svg>
            </button>
        </header>
        <div class="u75ne30 _2wzkdc1 _1c1ajx22 _1mkbjwk1 _11jqbprd _88hjf31">
            <div class="u75ne30 _2wzkdc1 _1c1ajx22 _1mkbjwkd j7e93oc _1hs5a5pc _2rj8kkd _1f0a74dd">
                <div class="u75ne30 _2wzkdc1 _1c1ajx22 _1mkbjwk4">
                    <div class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1">
                        <div class="u75ne30 _2wzkdc1 _1c1ajx20 _1mkbjwk3 _1cwllq51"><span
                                class="u75ne30 _1shy0uyn _7qafms2">사용 가능 적립금</span>
                            <div class="u75ne30 _15ozwg2 xjsnc60"><svg width="12" height="12" viewBox="0 0 12 12"
                                                                       fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path
                                        d="M5.39732 7.18162H6.32143V6.91317C6.32143 6.45988 6.48661 6.22664 7.0625 5.89218C7.65179 5.54452 8 5.06483 8 4.3871V4.3783C8 3.44093 7.20536 2.75 6.02679 2.75C4.73214 2.75 4.04018 3.50694 4 4.50152V4.51032L4.91964 4.50592H4.92857C4.96429 3.92502 5.36161 3.55975 5.97768 3.55975C6.58929 3.55975 6.98661 3.92502 6.98661 4.41791V4.42671C6.98661 4.87559 6.79464 5.13084 6.25446 5.4521C5.64286 5.81297 5.37054 6.20904 5.39286 6.82955L5.39732 7.18162ZM5.91518 9.25C6.32589 9.25 6.60268 8.98595 6.60268 8.59428C6.60268 8.19821 6.32589 7.93416 5.91518 7.93416C5.50446 7.93416 5.22321 8.19821 5.22321 8.59428C5.22321 8.98595 5.50446 9.25 5.91518 9.25Z"
                                        fill="#5F0080"></path>
                                <circle cx="6" cy="6" r="5.5" stroke="#5F0080"></circle>
                            </svg></div>
                        </div>
                    </div>
                    <div class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1">
                        <div class="u75ne30 _2wzkdc1 _1c1ajx20 _1mkbjwk2 _1cwllq54"><span
                                class="u75ne30 _1shy0uyp _7qafms9 xch8s63">${available}</span><span
                                class="u75ne30 _1shy0uyp _7qafms6">원</span></div>
                    </div>
                </div>
                <div class="u75ne30 _2wzkdc1 _1c1ajx22 _1mkbjwk4">
                    <div class="u75ne30 _2wzkdc1 _1c1ajx20 _149xcwa3"><span class="u75ne30 _1shy0uyn _7qafms4">소멸예정
                                금액 (30일 이내)</span><span class="u75ne30 _1shy0uyp _7qafms4 xch8s63">${preExtinct}원</span></div>
                    <div class="u75ne30 _2wzkdc1 _1c1ajx20 _149xcwa3"><span class="u75ne30 _1shy0uyn _7qafms4">총 누적
                                적립금 (가입일 기준)</span><span class="u75ne30 _1shy0uyp _7qafms4 xch8s63">${sum}원</span></div>
                </div>
            </div>
            <div class="u75ne30 _2wzkdc0 _1siu7xkj _10t522d0 _11jqbpr9"></div>
            <div class="u75ne30 _2wzkdc1 _1c1ajx22"><swiper-container class="u75ne30 u75ne3b"
                                                                      init="false"><swiper-slide class="u75ne30 swiper-slide-active swiper-slide-next" role="group"
                                                                                                 aria-label="NaN / 1" style="width: 1023px;">
                <div class="u75ne30 _1yyx8n02 _2wzkdc1 _1c1ajx22 _1siu7xkj">
                    <div class="u75ne30 _1yyx8n02 _2wzkdc1 _1c1ajx22 _1siu7xkj _15ozwg2 xjsnc60"><img
                            alt="컬리상품권 구매하러가기" loading="lazy" width="1125" height="186" decoding="async"
                            data-nimg="1" class="u75ne30 u75ne35 _1siu7xkj"
                            srcset="https://www.kurlypay.co.kr/images/mypage/point/PointBannerPresentGiftcardV2.png?width=1200 1x, https://www.kurlypay.co.kr/images/mypage/point/PointBannerPresentGiftcardV2.png?width=3840 2x"
                            src="https://www.kurlypay.co.kr/images/mypage/point/PointBannerPresentGiftcardV2.png?width=3840"
                            style="color: transparent;"></div>
                </div>
            </swiper-slide></swiper-container></div>
            <div class="u75ne30 _2wzkdc0 _1siu7xkj _10t522d0 _11jqbpr9"></div>
            <div class="u75ne30 _2wzkdc1 _1c1ajx22 _88hjf31">
                <div class="u75ne30 _2wzkdc1 _1c1ajx20 _1mkbjwk4 j7e93oc _1hs5a5pc _1f0a74dc _2rj8kk7">
                    <div
                            class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1 _2rj8kk6 _1f0a74d6 _1f1nead0 _1e4qggb3 umo8vf1 _88hjf31 _15ozwg2 xjsnc60">
                        <span class="u75ne30 _1shy0uy0 _7qafms4 xch8s63">전체</span></div>
                    <div
                            class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1 _2rj8kk6 _1f0a74d6 _1f1nead12 _1e4qggb3 umo8vf1 _88hjf31 _15ozwg2 xjsnc60">
                        <span class="u75ne30 _1shy0uyn _7qafms4 xch8s61">적립</span></div>
                    <div
                            class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1 _2rj8kk6 _1f0a74d6 _1f1nead12 _1e4qggb3 umo8vf1 _88hjf31 _15ozwg2 xjsnc60">
                        <span class="u75ne30 _1shy0uyn _7qafms4 xch8s61">사용</span></div>
                    <div
                            class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1 _2rj8kk6 _1f0a74d6 _1f1nead12 _1e4qggb3 umo8vf1 _88hjf31 _15ozwg2 xjsnc60">
                        <span class="u75ne30 _1shy0uyn _7qafms4 xch8s61">소멸</span></div>
                </div>
                <div class="u75ne30 _2wzkdc1 _1c1ajx20 _1cwllq51 _149xcwa3 j7e93od _1hs5a5pc"><span
                        class="u75ne30 _7qafms5 xch8s62">총 ${count}건</span>
                    <div class="u75ne30 _2wzkdc3 _1yyx8n02">
                        <div
                                class="u75ne30 _2wzkdc1 _1c1ajx20 _1cwllq51 _2rj8kk8 _1f0a74d8 j7e93oa _15ozwg2 xjsnc60">
<%--                            <span class="u75ne30 _1shy0uyp">--%>
<%--                                <select>--%>
<%--                                    <option value="3">3개월</option>--%>
<%--                                    <option value="6">6개월</option>--%>
<%--                                    <option value="9">9개월</option>--%>
<%--                                    <option value="12">12개월</option>--%>
<%--                                </select>--%>
<%--                            </span>--%>
                            <%--                            <svg xmlns="http://www.w3.org/2000/svg"--%>
                            <%--                                                                           viewBox="0 0 20 20" width="20" height="20" stroke="#999999" fill="none">--%>
                            <%--                            <path d="M13.8995 8L9.65683 12.2426L5.41419 8" stroke-linecap="round"--%>
                            <%--                                  stroke-linejoin="round"></path>--%>
                            <%--                        </svg>--%>
                        </div>
                        <div class="u75ne30 _1492m9g7 hm8a9i0"></div>
                    </div>
                </div>
                <div class="u75ne30 _2wzkdc1 _1c1ajx22 _88hjf31">
                    <c:forEach var="pointDtos" items="#{list}">
                        <div class="u75ne30 _2wzkdc1 _1c1ajx22">
                            <div class="u75ne30 _1f1nead9 _11elurb1">
                                <div class="u75ne30 _2wzkdc1 _1c1ajx20 j7e93oc _1hs5a5pc _1f0a74da _2rj8kk5"><span
                                        class="u75ne30 xch8s62">${pointDtos.rg_date}</span></div>
                                <div
                                        class="u75ne30 _2wzkdc1 _1c1ajx20 _1mkbjwkc _1cwllq50 _149xcwa3 j7e93oc _1hs5a5pc _2rj8kk7 _1f0a74d7">
                                    <div class="u75ne30 _2wzkdc1 _1c1ajx20 _1mkbjwk7 _1cwllq50">
                                        <div class="u75ne30 _1yyx8n02 _1j5ftz50">
                                            <div class="u75ne30 _2wzkdc0 gftunfb _11jqbpr18 _1e4qggb1"></div>
                                            <div
                                                    class="u75ne30 _2wzkdc1 _1c1ajx20 gftunf3 _1yyx8n00 _1496k3l1 _3dpgqx1 octrs51 _1qsm8w41">
                                                <div class="u75ne30 _2wzkdc1 _1cwllq51 _149xcwa1 _88hjf31"><span
                                                        class="u75ne30 _1shy0uy0 _7qafms1 _176pgqn4">${pointDtos.status}</span></div>
                                            </div>
                                        </div>
                                        <div class="u75ne30 _2wzkdc1 _1c1ajx22 _1mkbjwk3"><span
                                                class="u75ne30 _1shy0uyp _7qafms4">${pointDtos.reason} 5%</span><span
                                                class="u75ne30 _1shy0uyn _7qafms2">주문번호 (${pointDtos.ord_id})</span></div>
                                    </div>
                                    <div class="u75ne30 _2wzkdc1 _1c1ajx22 _1mkbjwk3 _1cwllq52 _1j5ftz50"><span
                                            class="u75ne30 _1shy0uy0 _7qafms4">
                                            <c:choose>
                                                <c:when test="${pointDtos.status.equals('적립')}">+</c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                            ${pointDtos.price}원</span><span
                                            class="u75ne30 _1shy0uyn _7qafms2"><fmt:formatDate value="${pointDtos.his_end_date}" pattern="yy.MM.dd" type="date"/>&nbsp; 만료</span></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <span class="u75ne30 _1f1nead14 _11elurb1"></span>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>