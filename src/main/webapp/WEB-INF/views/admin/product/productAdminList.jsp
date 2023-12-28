<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>productList</title>
    <!-- <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" /> -->
    <link href="<c:url value='/resources/common/css/styles.css' />" rel="stylesheet" />
    <link href="<c:url value='/resources/admin/product/css/productAdminList.css'/>" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.esm.js"></script>
    <script nomodule src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/themes/default.css" />
    <script>
        $(function(){
            $('.start_date').val(fullDate(0));
            $('.end_date').val(fullDate(0));
            $('select[name=rows]').val('${ph.sc.pageSize}'); // 다시 확인할 것

            SearchCondition();

            $('select[name=rows]').change(function(){ // 다시 확인 할 것
                const ps = $('select[name=rows]').val();
                location.href = "/admin/product/list${ph.sc.getProductQueryString()}&pageSize="+ps;
            });

            $('.btnDate').click(function(e) {
                e.preventDefault();
                $('.btnDate').removeClass('selected');
                $(this).addClass('selected');

                let interval = e.target.closest('a.btnDate').getAttribute('date-interval');

                if (interval !== '-1') {
                    $('.start_date').val(fullDate(-interval));
                    $('.end_date').val(fullDate(0));
                    $('.duet-date__input').prop('disabled', false)
                } else {
                    $('.duet-date__input').prop('disabled', true)
                    $('duet-date-picker[name=start_date]').val('');
                    $('duet-date-picker[name=end_date]').val('');
                }
            });

            $('#search_button').click(function(e){
                e.preventDefault();

                if($('select[name=keyword_type]').val()=='choice'){
                    alert("검색어 항목을 선택해주세요.")
                    return;
                }
                $('.optionArea').submit();
            });

            $('.duet-date-picker-grid').click(function(e){
                $('.duet-date__input').prop('disabled', false)
                $('.btnDate').removeClass('selected');
            });
        });
        const SearchCondition = () => {
            if('${ph.sc.date_type}'!=''){
                $('select[name=date_type]').val('${ph.sc.date_type}').prop("selected", true);
            }
            if('${ph.sc.keyword_type}'!=''){
                $('select[name=keyword_type]').val('${ph.sc.keyword_type}').prop("selected", true);
            }
            if('${ph.sc.keyword}'!=''){
                $('input[name=keyword]').val('${ph.sc.keyword}');
            }
            if('${ph.sc.start_date}'!=''){
                const startDate = "<fmt:formatDate value='${ph.sc.start_date}' pattern='yyyy-MM-dd' type='date'/>";
                $('duet-date-picker[name=startDate]').val(startDate);
            }
            if('${ph.sc.end_date}'!=''){
                const endtDate = "<fmt:formatDate value='${ph.sc.end_date}' pattern='yyyy-MM-dd' type='date'/>";
                $('duet-date-picker[name=end_date]').val(endtDate);
            }
        }

        const fullDate = (d) => {
            const today = new Date();
            today.setDate(today.getDate() + d);
            const day = today.getDate();
            const month = today.getMonth() + 1;
            const year = today.getFullYear();
            return year + "-" + (month < 10 ? "0" + month : month) + "-" + (day < 10 ? "0" + day : day);
        }
    </script>
    <style>
        .pagination, .datatable-pagination ul {
            --bs-pagination-padding-x: 0.75rem;
            --bs-pagination-padding-y: 0.375rem;
            --bs-pagination-font-size: 1rem;
            --bs-pagination-color: #6c757d;
            --bs-pagination-bg: #fff;
            --bs-pagination-border-width: 1px;
            --bs-pagination-border-color: #dee2e6;
            --bs-pagination-border-radius: 0.375rem;
            --bs-pagination-hover-color: #00c73c;
            --bs-pagination-hover-bg: #e9ecef;
            --bs-pagination-hover-border-color: #dee2e6;
            --bs-pagination-focus-color: #00c73c;
            --bs-pagination-focus-bg: #e9ecef;
            --bs-pagination-focus-box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
            --bs-pagination-active-color: #fff;
            --bs-pagination-active-bg: #00c73c;
            --bs-pagination-active-border-color: #00c73c;
            --bs-pagination-disabled-color: #6c757d;
            --bs-pagination-disabled-bg: #fff;
            --bs-pagination-disabled-border-color: #dee2e6;
            display: flex;
            padding-left: 0;
            list-style: none;
        }
        .page-item .page-link {
            font-size: 12px;
        }
    </style>
</head>
<body class="sb-nav-fixed">
<%@include file="../../admin/include/top_side_nav.jspf" %>
<div id="layoutSidenav_content">
    <div class="container">
        <h2 class="mTitle">상품 조회/수정</h2>
        <form action="<c:url value='/admin/product/list'/>" class="optionArea" method="get">
            <!-- <div class="optionArea " id="QA_deposit1"> -->
            <div class="mOption">
                <table border="1">
                    <colgroup>
                        <col style="width:170px">
                        <col style="width:600px">
                        <col style="width:170px">
                        <col style="width:auto">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th scope="row">검색분류</th>
                        <td colspan="3">
                            <div id="mainSearch">
                                <div class="keywordSearchSelect">
                                    <select class="fSelect" name="keyword_type" style="width:163px;">
                                        <option value="ProductName">상품명</option>
                                        <option value="ProductNumber">상품번호</option>
                                        <option value="DeliveryType">배송속성</option>
                                        <option value="Brand">브랜드</option>
                                    </select>
                                    <input type="text" class="fText sBaseSearchBox eSearchText" name="keyword" id="sBaseSearchBox" style="width:400px;">
                                    <a href="#none" class="btnIcon icoPlus"><span>추가</span></a>

                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">상품분류</th>
                        <td colspan="3">
                            <div class="gSingle">
                                <select class="fSelect category eCategory" id="eCategory1" depth="1" name="bigCategory">
                                    <option name="bigCategory" value="">- 대분류 선택 -</option>
                                </select>
                                <select class="fSelect2 category eCategory" id="eCategory2" depth="2" name="midCategory">
                                    <option name="midCategory" value="">- 중분류 선택 -</option>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">상품등록일</th>
                        <td colspan="3">
                            <select name="date_type" style="width:115px;" class="fSelect disabled">
                                <option value="ProductRegisterDate">상품등록일</option>
                                <option value="ProductModifyDate">상품수정일</option>
                                <option value="saleStartDate">판매시작일</option>
                                <option value="saleEndDate">판매종료일</option>
                            </select>

                            <a href="#none" class="btnDate" date-interval="0"><span>오늘</span></a>
                            <a href="#none" class="btnDate" date-interval="3"><span>3일</span></a>
                            <a href="#none" class="btnDate" date-interval="7"><span>7일</span></a>
                            <a href="#none" class="btnDate" date-interval="30"><span>1개월</span></a>
                            <a href="#none" class="btnDate" date-interval="90"><span>3개월</span></a>
                            <a href="#none" class="btnDate" date-interval="365"><span>1년</span></a>
                            <a href="#none" class="btnDate selected" date-interval="-1"><span>전체</span></a>

                            <div class="duet-date-picker-grid  duet-date-theme-ec-new  sun">
                                <duet-date-picker first-day-of-week="0" name="start_date" identifier="startDate"
                                                  class="duet-date-picker start hydrated changePicker start_date" disabled></duet-date-picker>
                                <span>~</span>
                                <duet-date-picker first-day-of-week="0" name="end_date" identifier="endDate"
                                                  class="duet-date-picker end hydrated changePicker end_date" direction="left" disabled></duet-date-picker>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">판매상태</th>
                        <td colspan="3">
                            <label class="gSingleLabel eSelected"><input type="radio" class="fChk eDisplayStatus" name="selling" value="A" checked="&quot;checked&quot;"> 전체</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="selling" value="판매전"> 판매전</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="selling" value="판매중"> 판매중</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="selling" value="판매중지"> 판매중지</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="selling" value="판매종료"> 판매종료</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="selling" value="판매금지"> 판매금지</label>
                        </td>

                    </tr>
                    <tr>
                        <th scope="row">진열상태</th>
                        <td colspan="3">
                            <label class="gSingleLabel eSelected"><input type="radio" class="fChk eDisplayStatus" name="display" value="A" checked="&quot;checked&quot;"> 전체</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="display" value="Y"> 진열함</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="display" value="N"> 진열안함</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">재고상태</th>
                        <td colspan="3">
                            <label class="gSingleLabel eSelected"><input type="radio" class="fChk eDisplayStatus" name="Stock" value="A" checked="&quot;checked&quot;"> 전체</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="Stock" value="stockNormal"> 재고정상</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="Stock" value="stockLack"> 재고부족</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="Stock" value="stockOut"> 품절</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">재고수량</th>
                        <td colspan="3">
                            <ul class="mForm typeVer" id="eSearchFormStock">
                                <li>
                                    <input type="text" class="fText right eSearchText" style="width:60px;" value="" name="stock_min"> 개 ~
                                    <input type="text" class="fText right eSearchText" style="width:60px;" value="" name="stock_max"> 개
                                    <a href="#none" class="btnIcon icoMinus" search-type="stock"><span>삭제</span></a>
                                    <a href="#none" class="btnIcon icoPlus" search-type="stock" style=""><span>추가</span></a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">상품가격</th>
                        <td colspan="3">
                            <ul class="mForm typeVer" id="eSearchFormPrice">
                                <li>
                                    <select class="fSelect" name="priceKind">
                                        <option value="product" selected="selected">판매가</option>
                                        <option value="custom">할인가</option>
                                    </select>
                                    <input type="text" class="fText right eSearchText" style="width:60px;" value="" name="price_min"> <span class="txtCode">KRW</span> ~
                                    <input type="text" class="fText right eSearchText" style="width:60px;" value="" name="price_max"> <span class="txtCode">KRW</span>
                                    <a href="#none" class="btnIcon icoMinus" search-type="price"><span>삭제</span></a>
                                    <a href="#none" class="btnIcon icoPlus" search-type="price" style=""><span>추가</span></a>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">옵션상품</th>
                        <td colspan="3">
                            <label class="gSingleLabel eSelected"><input type="radio" class="fChk eDisplayStatus" name="option" value="A" checked="&quot;checked&quot;"> 전체</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="option" value="Y"> 옵션있음</label>&nbsp;
                            <label class="gSingleLabel"><input type="radio" class="fChk eDisplayStatus" name="option" value="N"> 옵션없음</label>
                        </td>
                    </tr>
                    <tr>
                    </tbody>
                </table>
            </div>

            <div class="mOptionToogle">
                <div class="ctrl" style="float:right;position:relative;">
<%--                    <span class=""><button type="button" class="eOrdToogle" textopen="상세검색 열기" textclose="상세검색 닫기">상세검색 열기</button></span>--%>
                </div>
            </div>
            <div class="mButton gCenter">
                <a href="#none" id="search_button" class="btnSearch"><span>검색</span></a>
                <a href="#none" id="eSaveSearchForm" class="btnSearch save"><span>검색 조건 저장</span></a>
                <a href="#none" id="eBtnInit" class="btnSearch reset"><span>초기화</span></a>
                <!-- <div id="ordProgress" class="mLoading">
                    <p>처리중입니다. 잠시만 기다려 주세요.</p>
                    <img src="//img.echosting.cafe24.com/suio/ico_loading.gif" alt="">
                </div> -->
            </div>

        <div id="tabNumber" class="tabCont">
            <div class="mCtrl typeHeader">
                <div class="gTop">
                    <select class="btnNormal" name="saleStatus">
                        <option value="">판매변경</option>
                        <option value="판매전">판매전</option>
                        <option value="판매중">판매중</option>
                        <option value="판매중지">판매중지</option>
                        <option value="판매종료">판매종료</option>
                        <option value="판매금지">판매금지</option>
                    </select>
                    <select class="btnNormal" name="displayStatus">
                        <option value="">진열변경</option>
                        <option value="Y">진열함</option>
                        <option value="N">진열안함</option>
                    </select>
                    <a href="#eNaverCheckoutOrderStatus" data-status="eShipStartBtn" id="eShipStartBtn"
                       class="btnNormal"><span>판매가 변경</span></a>
                    <a href="#eNaverCheckoutOrderStatus" data-status="eSaveAllInvoiceNo" id="eSaveAllInvoiceNo"
                       class="btnNormal"><span>판매기간 변경</span></a>
                    <button type="submit" class="btnNormal" id="updateButton"><span>수정</span></button>
                </div>
            </div>
            <div class="mCtrl typeSetting setting">
                <div class="gLeft">
                    <div class="total">검색결과 : <strong>${totalCount}</strong>건
                </div>
            </div>
                <div class="gRight">
                    <select name="searchSorting" class="fSelect">
                        <option value="settle_price_asc">상품명순</option>
                        <option value="settle_price_desc">판매가 낮은순</option>
                        <option value="settle_price_desc">판매가 높은순</option>
                        <option value="order_asc" selected="">상품등록일순</option>
                        <option value="order_desc">상품수정일순</option>
                        <option value="order_desc">판매시작일순</option>
                        <option value="order_desc">판매종료일순</option>
                    </select>
                    <select name="rows" class="fSelect" init_rows="20">
                        <option value="10" selected="">10개씩보기</option>
                        <option value="20">20개씩보기</option>
                        <option value="30">30개씩보기</option>
                        <option value="50">50개씩보기</option>
                        <option value="100">100개씩보기</option>
                        <option value="200">200개씩보기</option>
                        <option value="300">300개씩보기</option>
                        <option value="500">500개씩보기</option>
                    </select>
                </div>
                <div class="gSetting">
                    <div class="mOpen">
                        <a href="#listSubject" class="btnSetting eOpenClick"><span>설정</span></a>
                        <div id="listSubject" class="open">
                            <strong>목록표시</strong>
                            <div class="wrap">
                                <ul class="default">
                                    <li><label><input type="checkbox" id="iDisplayNo" class="fChk" value="21"> No</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="2"> 상품번호</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="3" disabled="disabled"> 상품명</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="4"> 판매상태</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="5"> 전시상태</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="7"> 재고상태</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="8"> 재고수량</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="9"> 판매가</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="10"> 할인가</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="11"> 옵션상품</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="12"> 배송속성</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="13"> 대분류</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="14"> 중분류</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="15"> 브랜드명</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="15"> 상품등록일</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="15"> 최종수정일</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="15"> 판매시작일</label></li>
                                    <li><label class=" eSelected"><input type="checkbox" class="fChk" value="15"> 판매종료일</label></li>
                                    <li><label><input type="checkbox" class="fChk" value="17"> 메모</label></li>
                                </ul>
                            </div>
                            <div class="footer">
                                <a href="#none" id="eListControlLayer" class="btnCtrl"><span>적용</span></a>
                                <a href="#none" class="btnNormal eClose"><span>닫기</span></a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div id="searchResultList" class="mBoard typeOrder typeList gScroll gCellSingle">
                <table border="1" summary="" class="thead">
                    <caption>전체상품 조회 목록</caption>
                    <thead>
                    <tr>
                        <th scope="col" class="w24"><input type="checkbox" id="allChk"></th>
                        <th scope="col" class="w50" style="display:none;">No</th>
                        <th scope="col" class="w120" style="">상품번호</th>
                        <th scope="col" class="w290" style="">상품명</th>
                        <th scope="col" class="w95" style="">판매상태 <div class="cTip eSmartMode" code="OD.AO.170"></div></th>
                        <th scope="col" class="w95" style="">전시상태</th>
                        <th scope="col" class="w95" style="">재고상태</th>
                        <th scope="col" class="w95" style="">재고수량</th>
                        <th scope="col" class="w95" style="">판매가</th>
                        <th scope="col" class="w95" style="">할인가</th>
                        <th scope="col" class="w77" style="">옵션상품</th>
                        <th scope="col" class="w95" style="">배송속성</th>
                        <th scope="col" class="w150" style="">대분류</th>
                        <th scope="col" class="w150" style="">중분류</th>
                        <th scope="col" class="w77" style="">브랜드명</th>
                        <th scope="col" class="w150" style="">상품등록일</th>
                        <th scope="col" class="w150" style="">상품수정일</th>
                        <th scope="col" class="w150" style="">판매시작일</th>
                        <th scope="col" class="w150" style="">판매종료일</th>
<%--                        <th scope="col" class="w35" style="display:none;">메모</th>--%>
                    </tr>
                    </thead>
                    <c:if test="${not empty product}">
                        <tbody>
                        <c:forEach var="product" items="${product}">
                            <tr>
                                <c:forEach var="category" items="${category}">
                                    <c:if test="${product.cat_code eq category.cat_code}">
                                        <c:set var="cateCodeName" value="${category.cat_name}"/>
                                        <c:set var="parentCode" value="${category.parent_code}"/>
                                    </c:if>
                                </c:forEach>
                                <td scope="col" class="w24"><input type="checkbox" id="allChk" name="selectProductId" value="${product.prod_id}"></td>
                                <td scope="col" class="w50" style="display:none;">No</td>
                                <td scope="col" class="w120" style="">${product.prod_id}</td>
                                <td id="imgTd" scope="col" class="w150" style="">
                                    <div class="imgId"><img class="productImg" src="${product.prod_img_id}" alt="상품 이미지">
                                        <div class="prodName">${product.prod_name}</div>
                                    </div>
                                </td>
                                <td scope="col" class="w95" style="">${product.sale_sts} <div class="cTip eSmartMode" code="OD.AO.170"></div></td>
                                <td scope="col" class="w95" style="">${product.disp_sts}</td>
                                <td scope="col" class="w95" style="">
                                    <c:choose>
                                        <c:when test="${product.prod_qty > 50}">
                                            재고정상
                                        </c:when>
                                        <c:when test="${product.prod_qty eq 0}">
                                            품절
                                        </c:when>
                                        <c:otherwise>
                                            재고부족
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td scope="col" class="w95" style="">${product.prod_qty}</td>
                                <td scope="col" class="w95" style="">${product.prod_price}</td>
                                <td scope="col" class="w95" style="">${product.disc_price}</td>
                                <td scope="col" class="w77" style="">${product.is_opt}</td>
                                <td scope="col" class="w95" style="">${product.dlvy_type}</td>
                                <td scope="col" class="w150" style="">
                                    <c:forEach var="category" items="${category}">
                                        <c:if test="${parentCode eq category.cat_code}">
                                            ${category.cat_name}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td scope="col" class="w150" style="">${cateCodeName}</td>
                                <td scope="col" class="w77" style="">${product.brand}</td>
                                <td scope="col" class="w150" style=""><fmt:formatDate value="${product.prod_rg_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></td>
                                <td scope="col" class="w150" style=""><fmt:formatDate value="${product.prod_mod_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></td>
                                <td scope="col" class="w150" style=""><fmt:formatDate value="${product.sel_str_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></td>
                                <td scope="col" class="w150" style=""><fmt:formatDate value="${product.sel_end_date}" pattern="yyyy-MM-dd HH:mm:ss" type="date"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </c:if>
                    <c:if test="${empty product}">
                        <tbody class="empty">
                        <tr>
                            <td colspan="15">검색된 상품목록이 없습니다.</td>
                        </tr>
                        </tbody>
                    </c:if>
                </table>
            </div>
            <div class="mPaginate d-flex justify-content-center" style="width: 1000px;">
                <ul class="pagination">
                    <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
                        <c:if test="${ph.showPrev}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value="/admin/product/list${ph.sc.getProductQueryString(ph.beginPage-1)}"/>">&lt;</a>
                            </li>
                        </c:if>
                        <c:forEach var="pageNumber" begin="${ph.beginPage}" end="${ph.endPage}">
                            <li class="page-item ${pageNumber == ph.sc.page? "active" : ""}"><a class="page-link" href="<c:url value="/admin/product/list${ph.sc.getProductQueryString(pageNumber)}"/>">${pageNumber}</a></li>
                        </c:forEach>
                        <c:if test="${ph.showNext}">
                            <li class="page-item">
                                <a class="page-link" href="<c:url value="/admin/product/list${ph.sc.getProductQueryString(ph.endPage+1)}"/>">&gt;</a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
            </div>
        </div>
        </form> <!--option -->
    </div> <!-- context -->

    <footer class="py-4 bg-light mt-auto">
        <div class="container-fluid px-4">
            <div class="d-flex align-items-center justify-content-between small">
                <div class="text-muted">Copyright &copy; Your Website 2023</div>
                <div>
                    <a href="#">Privacy Policy</a>
                    &middot;
                    <a href="#">Terms &amp; Conditions</a>
                </div>
            </div>
        </div>
    </footer>
</div>
</div>
<script>

    let categoryList = JSON.parse('${categoryList}');

    const pickers = document.querySelectorAll(".duet-date-picker")
    pickers.forEach(picker => {
        picker.localization = {
            dayNames: [
                "일", "월", "화", "수",
                "목", "금", "토"
            ],
            monthNames: [
                "1월", "2월", "3월", "4월",
                "5월", "6월", "7월", "8월",
                "9월", "10월", "11월", "12월"
            ],
            monthNamesShort: [
                "1월", "2월", "3월", "4월",
                "5월", "6월", "7월", "8월",
                "9월", "10월", "11월", "12월"
            ],
            locale: "ko-KR",
        }
    });

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="<c:url value='/resources/common/js/scripts.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-area-demo.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-bar-demo.js' />"></script>
<script src="<c:url value='/resources/common/js/datatables-simple-demo.js' />"></script>
<script src="/resources/product/js/productAdmin.js"></script>
</body>
</html>