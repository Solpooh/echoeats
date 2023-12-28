<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/product/css/main-css.css">
    <link rel="stylesheet" href="/resources/product/css/snow.css">
</head>
<body>
<script src="/resources/product/js/snow.js"></script>

<%@ include file="include/header.jspf" %>
<main>
    <div>
        <div class="swiper">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <img id="first-banner" src="/resources/images/second-banner.jpg">
                </div>
                <div class="swiper-slide">
                    <img src="/resources/images/ad2.jpg">
                </div>
                <div class="swiper-slide">
                    <img src="/resources/images/ad3.jpg">
                </div>
                <div class="swiper-slide">
                    <img src="/resources/images/ad4.jpg">
                </div>
                <div class="swiper-slide">
                    <img src="/resources/images/ad5.jpg">
                </div>
            </div>
        </div>
        <button id="btn_left" type="button"></button>
        <button id="btn_right" type="button"></button>
<%--        <div id="ad-page">--%>
<%--            <div>1/5</div>--%>
<%--        </div>--%>
    </div>
    <div id="main-01"> <!-- 슈퍼빅세일특가 -->
        <div class="SectionTitle">
            <a href="/christmas"><span>🎅${eventNo1.evt_gp_name}🎄</span>
                <span><img src="/resources/icons/arrow_right.svg"></span></a>
            <p>${eventNo1.evt_gp_dtl}</p>
        </div>
        <div class="SectionContent">
            <c:forEach var="product" items="${productList1}" begin="0" end="3">
                <div class="content">
                    <a href="${pageContext.request.contextPath}/product/${product.prod_id}" class="goProductEx">
                        <div class="image-container">
                            <span><img src="${product.prod_img_id}"></span>
<%--                            <div class="product-sticker"><span>골라담기특가</span></div>--%>
                        </div>
                        <div>
                            <button type="button" class="putProductButton">
                                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                    <path d="M1.53516 2.70001H3.93316L5.76816 10.609H13.6482L15.2992 4.35901H4.86916M12.8582 14.933C13.0098 14.9375 13.1609 14.9115 13.3024 14.8566C13.4438 14.8017 13.5728 14.7189 13.6817 14.6132C13.7906 14.5075 13.8771 14.381 13.9363 14.2412C13.9954 14.1015 14.0258 13.9513 14.0258 13.7995C14.0258 13.6478 13.9954 13.4975 13.9363 13.3578C13.8771 13.218 13.7906 13.0915 13.6817 12.9858C13.5728 12.8801 13.4438 12.7974 13.3024 12.7424C13.1609 12.6875 13.0098 12.6615 12.8582 12.666C12.5634 12.6748 12.2836 12.798 12.0782 13.0096C11.8727 13.2213 11.7578 13.5046 11.7578 13.7995C11.7578 14.0944 11.8727 14.3778 12.0782 14.5894C12.2836 14.801 12.5634 14.9243 12.8582 14.933ZM6.49316 14.933C6.64484 14.9375 6.79589 14.9115 6.93735 14.8566C7.07881 14.8017 7.20781 14.7189 7.31669 14.6132C7.42558 14.5075 7.51214 14.381 7.57126 14.2412C7.63037 14.1015 7.66083 13.9513 7.66083 13.7995C7.66083 13.6478 7.63037 13.4975 7.57126 13.3578C7.51214 13.218 7.42558 13.0915 7.31669 12.9858C7.20781 12.8801 7.07881 12.7974 6.93735 12.7424C6.79589 12.6875 6.64484 12.6615 6.49316 12.666C6.19836 12.6748 5.91858 12.798 5.71315 13.0096C5.50773 13.2213 5.39283 13.5046 5.39283 13.7995C5.39283 14.0944 5.50773 14.3778 5.71315 14.5894C5.91858 14.801 6.19836 14.9243 6.49316 14.933Z"
                                          stroke="#333333" stroke-linecap="square"
                                          stroke-linejoin="round"></path>
                                </svg>
                                담기
                            </button>
                        </div>
                        <div class="product-info">
                            <h3 class="product-name">${product.prod_name}</h3>
                            <div class="content-row">
                                <div class="product-price">
                                    <div>
                                        <span class="dimmed-price">
                                            <fmt:formatNumber value="${product.prod_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                    </div>
                                    <div class="discount">
                                        <span class="discount-rate">${product.disc_rate}%</span>
                                        <span class="sales-price">
                                            <fmt:formatNumber value="${product.disc_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="review-count">
                                <div class="review-icon">
                                    <svg width="100%" height="100%" viewBox="0 0 14 14" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <mask id="path-1-inside-1_1513_17755" fill="white">
                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                  d="M3 2C1.89543 2 1 2.89543 1 4V8.67201C1 9.77658 1.89543 10.672 3 10.672H5.11212L6.33682 12.7653C6.5299 13.0954 7.00688 13.0954 7.19995 12.7653L8.42465 10.672H10.5C11.6046 10.672 12.5 9.77658 12.5 8.67201V4C12.5 2.89543 11.6046 2 10.5 2H3Z"></path>
                                        </mask>
                                        <path fill="#999"
                                              d="M5.11212 10.672L5.97526 10.167L5.68564 9.67201H5.11212V10.672ZM6.33682 12.7653L5.47369 13.2703L5.47369 13.2703L6.33682 12.7653ZM7.19995 12.7653L6.33682 12.2604L6.33682 12.2604L7.19995 12.7653ZM8.42465 10.672V9.67201H7.85113L7.56152 10.167L8.42465 10.672ZM2 4C2 3.44772 2.44772 3 3 3V1C1.34315 1 0 2.34315 0 4H2ZM2 8.67201V4H0V8.67201H2ZM3 9.67201C2.44772 9.67201 2 9.22429 2 8.67201H0C0 10.3289 1.34315 11.672 3 11.672V9.67201ZM5.11212 9.67201H3V11.672H5.11212V9.67201ZM7.19995 12.2604L5.97526 10.167L4.24899 11.177L5.47369 13.2703L7.19995 12.2604ZM6.33682 12.2604C6.5299 11.9304 7.00688 11.9304 7.19995 12.2604L5.47369 13.2703C6.05291 14.2604 7.48386 14.2604 8.06309 13.2703L6.33682 12.2604ZM7.56152 10.167L6.33682 12.2604L8.06309 13.2703L9.28779 11.177L7.56152 10.167ZM10.5 9.67201H8.42465V11.672H10.5V9.67201ZM11.5 8.67201C11.5 9.22429 11.0523 9.67201 10.5 9.67201V11.672C12.1569 11.672 13.5 10.3289 13.5 8.67201H11.5ZM11.5 4V8.67201H13.5V4H11.5ZM10.5 3C11.0523 3 11.5 3.44772 11.5 4H13.5C13.5 2.34315 12.1569 1 10.5 1V3ZM3 3H10.5V1H3V3Z"
                                              mask="url(#path-1-inside-1_1513_17755)"></path>
                                        <circle fill="#999" cx="4.34998" cy="6.17871" r="0.75"></circle>
                                        <circle fill="#999" cx="6.75" cy="6.17871" r="0.75"></circle>
                                        <circle fill="#999" cx="9.15002" cy="6.17871" r="0.75"></circle>
                                    </svg>
                                </div>
                                <c:if test="${product.rev_num gt 9999}">
                                    <span class="review-number">9999+</span>
                                </c:if>
                                <c:if test="${product.rev_num le 9999}">
                                    <span class="review-number">${product.rev_num}</span>
                                </c:if>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div> <!-- SectionContent -->
    </div>
    <!-- 슈퍼빅세일 기획특가 -->
    <div class="mid-ad">
        <a href="#"><span>
                        <img src="/resources/images/mid-ad_banner01.jpg">
                    </span></a>
    </div>

    <div id="main-02">
        <div id="main-02-left">
            <div>
                <h2>${eventNo2.evt_gp_name}</h2>
                <h3>${eventNo2.evt_gp_dtl}</h3>
                <div>
                    <div class="lottie-timer">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 36 36" width="36" height="36"
                             preserveAspectRatio="xMidYMid meet"
                             style="width: 100%; height: 100%; transform: translate3d(0px, 0px, 0px);">
                            <defs>
                                <clipPath id="__lottie_element_2">
                                    <rect width="36" height="36" x="0" y="0"></rect>
                                </clipPath>
                            </defs>
                            <g clip-path="url(#__lottie_element_2)">
                                <g transform="matrix(1,0,0,1,3.75,3.75)" opacity="1" style="display: block;">
                                    <g opacity="1" transform="matrix(1,0,0,1,14.25,14.25)">
                                        <path fill="#00c73c" fill-opacity="1"
                                              d=" M14,0 C14,7.73199987411499 7.73199987411499,14 0,14 C-7.73199987411499,14 -14,7.73199987411499 -14,0 C-14,-7.73199987411499 -7.73199987411499,-14 0,-14 C7.73199987411499,-14 14,-7.73199987411499 14,0z"></path>
                                    </g>
                                    <g opacity="1" transform="matrix(1,0,0,1,0,0)">
                                        <path stroke-linecap="round" stroke-linejoin="round" fill-opacity="0"
                                              stroke="rgb(255,255,255)" stroke-opacity="1" stroke-width="2"
                                              d=" M14.25,8.293999671936035 C14.25,8.293999671936035 14.25,14.293999671936035 14.25,14.293999671936035"></path>
                                    </g>
                                    <g opacity="1" transform="matrix(1,0,0,1,0,0)" id="clockTime">
                                        <path stroke-linecap="round" stroke-linejoin="round" fill-opacity="0"
                                              stroke="rgb(255,255,255)" stroke-opacity="1" stroke-width="2"
                                              d=" M20.25,14.293999671936035 C20.25,14.293999671936035 14.25,14.293999671936035 14.25,14.293999671936035"></path>
                                    </g>
                                </g>
                            </g>
                        </svg>
                    </div>
                    <div class="time-units"><span id="hours"></span><span id="minutes"></span><span id="seconds"></span>
                    </div>
                </div>
                <p>망설이면 늦어요!</p>
            </div>
        </div>
        <div id="main-02-right">
            <c:forEach items="${productList2}" var="eventOneList" begin="0" end="2">
                <div class="content">
                    <a href="${pageContext.request.contextPath}/product/${eventOneList.prod_id}">
                        <div class="image-container">
                            <span><img src="${eventOneList.prod_img_id}"></span>
                            <div class="product-sticker"><span>일일특가</span></div>
                        </div>
                        <div>
                            <button type="button">
                                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                    <path d="M1.53516 2.70001H3.93316L5.76816 10.609H13.6482L15.2992 4.35901H4.86916M12.8582 14.933C13.0098 14.9375 13.1609 14.9115 13.3024 14.8566C13.4438 14.8017 13.5728 14.7189 13.6817 14.6132C13.7906 14.5075 13.8771 14.381 13.9363 14.2412C13.9954 14.1015 14.0258 13.9513 14.0258 13.7995C14.0258 13.6478 13.9954 13.4975 13.9363 13.3578C13.8771 13.218 13.7906 13.0915 13.6817 12.9858C13.5728 12.8801 13.4438 12.7974 13.3024 12.7424C13.1609 12.6875 13.0098 12.6615 12.8582 12.666C12.5634 12.6748 12.2836 12.798 12.0782 13.0096C11.8727 13.2213 11.7578 13.5046 11.7578 13.7995C11.7578 14.0944 11.8727 14.3778 12.0782 14.5894C12.2836 14.801 12.5634 14.9243 12.8582 14.933ZM6.49316 14.933C6.64484 14.9375 6.79589 14.9115 6.93735 14.8566C7.07881 14.8017 7.20781 14.7189 7.31669 14.6132C7.42558 14.5075 7.51214 14.381 7.57126 14.2412C7.63037 14.1015 7.66083 13.9513 7.66083 13.7995C7.66083 13.6478 7.63037 13.4975 7.57126 13.3578C7.51214 13.218 7.42558 13.0915 7.31669 12.9858C7.20781 12.8801 7.07881 12.7974 6.93735 12.7424C6.79589 12.6875 6.64484 12.6615 6.49316 12.666C6.19836 12.6748 5.91858 12.798 5.71315 13.0096C5.50773 13.2213 5.39283 13.5046 5.39283 13.7995C5.39283 14.0944 5.50773 14.3778 5.71315 14.5894C5.91858 14.801 6.19836 14.9243 6.49316 14.933Z"
                                          stroke="#333333" stroke-linecap="square"
                                          stroke-linejoin="round"></path>
                                </svg>
                                담기
                            </button>
                        </div>
                        <div class="product-info">
                            <h3 class="product-name">${eventOneList.prod_name}</h3>
                            <div class="content-row">
                                <div class="product-price">
                                    <div>
                                        <span class="dimmed-price">
                                            <fmt:formatNumber value="${eventOneList.prod_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                    </div>
                                    <div class="discount">
                                        <span class="discount-rate">${eventOneList.disc_rate}%</span>
                                        <span class="sales-price">
                                            <fmt:formatNumber value="${eventOneList.disc_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="review-count">
                                <div class="review-icon">
                                    <svg width="100%" height="100%" viewBox="0 0 14 14" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <mask id="path-1-inside-1_1513_17755" fill="white">
                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                  d="M3 2C1.89543 2 1 2.89543 1 4V8.67201C1 9.77658 1.89543 10.672 3 10.672H5.11212L6.33682 12.7653C6.5299 13.0954 7.00688 13.0954 7.19995 12.7653L8.42465 10.672H10.5C11.6046 10.672 12.5 9.77658 12.5 8.67201V4C12.5 2.89543 11.6046 2 10.5 2H3Z"></path>
                                        </mask>
                                        <path fill="#999"
                                              d="M5.11212 10.672L5.97526 10.167L5.68564 9.67201H5.11212V10.672ZM6.33682 12.7653L5.47369 13.2703L5.47369 13.2703L6.33682 12.7653ZM7.19995 12.7653L6.33682 12.2604L6.33682 12.2604L7.19995 12.7653ZM8.42465 10.672V9.67201H7.85113L7.56152 10.167L8.42465 10.672ZM2 4C2 3.44772 2.44772 3 3 3V1C1.34315 1 0 2.34315 0 4H2ZM2 8.67201V4H0V8.67201H2ZM3 9.67201C2.44772 9.67201 2 9.22429 2 8.67201H0C0 10.3289 1.34315 11.672 3 11.672V9.67201ZM5.11212 9.67201H3V11.672H5.11212V9.67201ZM7.19995 12.2604L5.97526 10.167L4.24899 11.177L5.47369 13.2703L7.19995 12.2604ZM6.33682 12.2604C6.5299 11.9304 7.00688 11.9304 7.19995 12.2604L5.47369 13.2703C6.05291 14.2604 7.48386 14.2604 8.06309 13.2703L6.33682 12.2604ZM7.56152 10.167L6.33682 12.2604L8.06309 13.2703L9.28779 11.177L7.56152 10.167ZM10.5 9.67201H8.42465V11.672H10.5V9.67201ZM11.5 8.67201C11.5 9.22429 11.0523 9.67201 10.5 9.67201V11.672C12.1569 11.672 13.5 10.3289 13.5 8.67201H11.5ZM11.5 4V8.67201H13.5V4H11.5ZM10.5 3C11.0523 3 11.5 3.44772 11.5 4H13.5C13.5 2.34315 12.1569 1 10.5 1V3ZM3 3H10.5V1H3V3Z"
                                              mask="url(#path-1-inside-1_1513_17755)"></path>
                                        <circle fill="#999" cx="4.34998" cy="6.17871" r="0.75"></circle>
                                        <circle fill="#999" cx="6.75" cy="6.17871" r="0.75"></circle>
                                        <circle fill="#999" cx="9.15002" cy="6.17871" r="0.75"></circle>
                                    </svg>
                                </div>
                                <c:if test="${eventOneList.rev_num gt 9999}">
                                    <span class="review-number">9999+</span>
                                </c:if>
                                <c:if test="${eventOneList.rev_num le 9999}">
                                    <span class="review-number">${eventOneList.rev_num}</span>
                                </c:if>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div> <!-- 슈퍼빅세일 일일 특가-->

    <div id="main-01"> <!-- 슈퍼빅세일특가 -->
        <div class="SectionTitle">
            <a href="#"><span>✨${eventNo3.evt_gp_name}✨</span>
                <span><img src="/resources/icons/arrow_right.svg"></span></a>
            <p>${eventNo3.evt_gp_dtl}</p>
        </div>
        <div class="SectionContent">
            <c:forEach var="product" items="${productList3}" begin="0" end="3">
                <div class="content">
                    <a href="${pageContext.request.contextPath}/product/${product.prod_id}">
                        <div class="image-container">
                            <span><img src="${product.prod_img_id}"></span>
<%--                            <div class="product-sticker"><span>골라담기특가</span></div>--%>
                        </div>
                        <div>
                            <button type="button">
                                <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
                                    <path d="M1.53516 2.70001H3.93316L5.76816 10.609H13.6482L15.2992 4.35901H4.86916M12.8582 14.933C13.0098 14.9375 13.1609 14.9115 13.3024 14.8566C13.4438 14.8017 13.5728 14.7189 13.6817 14.6132C13.7906 14.5075 13.8771 14.381 13.9363 14.2412C13.9954 14.1015 14.0258 13.9513 14.0258 13.7995C14.0258 13.6478 13.9954 13.4975 13.9363 13.3578C13.8771 13.218 13.7906 13.0915 13.6817 12.9858C13.5728 12.8801 13.4438 12.7974 13.3024 12.7424C13.1609 12.6875 13.0098 12.6615 12.8582 12.666C12.5634 12.6748 12.2836 12.798 12.0782 13.0096C11.8727 13.2213 11.7578 13.5046 11.7578 13.7995C11.7578 14.0944 11.8727 14.3778 12.0782 14.5894C12.2836 14.801 12.5634 14.9243 12.8582 14.933ZM6.49316 14.933C6.64484 14.9375 6.79589 14.9115 6.93735 14.8566C7.07881 14.8017 7.20781 14.7189 7.31669 14.6132C7.42558 14.5075 7.51214 14.381 7.57126 14.2412C7.63037 14.1015 7.66083 13.9513 7.66083 13.7995C7.66083 13.6478 7.63037 13.4975 7.57126 13.3578C7.51214 13.218 7.42558 13.0915 7.31669 12.9858C7.20781 12.8801 7.07881 12.7974 6.93735 12.7424C6.79589 12.6875 6.64484 12.6615 6.49316 12.666C6.19836 12.6748 5.91858 12.798 5.71315 13.0096C5.50773 13.2213 5.39283 13.5046 5.39283 13.7995C5.39283 14.0944 5.50773 14.3778 5.71315 14.5894C5.91858 14.801 6.19836 14.9243 6.49316 14.933Z"
                                          stroke="#333333" stroke-linecap="square"
                                          stroke-linejoin="round"></path>
                                </svg>
                                담기
                            </button>
                        </div>
                        <div class="product-info">
                            <h3 class="product-name">${product.prod_name}</h3>
                            <div class="content-row">
                                <div class="product-price">
                                    <div>
                                        <span class="dimmed-price">
                                            <fmt:formatNumber value="${product.prod_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                    </div>
                                    <div class="discount">
                                        <span class="discount-rate">${product.disc_rate}%</span>
                                        <span class="sales-price">
                                            <fmt:formatNumber value="${product.disc_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="review-count">
                                <div class="review-icon">
                                    <svg width="100%" height="100%" viewBox="0 0 14 14" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <mask id="path-1-inside-1_1513_17755" fill="white">
                                            <path fill-rule="evenodd" clip-rule="evenodd"
                                                  d="M3 2C1.89543 2 1 2.89543 1 4V8.67201C1 9.77658 1.89543 10.672 3 10.672H5.11212L6.33682 12.7653C6.5299 13.0954 7.00688 13.0954 7.19995 12.7653L8.42465 10.672H10.5C11.6046 10.672 12.5 9.77658 12.5 8.67201V4C12.5 2.89543 11.6046 2 10.5 2H3Z"></path>
                                        </mask>
                                        <path fill="#999"
                                              d="M5.11212 10.672L5.97526 10.167L5.68564 9.67201H5.11212V10.672ZM6.33682 12.7653L5.47369 13.2703L5.47369 13.2703L6.33682 12.7653ZM7.19995 12.7653L6.33682 12.2604L6.33682 12.2604L7.19995 12.7653ZM8.42465 10.672V9.67201H7.85113L7.56152 10.167L8.42465 10.672ZM2 4C2 3.44772 2.44772 3 3 3V1C1.34315 1 0 2.34315 0 4H2ZM2 8.67201V4H0V8.67201H2ZM3 9.67201C2.44772 9.67201 2 9.22429 2 8.67201H0C0 10.3289 1.34315 11.672 3 11.672V9.67201ZM5.11212 9.67201H3V11.672H5.11212V9.67201ZM7.19995 12.2604L5.97526 10.167L4.24899 11.177L5.47369 13.2703L7.19995 12.2604ZM6.33682 12.2604C6.5299 11.9304 7.00688 11.9304 7.19995 12.2604L5.47369 13.2703C6.05291 14.2604 7.48386 14.2604 8.06309 13.2703L6.33682 12.2604ZM7.56152 10.167L6.33682 12.2604L8.06309 13.2703L9.28779 11.177L7.56152 10.167ZM10.5 9.67201H8.42465V11.672H10.5V9.67201ZM11.5 8.67201C11.5 9.22429 11.0523 9.67201 10.5 9.67201V11.672C12.1569 11.672 13.5 10.3289 13.5 8.67201H11.5ZM11.5 4V8.67201H13.5V4H11.5ZM10.5 3C11.0523 3 11.5 3.44772 11.5 4H13.5C13.5 2.34315 12.1569 1 10.5 1V3ZM3 3H10.5V1H3V3Z"
                                              mask="url(#path-1-inside-1_1513_17755)"></path>
                                        <circle fill="#999" cx="4.34998" cy="6.17871" r="0.75"></circle>
                                        <circle fill="#999" cx="6.75" cy="6.17871" r="0.75"></circle>
                                        <circle fill="#999" cx="9.15002" cy="6.17871" r="0.75"></circle>
                                    </svg>
                                </div>
                                <c:if test="${product.rev_num gt 9999}">
                                    <span class="review-number">9999+</span>
                                </c:if>
                                <c:if test="${product.rev_num le 9999}">
                                    <span class="review-number">${product.rev_num}</span>
                                </c:if>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div> <!-- SectionContent -->

        <div id="main-01"> <!-- 슈퍼빅세일특가 -->
            <div class="SectionTitle">
                <a href="#"><span>🙇‍♀️️${eventNo4.evt_gp_name}🙇‍♂️</span>
                    <span><img src="/resources/icons/arrow_right.svg"></span></a>
                <p>${eventNo4.evt_gp_dtl}</p>
            </div>
            <div class="SectionContent">
                <c:forEach var="product" items="${productList4}" begin="0" end="3">
                    <div class="content">
                        <a href="${pageContext.request.contextPath}/product/${product.prod_id}">
                            <div class="image-container">
                                <span><img src="${product.prod_img_id}"></span>
<%--                                <div class="product-sticker"><span>골라담기특가</span></div>--%>
                            </div>
                            <div>
                                <button type="button">
                                    <svg width="18" height="18" viewBox="0 0 18 18" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <path d="M1.53516 2.70001H3.93316L5.76816 10.609H13.6482L15.2992 4.35901H4.86916M12.8582 14.933C13.0098 14.9375 13.1609 14.9115 13.3024 14.8566C13.4438 14.8017 13.5728 14.7189 13.6817 14.6132C13.7906 14.5075 13.8771 14.381 13.9363 14.2412C13.9954 14.1015 14.0258 13.9513 14.0258 13.7995C14.0258 13.6478 13.9954 13.4975 13.9363 13.3578C13.8771 13.218 13.7906 13.0915 13.6817 12.9858C13.5728 12.8801 13.4438 12.7974 13.3024 12.7424C13.1609 12.6875 13.0098 12.6615 12.8582 12.666C12.5634 12.6748 12.2836 12.798 12.0782 13.0096C11.8727 13.2213 11.7578 13.5046 11.7578 13.7995C11.7578 14.0944 11.8727 14.3778 12.0782 14.5894C12.2836 14.801 12.5634 14.9243 12.8582 14.933ZM6.49316 14.933C6.64484 14.9375 6.79589 14.9115 6.93735 14.8566C7.07881 14.8017 7.20781 14.7189 7.31669 14.6132C7.42558 14.5075 7.51214 14.381 7.57126 14.2412C7.63037 14.1015 7.66083 13.9513 7.66083 13.7995C7.66083 13.6478 7.63037 13.4975 7.57126 13.3578C7.51214 13.218 7.42558 13.0915 7.31669 12.9858C7.20781 12.8801 7.07881 12.7974 6.93735 12.7424C6.79589 12.6875 6.64484 12.6615 6.49316 12.666C6.19836 12.6748 5.91858 12.798 5.71315 13.0096C5.50773 13.2213 5.39283 13.5046 5.39283 13.7995C5.39283 14.0944 5.50773 14.3778 5.71315 14.5894C5.91858 14.801 6.19836 14.9243 6.49316 14.933Z"
                                              stroke="#333333" stroke-linecap="square"
                                              stroke-linejoin="round"></path>
                                    </svg>
                                    담기
                                </button>
                            </div>
                            <div class="product-info">
                                <h3 class="product-name">${product.prod_name}</h3>
                                <div class="content-row">
                                    <div class="product-price">
                                        <div><span class="dimmed-price">
                                            <fmt:formatNumber value="${product.prod_price}" pattern="#,###"/><span class="won">원</span>
                                        </span>
                                        </div>
                                        <div class="discount">
                                            <span class="discount-rate">${product.disc_rate}%</span>
                                            <span class="sales-price">
                                                <fmt:formatNumber value="${product.disc_price}" pattern="#,###"/><span class="won">원</span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="review-count">
                                    <div class="review-icon">
                                        <svg width="100%" height="100%" viewBox="0 0 14 14" fill="none"
                                             xmlns="http://www.w3.org/2000/svg">
                                            <mask id="path-1-inside-1_1513_17755" fill="white">
                                                <path fill-rule="evenodd" clip-rule="evenodd"
                                                      d="M3 2C1.89543 2 1 2.89543 1 4V8.67201C1 9.77658 1.89543 10.672 3 10.672H5.11212L6.33682 12.7653C6.5299 13.0954 7.00688 13.0954 7.19995 12.7653L8.42465 10.672H10.5C11.6046 10.672 12.5 9.77658 12.5 8.67201V4C12.5 2.89543 11.6046 2 10.5 2H3Z"></path>
                                            </mask>
                                            <path fill="#999"
                                                  d="M5.11212 10.672L5.97526 10.167L5.68564 9.67201H5.11212V10.672ZM6.33682 12.7653L5.47369 13.2703L5.47369 13.2703L6.33682 12.7653ZM7.19995 12.7653L6.33682 12.2604L6.33682 12.2604L7.19995 12.7653ZM8.42465 10.672V9.67201H7.85113L7.56152 10.167L8.42465 10.672ZM2 4C2 3.44772 2.44772 3 3 3V1C1.34315 1 0 2.34315 0 4H2ZM2 8.67201V4H0V8.67201H2ZM3 9.67201C2.44772 9.67201 2 9.22429 2 8.67201H0C0 10.3289 1.34315 11.672 3 11.672V9.67201ZM5.11212 9.67201H3V11.672H5.11212V9.67201ZM7.19995 12.2604L5.97526 10.167L4.24899 11.177L5.47369 13.2703L7.19995 12.2604ZM6.33682 12.2604C6.5299 11.9304 7.00688 11.9304 7.19995 12.2604L5.47369 13.2703C6.05291 14.2604 7.48386 14.2604 8.06309 13.2703L6.33682 12.2604ZM7.56152 10.167L6.33682 12.2604L8.06309 13.2703L9.28779 11.177L7.56152 10.167ZM10.5 9.67201H8.42465V11.672H10.5V9.67201ZM11.5 8.67201C11.5 9.22429 11.0523 9.67201 10.5 9.67201V11.672C12.1569 11.672 13.5 10.3289 13.5 8.67201H11.5ZM11.5 4V8.67201H13.5V4H11.5ZM10.5 3C11.0523 3 11.5 3.44772 11.5 4H13.5C13.5 2.34315 12.1569 1 10.5 1V3ZM3 3H10.5V1H3V3Z"
                                                  mask="url(#path-1-inside-1_1513_17755)"></path>
                                            <circle fill="#999" cx="4.34998" cy="6.17871" r="0.75"></circle>
                                            <circle fill="#999" cx="6.75" cy="6.17871" r="0.75"></circle>
                                            <circle fill="#999" cx="9.15002" cy="6.17871" r="0.75"></circle>
                                        </svg>
                                    </div>
                                    <c:if test="${product.rev_num gt 9999}">
                                        <span class="review-number">9999+</span>
                                    </c:if>
                                    <c:if test="${product.rev_num le 9999}">
                                        <span class="review-number">${product.rev_num}</span>
                                    </c:if>
                                </div>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div> <!-- SectionContent -->
        </div>
    </div>
</main>

<%@ include file="include/footer.jspf" %>

</div> <!--wrap center -->
</div> <!--wrap-->

<script src="/resources/product/js/main.js"></script>
</body>
</html>