<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>에코</title>
    <link rel="stylesheet" href="/resources/css/member/addr_form.css">
    <link rel="stylesheet" href="/resources/product/css/main-css.css">
    <script src = "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<%--<%@ include file="../include/header.jspf" %>--%>

<%--<div class = "css-2b29tl">--%>
<%--    <div class = "css-1jgbowa epggjnz4">--%>
<%--        <div class = "css-1oynwoh epggjnz3">--%>
<%--            <div class = "css-1nmq3i1 epggjnz2">--%>
<%--                <div class = "css-zjik7">--%>
<%--                    <div class = "welcome">${memberDto.gd_name}</div>--%>
<%--                    <div class = "css-38n0u7">--%>
<%--                        <strong class = "name">--%>
<%--                            ${memberDto.mem_name}--%>
<%--                        </strong>--%>
<%--                        <div class = "css-70qvj9">--%>
<%--                            <button class = "css-rlyyl8">다음 달 등급 확인</button>--%>
<%--                            <span class = "css-i9bkc4"></span>--%>
<%--                            <button class = css-rlyyl8>전체 등급 확인</button>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class = "css-1rqh7gg">--%>
<%--                    <p class = "css-1nwlk71">적립 5%</p>--%>
<%--                    <p class = "css-1nwlk71">최소 1회 무료배송</p>--%>
<%--                    <a href="/member/membership" class="css-1qcjshh">--%>
<%--                            <span class="css-1fid7vq">--%>
<%--                                <span class="css-3a5cil">NEW</span>--%>
<%--                                <span class="css-1kxzrwz">에코멤버스</span>--%>
<%--                                <span class="css-10yg44e">월 1,900원으로 10배 쿠폰 받기</span>--%>
<%--                            </span>--%>
<%--                    </a>--%>
<%--                </div>--%>
<%--            </div>--%>


<%--            <div class="css-1jemrvf epggjnz1">--%>
<%--                <div class="css-1lomzjv epggjnz0">--%>
<%--                    <button class="css-1bm0yf4 e1ugk4rt6">--%>
<%--                        <div class="css-157zkrj e1ugk4rt5">적립금 · 에코캐시--%>
<%--                            <span class="css-14phxgn e1ugk4rt4"></span>--%>
<%--                        </div>--%>
<%--                        <div class="css-1omzzwx e1ugk4rt3">바로가기--%>
<%--                            <span class="css-mmvz9h e1ugk4rt0"></span>--%>
<%--                        </div>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--                <div class="css-1lomzjv epggjnz0">--%>
<%--                    <button class="css-1bm0yf4 e1ugk4rt6">--%>
<%--                        <div class="css-157zkrj e1ugk4rt5">쿠폰--%>
<%--                            <span class="css-14phxgn e1ugk4rt4"></span>--%>
<%--                        </div>--%>
<%--                        <div class="css-1omzzwx e1ugk4rt3">0--%>
<%--                            <span class="css-mmvz9h e1ugk4rt0">개</span>--%>
<%--                        </div>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--                <div class="css-1lomzjv epggjnz0">--%>
<%--                    <button class="css-1bm0yf4 e1ugk4rt6">--%>
<%--                        <div class="css-157zkrj e1ugk4rt5">나의 에코 스타일--%>
<%--                            <span class="css-14phxgn e1ugk4rt4"></span>--%>
<%--                        </div>--%>
<%--                        <div class="css-1omzzwx e1ugk4rt3">등록하기--%>
<%--                        </div>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>


<%--            <div class="css-1jemrvf epggjnz1">--%>
<%--                <div class="css-1lomzjv epggjnz0">--%>
<%--                    <button class="css-13d66fq e1ugk4rt6">--%>
<%--                        <div class="css-157zkrj e1ugk4rt5">에코 그린 박스--%>
<%--                            <span class="css-14phxgn e1ugk4rt4"></span>--%>
<%--                        </div>--%>
<%--                        <div class="css-17cmttl e1ugk4rt3">알아보기</div>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--                <div class="css-1lomzjv epggjnz0">--%>
<%--                    <button class="css-13d66fq e1ugk4rt6">--%>
<%--                        <div class="css-157zkrj e1ugk4rt5">에코멤버스--%>
<%--                            <span class="css-14phxgn e1ugk4rt4"></span>--%>
<%--                        </div>--%>
<%--                        <div class="css-17cmttl e1ugk4rt3">혜택받기</div>--%>
<%--                    </button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <a href="https://www.kurly.com/m2/event/kurlyEventV2.php?lego=event/2023/0911/join/coupon" class="css-1khmcew eyulecr1">--%>
<%--            <img src="https://product-image.kurly.com/banner/da-banner/55b64dac-7373-4bb5-b44d-7a2eecde375a.jpg" alt="230713 신규1만원 쿠폰 웰컴 PC" class="css-1th0ley eyulecr0">--%>
<%--        </a>--%>
<%--    </div>--%>


<%--    <div class="css-luwwab eug5r8l1">--%>
<%--        <div class="css-833hqy ecbxmj3">--%>
<%--            <div class="css-1v4whg ecbxmj2">마이컬리</div>--%>
<%--            <ul class="css-1x9bshx ecbxmj1">--%>
<%--                <li>--%>
<%--                    <a class="css-g4g0eu ecbxmj0">주문내역--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#5f0080" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">선물내역--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">찜한상품--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class="active css-g4g0eu ecbxmj0">배송지 관리--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">상품후기--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">결제수단 · 컬리페이--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">상품 문의--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">적립금 · 컬리캐시--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">쿠폰--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">나의 에코 스타일--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>

<%--                <li>--%>
<%--                    <a class=" css-g4g0eu ecbxmj0">개인 정보 수정--%>
<%--                        <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                            <defs>--%>
<%--                                <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                            </defs>--%>
<%--                            <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                                <use stroke="#999" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                            </g></g></g></g></g>--%>
<%--                        </svg>--%>
<%--                    </a>--%>
<%--                </li>--%>
<%--            </ul>--%>

<%--            <a href="/mypage/inquiry/list" class="css-196gwz9 e19l01ug3">--%>
<%--                <div class="css-rmee6s e19l01ug2">--%>
<%--                    <span class="css-1sdidca e19l01ug1">도움이 필요하신가요 ?</span>--%>
<%--                    <span class="css-rnnx2x e19l01ug0">1:1 문의하기</span>--%>
<%--                </div>--%>
<%--                <svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" viewBox="0 0 24 24">--%>
<%--                    <defs>--%>
<%--                        <path id="gfk9q0rhta" d="M1.657 1.657L9.657 1.657 9.657 9.657"></path>--%>
<%--                    </defs>--%>
<%--                    <g fill="none" fill-rule="evenodd"><g><g><g><g transform="translate(-339 -398) translate(0 386) translate(339 12) translate(4.69 6.343)">--%>
<%--                        <use stroke="#333" stroke-linecap="round" stroke-width="1.8" stroke-linejoin="round" transform="rotate(45 5.657 5.657)" xlink:href="#gfk9q0rhta"></use>--%>
<%--                    </g></g></g></g></g>--%>
<%--                </svg>--%>
<%--            </a>--%>
<%--        </div>--%>

<%--        <div class="css-171zbec eug5r8l0">--%>
            <div class="css-j0lifa ed9qr673">
                <div class="css-fhxb3m ed9qr672">
                    <h2 class="css-1268zpe ed9qr671">배송지 관리</h2>
                    <span class="css-a3vgo2 ed9qr670">배송지에 따라 상품정보 및 배송유형이 달라질 수 있습니다.</span>
                </div>
                <div class="css-fhxb3m ed9qr672">
                    <div class="css-wkgeho e1ykq6gv2">
                        <div>
                            <div class="css-1es6ihh e1af7ryb2">
                                <div class="css-1xhquvz e1a9f8h00">
                                    <button class="css-1bqw8am e4nu7ef3" type="button" height="60" onclick="kakaopost()">
                                            <span class="css-nytqmg e4nu7ef1">
                                                <img src="https://res.kurly.com/pc/ico/2006/ico_add_16x16.svg" alt class="css-1m3kac1 e4nu7ef0">
                                                새 배송지 추가
                                            </span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="css-1jdq78j e1cucsfi1">
                <div class="css-wru9pk e1cucsfi0"><!--선택--></div>
                <div class="css-3fr0n1 e1cucsfi0">주소</div>
                <div class="css-gtglzf e1cucsfi0">받으실 분</div>
                <div class="css-1aqlhfo e1cucsfi0">연락처</div>
                <div class="css-1aqlhfo e1cucsfi0">배송유형</div>
                <div class="css-wru9pk e1cucsfi0">수정</div>
            </div>
            <ul class="css-1fttcpj erme1rh2">   <!--주소 박스-->
                <c:forEach var="addressDtos" items="${list}">
                <li class="css-d35zkp erme1rh1">
                    <div>
                        <div class="eeocvzp5 css-1bs5q0a e19svclq0">
<%--                            <label class="css-1xdhyk6 e1dcessg3">--%>
<%--                                <input type="checkbox" class="css-agvwxo e1dcessg2" value="21937039" name="checkbox">--%>
<%--                                <div class="css-79hxr7 e1dcessg1">--%>
<%--                                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">--%>
<%--                                        <path d="M23.5 12C23.5 18.3513 18.3513 23.5 12 23.5C5.64873 23.5 0.5 18.3513 0.5 12C0.5 5.64873 5.64873 0.5 12 0.5C18.3513 0.5 23.5 5.64873 23.5 12Z" stroke="#ddd" fill="#fff"></path>--%>
<%--                                        <path d="M7 12.6667L10.3846 16L18 8.5" stroke="#ddd" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>--%>
<%--                                    </svg>--%>
<%--                                </div>--%>
<%--                                <span></span>--%>
<%--                            </label>--%>
                        </div>
                        <div class="eeocvzp4 css-8xfsdg e19svclq0">
                            <div>
                                <c:if test="${addressDtos.def_addr.equals('Y')}"><div class="css-1b3iimx eeocvzp0">기본 배송지</div></c:if>
                                ${addressDtos.addr}
                                ${addressDtos.dtl_addr}
                            </div>
                        </div>
                        <div class="eeocvzp3 css-1o9d8vk e19svclq0" name="name">${addressDtos.name}</div>
                        <div class="eeocvzp2 css-xkreku e19svclq0">${addressDtos.phone}</div>
                        <div class="eeocvzp6 css-xkreku e19svclq0">
                            <div>
                                <span type="direct" class="css-z4mca9 e1jlkvf51">${addressDtos.type}</span>
                            </div>
                        </div>
                        <div class="eeocvzp1 css-1bs5q0a e19svclq0">
                            <button name="update_btn" id="${addressDtos.addr_id}">
                                <svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <g fill="none" fill-rule="evenodd">
                                        <path fill="none" d="M0 0h24v24H0z"></path>
                                        <path d="m13.83 5.777 4.393 4.393-10.58 10.58H3.25v-4.394l10.58-10.58zm3.204-2.527c.418 0 .837.16 1.157.48l2.08 2.08a1.63 1.63 0 0 1 0 2.314l-2.157 2.156-4.394-4.394 2.157-2.156c.32-.32.738-.48 1.157-.48z" stroke="#ccc" stroke-width="1.5"></path>
                                    </g>
                                </svg>
                            </button>
                        </div>
                    </div>
                </li>
                </c:forEach>

            </ul>

<%--        </div>--%>

<%--    </div>--%>
<%--</div>--%>
<script>


    //주소검색 api
    function kakaopost() {
        new daum.Postcode({
            oncomplete: function (data) {
                let addr = data.address;
                moveToDetailedPage(addr);
            }
        }).open();
    }
    // 상세주소 페이지로 이동
    function moveToDetailedPage(addr) {
        detailPage = window.open("/address/detail?addr=" + encodeURIComponent(addr),"_blank","width=500, height=500")
        $(detailPage).on('beforeunload',function (){
            location.reload();
        })
    }
    //주소업데이트 페이지로 이동
    update_btns = document.getElementsByName("update_btn");
    update_btns.forEach(function (btn){
        btn.addEventListener('click',function moveToUpdatePage() {
            var addr_id = btn.id;
           updatePage=  window.open("/address/update?addr_id=" + encodeURIComponent(addr_id),"_blank","width=500, height=500")
            $(updatePage).on('beforeunload',function (){
                location.reload();
            })
        })
    })
    // //checked
    // let checkboxes = document.getElementsByName("checkbox");
    // checkboxes.forEach(function (checkbox) {
    //     checkbox.addEventListener("change", function () {
    //         let svgPath = checkbox.parentElement.querySelector(".css-79hxr7 path");
    //
    //         checkboxes.forEach(function (otherCheckbox) {
    //             if (otherCheckbox !== checkbox) {
    //                 otherCheckbox.checked = false;
    //                 let otherSvgPath = otherCheckbox.parentElement.querySelector(".css-79hxr7 path");
    //                 otherSvgPath.setAttribute("stroke", "#ddd");
    //                 otherSvgPath.setAttribute("fill", "#fff");
    //             }
    //         });
    //
    //         if (checkbox.checked) {
    //             svgPath.setAttribute("stroke", "#fff");
    //             svgPath.setAttribute("fill", "#5f0080");
    //         } else {
    //             svgPath.setAttribute("stroke", "#ddd");
    //             svgPath.setAttribute("fill", "#fff");
    //         }
    //     });
    // });
</script>
</body>
</html>
