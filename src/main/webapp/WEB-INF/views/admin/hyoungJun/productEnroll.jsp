<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>상품등록페이지</title>
    <!-- <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" /> -->
    <link href="<c:url value='/resources/common/css/styles.css' />" rel="stylesheet"/>
    <link href="<c:url value='/resources/admin/order/css/orderList.css' />" rel="stylesheet"/>
    <link rel="stylesheet" href="/resources/css/admin/productEnroll.css">
    <%-- 달력 위젯을 위한 스타일 시트 --%>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"/>

    <script src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script type="module" src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.esm.js"></script>
    <script nomodule src="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/duet.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@duetds/date-picker@1.4.0/dist/duet/themes/default.css"/>
    <%-- 위지윅을 위한 script src --%>
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js"></script>
    <%-- 달력위젯을 위한 script src --%>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
</head>
<body class="sb-nav-fixed">
<%@include file="../include/top_side_nav.jspf" %>
<div id="layoutSidenav_content">

    <!-- contents-area -->
    <form action="<c:url value='/admin/hyoungJun/productEnroll'/>" method="post" id="enrollForm"
          enctype="multipart/form-data">
        <%--        <form action="<c:url value='/admin/hyoungJun/productEnroll'/>" method="post" enctype="multipart/form-data">--%>
        <div class="seller-content">
            <div id="productFormNavbar" class="seller-sub-title">
                <div class="pull-left">
                    <h2 class="title">상품등록</h2>
                </div>
            </div>
            <div class="seller-sub-content">
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">카테고리</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <span>대분류</span>
                            <select class="cate1">
                                <option selected value="none">선택</option>
                            </select>
                        </div>
                        <div class="form-sub-wrap">
                            <span>중분류</span>
                            <select class="cate2" name="cat_code">
                                <option selected value="none">선택</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">상품명</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <div class="input-group">
                                <div class="seller-input-wrap">
                                    <input name="prod_name" type="text"
                                           class="form-control" maxlength="99"
                                           title="상품명 입력" value="">
                                </div>
                                <span class="input-group-addon"><span class="text-primary">0</span>/100</span>
                            </div>
                            <p class="has-error error-msg sub-text text-danger name-warn">
                                <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                필수 정보입니다.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">판매가</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <label class="control-label">판매가</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="prod_price" class="form-control" placeholder="숫자만 입력"
                                                       type="number">
                                            </div>
                                            <span class="input-group-addon">원</span>
                                        </div>
                                        <p class="has-error error-msg sub-text text-danger price-warn">
                                            <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                            필수 정보입니다.
                                        </p>
                                        <p class="has-error error-msg sub-text text-danger price-unit-warn">
                                            <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                            10원 단위로 입력해주세요.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">할인</label>
                            <div class="input-content">
                                <div class="seller-input-toggle">
                                    <input type="radio" id="discount-choice-type-true"
                                           name="discount-choice-type" value="true">
                                    <label for="discount-choice-type-true">설정함</label>
                                    <input type="radio" id="discount-choice-type-false"
                                           name="discount-choice-type" value="false" checked>
                                    <label for="discount-choice-type-false">설정안함</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-sub-detail" id="discount-div">
                            <div class="form-sub-detail-wrap">
                                <label class="control-label">기본할인</label>
                                <div class="input-content">
                                    <div class="form-control-static">
                                        <span class="sub-text text-primary">판매가에서 즉시 할인이 가능하고 할인된 가격으로 상품을 판매할 수 있습니다.</span>
                                    </div>
                                    <div>
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <div class="seller-input-wrap">
                                                        <input id="discount-interface" class="form-control"
                                                               placeholder="판매가에서" max="99" min="0"
                                                               value="0" name="disc_rate"
                                                               type="number">
                                                        <input name="discount-rate" type="hidden" value="0">
                                                    </div>
                                                    <span class="input-group-addon">%</span>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <span class="text-sub">할인</span>
                                            </div>
                                        </div>
                                        <hr class="line">
                                        <div class="total-price">
                                            <label class="control-label">
                                                <span class="text info">할인가</span>
                                            </label>
                                            <div class="input-content">
                                                <p class="text-info text-price">
                                                    <span class="span_discount">0</span>
                                                    <input type="hidden" name="disc_price" value="">
                                                    <em>원</em> (<span class="span_discounting">0</span> 할인)
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">판매기간</label>
                            <div class="input-content">
                                <div class="seller-input-toggle">
                                    <input type="radio" id="salePeriod-choice-type-true"
                                           name="sale_sts" value="판매중">
                                    <label for="salePeriod-choice-type-true">설정함</label>
                                    <input type="radio" id="salePeriod-choice-type-false"
                                           name="sale_sts" value="판매전" checked>
                                    <label for="salePeriod-choice-type-false">설정안함</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-sub-detail" id="salePeriod-div">
                            <div class="form-sub-detail-wrap">
                                <label class="control-label">기간설정</label>
                                <div class="input-content">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-primary2" data-days="3">3일</button>
                                                <button type="button" class="btn btn-primary2" data-days="5">5일</button>
                                                <button type="button" class="btn btn-primary2" data-days="7">7일</button>
                                                <button type="button" class="btn btn-primary2" data-days="15">15일
                                                </button>
                                                <button type="button" class="btn btn-primary2" data-days="30">30일
                                                </button>
                                                <button type="button" class="btn btn-primary2" data-days="60">60일
                                                </button>
                                                <button type="button" class="btn btn-primary2" data-days="90">90일
                                                </button>
                                                <button type="button" class="btn btn-primary2" data-days="120">120일
                                                </button>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="seller-calendar">
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <input name="sel_str_date" autocomplete="off"
                                                                   readonly="readonly" class="form-control">
                                                            <span class="input-group-addon">
                                                            <a role="button" href></a>
                                                        </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group dash">
                                                        <div class="input-group">
                                                            <span class="input-group-addon">~</span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="input-group">
                                                            <input name="sel_end_date" autocomplete="off"
                                                                   readonly="readonly" class="form-control">
                                                            <span class="input-group-addon">
                                                                <a role="button" href></a>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">재고수량</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="prod_qty" class="form-control" type="number"
                                                       placeholder="숫자만 입력">
                                            </div>
                                            <span class="input-group-addon">개</span>
                                        </div>
                                    </div>
                                    <%--                                    <div class="form-group">--%>
                                    <%--                                        <p class="sub-text text-primary mg-reset">옵션 재고수량을 사용하면, 옵션의 재고수량으로 적용되어--%>
                                    <%--                                            자동으로 입력됩니다.</p>--%>
                                    <%--                                    </div>--%>
                                </div>
                            </div>
                            <p class="has-error error-msg sub-text text-danger qty-warn">
                                <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                필수 정보입니다.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">옵션</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <label class="control-label">옵션 유무</label>
                            <div class="input-content">
                                <div class="seller-input-toggle">
                                    <input type="radio" id="option-choice-type-true"
                                           name="is_opt" value="Y">
                                    <label for="option-choice-type-true">설정함</label>
                                    <input type="radio" id="option-choice-type-false"
                                           name="is_opt" value="N" checked>
                                    <label for="option-choice-type-false">설정안함</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-sub-detail" id="option-div">
                            <div class="form-sub-detail-wrap">
                                <label class="control-label">옵션 입력</label>
                                <div class="input-content">
                                    <div class="seller-option-input">
                                        <div class="option-wrap">
                                            <div class="col-sm-3">
                                                <label for="choice_option_name0">옵션</label>
                                                <div class="seller-input-wrap">
                                                    <input type="text" class="form-control" id="choice_option_name0"
                                                           placeholder="최소 2개이상 입력" maxlength="25" readonly>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <label for="choice_option_value0">옵션값</label>
                                                <div class="seller-input-wrap">
                                                    <input type="text" class="form-control"
                                                           id="choice_option_value0"
                                                           placeholder="예시 : 빨강, 노랑(,로 구분)">
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <label class="hidden-xs"></label>
                                                <%--                                                <a role="button" href class="btn btn-default">--%>
                                                <%--                                                    <i class="seller-icon icon-minus"></i>--%>
                                                <%--                                                </a>--%>
                                                <%--                                                <a role="button" href class="btn btn-single">--%>
                                                <%--                                                    <i class="seller-icon icon-plus"></i>--%>
                                                <%--                                                </a>--%>
                                            </div>
                                        </div>
                                        <div class="option-wrap">
                                            <div class="col-sm-3">
                                                <a role="button" href="#" class="btn btn-primary btn-block"
                                                   id="applyOptionList">
                                                    옵션목록으로 적용 ↓
                                                </a>
                                            </div>
                                            <div class="col-sm-9"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-sub-detail-wrap seller-option-list">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <label class="control-label">옵션 목록</label>
                                    </div>
                                </div>
                                <div class="col-sm-12 input-content">
                                    <div class="clearfix">
                                        <div class="pull-left">
                                            <a role="button" href
                                               class="btn btn-default btn-sm"
                                               id="choice-delete">
                                                선택삭제
                                            </a>
                                        </div>
                                        <div class="pull-right">
                                            <%--                                            <div class="form-inline">--%>
                                            <%--                                                <div class="form-group">--%>
                                            <%--                                                    옵션가--%>
                                            <%--                                                </div>--%>
                                            <%--                                                <div class="form-group">--%>
                                            <%--                                                    <div class="input-group">--%>
                                            <%--                                                        <div class="input-group-btn">--%>
                                            <%--                                                            <button class="btn btn-default--%>
                                            <%--                                                        btn-sm dropdown-toggle"--%>
                                            <%--                                                                    data-toggle="dropdown" type="button"--%>
                                            <%--                                                                    aria-expanded="false">+ <span--%>
                                            <%--                                                                    class="caret"></span>--%>
                                            <%--                                                            </button>--%>
                                            <%--                                                        </div>--%>
                                            <%--                                                        <div class="seller-input-wrap">--%>
                                            <%--                                                            <input type="tel" class="form-control input-sm"--%>
                                            <%--                                                                   maxlength="12">--%>
                                            <%--                                                        </div>--%>
                                            <%--                                                    </div>--%>
                                            <%--                                                </div>--%>
                                            <%--                                                <div class="form-group">재고수량</div>--%>
                                            <%--                                                <div class="form-group">--%>
                                            <%--                                                    <div class="input-group">--%>
                                            <%--                                                        <div class="seller-input-wrap">--%>
                                            <%--                                                            <input type="tel" class="form-control input-sm"--%>
                                            <%--                                                                   maxlength="12">--%>
                                            <%--                                                        </div>--%>
                                            <%--                                                    </div>--%>
                                            <%--                                                </div>--%>
                                            <%--                                                <div class="form-group">사용여부</div>--%>
                                            <%--                                                <div class="form-group">--%>
                                            <%--                                                    <div class="input-group">--%>
                                            <%--                                                        <div class="input-group-btn">--%>
                                            <%--                                                            <button class="btn btn-default--%>
                                            <%--                                                        btn-sm dropdown-toggle"--%>
                                            <%--                                                                    data-toggle="dropdown" type="button"--%>
                                            <%--                                                                    aria-expanded="false">Y <span--%>
                                            <%--                                                                    class="caret"></span>--%>
                                            <%--                                                            </button>--%>
                                            <%--                                                        </div>--%>
                                            <%--                                                    </div>--%>
                                            <%--                                                </div>--%>
                                            <%--                                                <div class="form-group">--%>
                                            <%--                                                    <a role="button" href class="btn btn-default2 btn-sm">선택목록--%>
                                            <%--                                                        일괄수정</a>--%>
                                            <%--                                                </div>--%>
                                            <%--                                            </div>--%>
                                        </div>
                                    </div>
                                    <div class="seller-grid-area ag-theme-fresh has-space-top"
                                         style="width:100%; height: 300px;">
                                        <table id="myTable">
                                            <thead>
                                            <tr>
                                                <th><input type="checkbox" id="checkAll">
                                                    <label for="checkAll"></label></th>
                                                <th>옵션명</th>
                                                <th>옵션가</th>
                                                <th>옵션할인된가격</th>
                                                <th>재고수량</th>
                                                <th>판매상태</th>
                                                <th>사용여부</th>
                                                <th>삭제</th>
                                            </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>

                                    </div>
                                    <div class="btn-block"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">상품 이미지</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap" id="img-wrap-wrap">
                            <div class="input-content" id="img-wrap">
                                <input type="file" id="fileItem" name="prod_img" style="height: 30px;"
                                       accept="image/jpg, image/jpeg, image/png, image/bmp"
                                       class="img-input" onchange="handleFiles(this.files)">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">소개글</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <textarea name="short_desc" id="short_desc_textarea"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">상세설명</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <textarea name="long_desc" id="long_desc_textarea"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">상품 주요정보</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <label class="control-label">브랜드</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="brand-input-wrap">
                                                <input name="brand" class="form-control" type="text"
                                                       placeholder="상품의 브랜드를 정확하게 입력해주세요.">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger brand-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">원산지</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="origin" class="form-control" type="text"
                                                       placeholder="ex) 국산 , 필리핀">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger origin-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">배송 타입</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="dlvy_type" class="form-control" type="text"
                                                       placeholder="ex) 에코배송">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger dlvy-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">판매자</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="seller" class="form-control" type="text"
                                                       placeholder="ex) 에코">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger seller-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">포장타입</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="pack_type" class="form-control" type="text"
                                                       placeholder="ex) 냉동 or 냉장">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger pack-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">판매단위</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="sales_unit" class="form-control" type="text"
                                                       placeholder="팩이면 1팩, 낱개면 1개">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger sales-unit-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">중량/용량</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="weight" class="form-control" type="text"
                                                       placeholder="단위까지 정확하게 입력">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger weight-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">유통기한</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="exp_date" class="form-control"
                                                       placeholder="ex) 상온 상태 시 2년 이내">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger exp-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                        <div class="form-sub-wrap">
                            <label class="control-label">안내사항</label>
                            <div class="input-content">
                                <div class="form-inline">
                                    <div class="form-group">
                                        <div class="input-group">
                                            <div class="seller-input-wrap">
                                                <input name="as_guide" class="form-control" type="text"
                                                       placeholder="안내할 사항을 입력">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <p class="has-error error-msg sub-text text-danger guide-warn">
                                    <i class="seller-icon icon-slash-circle" aria-hidden="true"></i>
                                    필수 정보입니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-section">
                    <div class="title-line" role="button">
                        <label class="col-sm-2 control-label">전시상태</label>
                        <div class="set-option">
                            <a href class="btn active"></a>
                        </div>
                    </div>
                    <div class="form-section-sub">
                        <div class="form-sub-wrap">
                            <label class="control-label">전시상태</label>
                            <div class="input-content">
                                <div class="seller-input-toggle">
                                    <input type="radio" id="display-choice-type-true"
                                           name="disp_sts" value="Y">
                                    <label for="display-choice-type-true">설정함</label>
                                    <input type="radio" id="display-choice-type-false"
                                           name="disp_sts" value="N">
                                    <label for="display-choice-type-false">설정안함</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="seller-btn-area btn-group-xlg">
                <button type="button" class="btn btn-default" id="cancelBtn">취소</button>
                <button type="submit" class="btn btn-primary enroll-btn">
                    <span class="content" id="enrollBtn">저장하기</span>
                </button>
            </div>
        </div>
    </form>
    <%--    </form>--%>
</div>

<script>

    // 위지윅 적용
    // 상품 소개글
    ClassicEditor
        .create(document.querySelector('#short_desc_textarea'))
        .catch(error => {
            console.error(error);
        });

    // 상품 상세설명
    ClassicEditor
        .create(document.querySelector('#long_desc_textarea'))
        .catch(error => {
            console.error(error);
        });

    // 달력 위젯 적용
    /* 설정 */
    const config = {
        dateFormat: 'yy-mm-dd'
    }

    $(function () {
        $("input[name='sel_str_date']").datepicker(config);
    });

    $(function () {
        $("input[name='sel_end_date']").datepicker(config);
    });

    let enrollForm = document.getElementById('enrollForm');

    // 취소버튼
    $('#cancelBtn').click((e) => {
        e.preventDefault();
        location.href = '/admin/dashborad';
    });

    // 등록 버튼
    $('#enrollBtn').click((e) => {
        e.preventDefault();
        if (productNameInput.value.length === 0) {
            alert('상품명을 입력해주세요.');
            return;
        }

        if (priceCheck === false) {
            alert('판매가를 입력해주세요.');
            return;
        }

        if (qtyCheck === false) {
            alert('재고수량을 입력해주세요.');
            return;
        }

        if (brandCheck === false) {
            alert('브랜드를 입력해주세요.');
            return;
        }

        if (originCheck === false) {
            alert('원산지를 입력해주세요.');
            return;
        }

        if (dlvyCheck === false) {
            alert('배송타입을 입력해주세요.');
            return;
        }

        if (sellerCheck === false) {
            alert('판매자를 입력해주세요.');
            return;
        }

        if (packCheck === false) {
            alert('포장타입을 입력해주세요.');
            return;
        }

        if (salesUnitCheck === false) {
            alert('판매단위를 입력해주세요.');
            return;
        }

        if (weightCheck === false) {
            alert('중량/용량을 입력해주세요.');
            return;
        }

        if (expCheck === false) {
            alert('유통기한을 입력해주세요.');
            return;
        }

        if (guideCheck === false) {
            alert('안내사항을 입력해주세요.');
            return;
        }

        enrollForm.submit();
    });

    // 카테고리 리스트
    let categoryList = JSON.parse('${categoryList}');

    let cate1Array = [];
    let cate2Array = [];
    let cate1Object = {};
    let cate2Object = {};

    let cate1Select = $('.cate1');
    let cate2Select = $('.cate2');

    // 카테고리 배열 초기화 메서드
    function makeCategoryArray(obj, array, categoryList, tier) {
        for (let i = 0; i < categoryList.length; i++) {
            if (categoryList[i].tier === tier) {
                obj = {};
                obj.cat_name = categoryList[i].cat_name;
                obj.cat_code = categoryList[i].cat_code;
                obj.parent_code = categoryList[i].parent_code;

                array.push(obj);
            }
        }
    }

    // 배열 초기화
    makeCategoryArray(cate1Object, cate1Array, categoryList, '1');
    makeCategoryArray(cate2Object, cate2Array, categoryList, '2');

    // 대분류 목록
    for (let i = 0; i < cate1Array.length; i++) {
        cate1Select.append('<option value="' + cate1Array[i].cat_code + '">' + cate1Array[i].cat_name + '</option>');
    }

    // 대분류 선택시 중분류 목록
    $(cate1Select).on("change", function () {
        let selectVal = $(this).find("option:selected").val();
        cate2Select.children().remove();
        cate2Select.append('<option selected value="none">선택</option>');
        for (let i = 0; i < cate2Array.length; i++) {
            if (cate2Array[i].parent_code === selectVal) {
                cate2Select.append('<option value="' + cate2Array[i].cat_code + '">' + cate2Array[i].cat_name + '</option>');
            }
        }
    });

    // 할인율 input설정
    $('#discount-interface').on("PropertyChange change keyup paste input", () => {
        let userInput = $('#discount-interface');
        let discountInput = $('input[name="discount-rate"]');

        // 사용자가 입력할 할인값
        let discountRate = userInput.val();
        // 서버에 전송할 할인값
        let sendDiscountRate = discountRate / 100;
        // 원래 가격
        let productPrice = $("input[name='prod_price']").val();
        // 할인된 가격
        let discountedPrice = (Math.floor(productPrice * (1 - sendDiscountRate) / 10) * 10);
        let discountedInput = $("input[name='disc_price']").val();
        discountedInput.value = discountedPrice;
        // 할인 얼마나 됐는지
        let discountingPrice = productPrice - discountedPrice;

        $('.span_discount').html(discountedPrice);

        $('.span_discounting').html(discountingPrice);

        discountInput.val(sendDiscountRate);

        $('input[name="disc_price"]').val(discountedPrice);
    });

    // 가격을 다시 입력했을 때 할인된 가격이 바뀌는 이벤트
    $('input[name="prod_price"]').on("PropertyChange change keyup paste input", function () {
        let userInput = $('#discount-interface');
        let discountInput = $('input[name="discount-rate"]');

        // 사용자가 입력할 할인값
        let discountRate = userInput.val();
        // 서버에 전송할 할인값
        let sendDiscountRate = discountRate / 100;
        // 원래 가격
        let productPrice = $("input[name='prod_price']").val();
        // 할인된 가격
        let discountedPrice = Math.floor(productPrice * (1 - sendDiscountRate));
        // 할인 얼마나 됐는지
        let discountingPrice = productPrice - discountedPrice;

        $('.span_discount').html(discountedPrice);

        $('.span_discounting').html(discountingPrice);

    });

    // 제목을 눌렀을때 내용 칸이 드러나지는 이벤트
    $(document).ready(() => {
        $('.set-option').click(function (event) {
            // <a> 태그의 기본 동작 방지
            event.preventDefault();
            // 'active' 클래스 토글
            $(this).find('.btn').toggleClass('active');
            // 현재 클릭된 set-option의 다음 형제 요소(form-section-sub)를 찾아서 토글
            $(this).closest('.form-section').find('.form-section-sub').slideToggle();
        });
    });

    // 상품명 글자수 표시
    $(document).ready(() => {
        $('.form-control').on('input', function () {
            let textLength = $(this).val().length;
            $(this).closest('.input-group').find('.text-primary').text(textLength);
        });
    });

    let table = document.getElementById('myTable');
    table.addEventListener('click', (e) => {
        if (e.target.classList.contains('deleteBtn')) {
            let row = e.target.closest('tr');
            table.deleteRow(row.rowIndex);
        }
    });

    // /* 이미지 업로드 */
    // $("input[type='file']").on("change", (e) => {
    //
    //     let formData = new FormData();
    //     let fileInput = $('input[name="prod_img"]');
    //     let fileList = fileInput[0].files;
    //     let fileObj = fileList[0];
    //
    //     if (!fileCheck(fileObj.name, fileObj.size)) {
    //         return false;
    //     }
    //
    //     formData.append("uploadFile", fileObj);
    //
    //     $.ajax({
    //         url: '/admin/uploadAjaxAction',
    //         processData: false,
    //         contentType: false,
    //         data: formData,
    //         type: 'POST',
    //         dataType: 'json'
    //     });
    //
    // });

    let regex = new RegExp("(.*?)\.(jpg|png|jpeg)$");
    let maxSize = 1048576; //1MB

    function fileCheck(fileName, fileSize) {

        if (fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if (!regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }

        return true;

    }

    let formData = new FormData();

    function handleFiles(files) { // files를 핸들링한다
        let list = $('#img-wrap-wrap'); // id가 img-wrap-wrap인 모든 요소를 선택하고 변수 list에 저장한다.
        let last = $('#img-wrap'); // id가 img-wrap인 모든 요소를 선택하고 변수 last에 저장한다.
        for (let i = 0; i < files.length; i++) { // files의 길이만큼 순회한다.

            // 클래스 이름이 css-o4030c e5xt3dr1인 div태그를 생성한다.
            const div = $('<div>', {
                class: 'css-o4030c e5xt3dr1',
            });

            // 클래스 이름이 css-idj2s4 e5xt3dr4인 img태그를 생성하고 src에 window.URL.createObjectURL(files[i])를 저장
            const img = $('<img>', {
                src: window.URL.createObjectURL(files[i]),
                class: 'css-idj2s4 e5xt3dr4',
            });

            // img 변수에 'file'이란 이름을 가진 key값을 주고 files값을 각각 저장한다.
            img.data('file', files[i]);

            // revokeObjectURL메서드가 URL.createObjectURL(files[i])으로 생성된 URL을 해제하고
            // this.src는 현재 이미지 요소의 'src'속성을 참조한다.
            img.onload = function () {
                window.URL.revokeObjectURL(this.src);
            };

            const button = $('<button>', {
                type: 'button',
                class: 'css-v96m37 e5xt3dr2',
            });

            formData.append('imageFile', files[i]);

            div.append(img, button);
            list.append(div);
            list.append(last);
        }
    }

    // 옵션관련
    document.getElementById('applyOptionList').addEventListener('click', function (e) {
        e.preventDefault();
        let optionValues = document.getElementById('choice_option_value0').value.split(',');

        let uniqueValues = new Set();

        // Check for duplicates
        for (let value of optionValues) {
            value = value.trim();
            if (uniqueValues.has(value)) {
                alert("Duplicate values found. No new rows will be added.");
                return; // Exit the function if duplicates are found
            }
            uniqueValues.add(value);
        }

        let table = document.getElementById('myTable').getElementsByTagName('tbody')[0];

        optionValues.forEach((value, index) => {
            let row = table.insertRow();

            // Checkbox Cell
            let checkboxCell = row.insertCell(0);
            checkboxCell.innerHTML = '<input type="checkbox" class="checkbox-td">';

            // Option Name Cell
            let optionNameCell = row.insertCell(1);
            optionNameCell.innerHTML = '<input type="text" name="optionProductList[' + index + '].opt_prod_name" value="' + value.trim() + '">';

            // Option Price Cell
            let optionPriceCell = row.insertCell(2);
            optionPriceCell.innerHTML = '<input type="number" name="optionProductList[' + index + '].opt_price">';

            // Option Discount Price
            let optionDiscountPriceCell = row.insertCell(3);
            optionDiscountPriceCell.innerHTML = '<input type="number" name="optionProductList[' + index + '].opt_disc_price" value="">'

            // Stock Quantity Cell
            let stockQtyCell = row.insertCell(4);
            stockQtyCell.innerHTML = '<input type="number" name="optionProductList[' + index + '].opt_prod_qty">';

            // Sales Status Cell
            let salesStatusCell = row.insertCell(5);
            //salesStatusCell.innerHTML = '<input type="text" name="optionProductList[' + index + '].opt_prod_sts">';
            salesStatusCell.innerHTML = '<select name="optionProductList[' + index + '].opt_prod_sts">' +
                '<option value="">판매상태</option>' +
                '<option value="판매전">판매전</option>' +
                '<option value="판매중">판매중</option></select>';

            // Usage Status Cell
            let usageStatusCell = row.insertCell(6);
            usageStatusCell.innerHTML = '<input type="text" value="Y">';

            // Adding Delete Functionality
            let deleteButtonCell = row.insertCell(7);
            let deleteButton = document.createElement('button');
            deleteButton.innerHTML = 'Delete';
            deleteButton.className = 'deleteBtn';
            deleteButton.onclick = function (e) {
                e.stopPropagation();
                this.closest('tr').remove();
            };
            deleteButtonCell.appendChild(deleteButton);
        });
        // 만약 어느 한줄이라도 delete 버튼을 누르면
        // 있던 table안의 <input>을 전부 삭제한다
        // 그리고 존재했던 <input>태그들은 다시 재배치해서 <input>태그를 넣는다.
    });

    // 선택삭제
    document.getElementById('choice-delete').addEventListener('click', (e) => {
        e.preventDefault();
        const checkboxes = document.querySelectorAll('#myTable tbody input[type="checkbox"]');
        checkboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                let row = checkbox.closest('tr');
                row.parentNode.removeChild(row);
            }
        });
    });


    let checkAll = document.querySelector('#checkAll');

    checkAll.addEventListener('click', () => {

        const isChecked = checkAll.checked;

        if (isChecked) {
            const checkboxes = document.querySelectorAll(`#myTable tbody input[type="checkbox"]`);

            for (const checkbox of checkboxes) {
                checkbox.checked = true;
            }
        } else {
            const checkboxes = document.querySelectorAll(`#myTable tbody input[type="checkbox"]`);
            for (const checkbox of checkboxes) {
                checkbox.checked = false;
            }
        }
    })

    // 전체 선택 삭제 버튼 : 하나라도 체크박스가 선택안되면 체크 해제
    document.addEventListener('DOMContentLoaded', () => {
        let checkboxes = document.querySelectorAll(`#myTable tbody input[type="checkbox"]`);
        //const checkAll = document.querySelector(`#checkAll`);
        for (let checkbox of checkboxes) {
            checkbox.addEventListener('change', () => {
                const totalCount = checkboxes.length;
                const checkedCount = document.querySelectorAll('#myTable tbody input[type="checkbox"]:checked').length;
                checkAll.checked = totalCount === checkedCount;
            });
        }

        checkAll.addEventListener('change', () => {
            for (let checkbox of checkboxes) {
                checkbox.checked = this.checked;
            }
        });
    });

    document.addEventListener('DOMContentLoaded', () => {
        document.getElementById('checkAll').addEventListener('change', function () {
            console.log('Checkbox state changed');
            let checkboxes = document.querySelectorAll('#myTable tbody input[type="checkbox"]');
            console.log(checkboxes);
            for (let checkbox of checkboxes) {
                checkbox.checked = this.checked;
                console.log(checkbox.checked = this.checked);
            }
        });
    });

    // 옵션 유무를 눌렀을때 내용 칸이 드러나지는 이벤트
    let optionTrueChoice = document.getElementById('option-choice-type-true');
    let optionFalseChoice = document.getElementById('option-choice-type-false');
    let optionDetail = document.getElementById('option-div');

    optionDetail.style.display = 'none';

    optionFalseChoice.addEventListener('click', () => {
        optionDetail.style.display = 'none';
    });

    optionTrueChoice.addEventListener('click', () => {
        optionDetail.style.display = 'block';
    });

    // 판매 기간 제목을 눌렀을때 내용 칸이 드러나지는 이벤트
    let salePeriodTrueChoice = document.getElementById('salePeriod-choice-type-true');
    let salePeriodFalseChoice = document.getElementById('salePeriod-choice-type-false');
    let salePeriodDetail = document.getElementById('salePeriod-div');

    salePeriodDetail.style.display = 'none';

    salePeriodFalseChoice.addEventListener('click', () => {
        salePeriodDetail.style.display = 'none';
    });

    salePeriodTrueChoice.addEventListener('click', () => {
        salePeriodDetail.style.display = 'block';
    });

    // 할인 설정을 눌렀을 때 내용 칸이 드러나지는 이벤트
    let discountTrueChoice = document.getElementById('discount-choice-type-true');
    let discountFalseChoice = document.getElementById('discount-choice-type-false');
    let discountDetail = document.getElementById('discount-div');

    discountDetail.style.display = 'none';

    discountFalseChoice.addEventListener('click', () => {
        discountDetail.style.display = 'none';
    });

    discountTrueChoice.addEventListener('click', () => {
        discountDetail.style.display = 'block';
    });

    // 상품명 유효성검사
    let nameCheck = false;

    const productNameInput = document.querySelector('[name="prod_name"]');
    const nameWarning = document.querySelector('.name-warn');

    function toggleNameWarning() {
        nameCheck = productNameInput.value.length > 0;
        nameWarning.style.display = nameCheck ? 'none' : 'block';
    }

    productNameInput.addEventListener('keyup', toggleNameWarning);

    // 판매가 유효성검사
    let priceCheck = false;
    const productPriceInput = document.querySelector('[name="prod_price"]');
    const priceWarning = document.querySelector('.price-warn');
    const priceUnitWarning = document.querySelector('.price-unit-warn');

    function togglePriceWarning() {
        priceCheck = productPriceInput.value.length > 0;
        priceWarning.style.display = priceCheck ? 'none' : 'block';
    }

    function togglePriceUnitWarning() {
        const price = productPriceInput.value;
        priceCheck = price.length > 0 && price % 10 === 0;
        priceUnitWarning.style.display = !priceCheck && price.length > 0 ? 'block' : 'none';
    }

    productPriceInput.addEventListener('keyup', togglePriceWarning);
    productPriceInput.addEventListener('keyup', togglePriceUnitWarning);

    // 할인율 유효성검사
    let discountCheck = false;

    const discountInput = document.querySelector('[name="disc_rate"]');

    document.addEventListener('keydown', (e) => {
        if (e.key === 'e' || e.key === 'E' || e.key === '+' || e.key === '-' || e.key === '.') {
            e.preventDefault();
        }
    });

    // 달력 날짜 버튼 선택
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.btn-primary2').forEach(button => {
            button.addEventListener('click', function () {
                const days = parseInt(this.getAttribute('data-days'));
                const startDate = new Date();
                const endDate = new Date();

                endDate.setDate(startDate.getDate() + days);

                const formatDate = (date) => {
                    const year = date.getFullYear();
                    const month = ('0' + (date.getMonth() + 1)).slice(-2);
                    const day = ('0' + date.getDate()).slice(-2);
                    return year + '-' + month + '-' + day;
                };

                document.querySelector('input[name="sel_str_date"]').value = formatDate(startDate);
                document.querySelector('input[name="sel_end_date"]').value = formatDate(endDate);
            });
        });
    });

    // 재고수량 유효성검사
    let qtyCheck = false;

    const qtyNameInput = document.querySelector('[name="prod_qty"]');
    const qtyWarning = document.querySelector('.qty-warn');

    function toggleQtyWarning() {
        qtyCheck = qtyNameInput.value.length > 0;
        qtyWarning.style.display = qtyCheck ? 'none' : 'block';
    }

    qtyNameInput.addEventListener('keyup', toggleQtyWarning);

    // 브랜드 유효성검사
    let brandCheck = false;

    const brandNameInput = document.querySelector('[name="brand"]');
    const brandWarning = document.querySelector('.brand-warn');

    function toggleBrandWarning() {
        brandCheck = brandNameInput.value.length > 0;
        brandWarning.style.display = brandCheck ? 'none' : 'block';
    }

    brandNameInput.addEventListener('keyup', toggleBrandWarning);

    // 원산지 유효성 검사
    let originCheck = false;

    const originNameInput = document.querySelector('[name="origin"]');
    const originWarning = document.querySelector('.origin-warn');

    function toggleOriginWarning() {
        originCheck = originNameInput.value.length > 0;
        originWarning.style.display = originCheck ? 'none' : 'block';
    }

    originNameInput.addEventListener('keyup', toggleOriginWarning);

    // 배송타입 유효성 검사
    let dlvyCheck = false;

    const dlvyNameInput = document.querySelector('[name="dlvy_type"]');
    const dlvyWarning = document.querySelector('.dlvy-warn');

    function toggleDlvyWarning() {
        dlvyCheck = dlvyNameInput.value.length > 0;
        dlvyWarning.style.display = dlvyCheck ? 'none' : 'block';
    }

    dlvyNameInput.addEventListener('keyup', toggleDlvyWarning);

    // 판매자 유효성 검사
    let sellerCheck = false;

    const sellerNameInput = document.querySelector('[name="seller"]');
    const sellerWarning = document.querySelector('.seller-warn');

    function toggleSellerWarning() {
        sellerCheck = sellerNameInput.value.length > 0;
        sellerWarning.style.display = sellerCheck ? 'none' : 'block';
    }

    sellerNameInput.addEventListener('keyup', toggleSellerWarning);

    // 포장타입 유효성 검사
    let packCheck = false;

    const packNameInput = document.querySelector('[name="pack_type"]');
    const packWarning = document.querySelector('.pack-warn');

    function togglePackWarning() {
        packCheck = packNameInput.value.length > 0;
        packWarning.style.display = packCheck ? 'none' : 'block';
    }

    packNameInput.addEventListener('keyup', togglePackWarning);

    // 판매단위 유효성 검사
    let salesUnitCheck = false;

    const salesUnitNameInput = document.querySelector('[name="sales_unit"]');
    const salesUnitWarning = document.querySelector('.sales-unit-warn');

    function toggleSalesUnitWarning() {
        salesUnitCheck = salesUnitNameInput.value.length > 0;
        salesUnitWarning.style.display = salesUnitCheck ? 'none' : 'block';
    }

    salesUnitNameInput.addEventListener('keyup', toggleSalesUnitWarning);


    // 중량/용량 유효성 검사
    let weightCheck = false;

    const weightNameInput = document.querySelector('[name="weight"]');
    const weightWarning = document.querySelector('.weight-warn');

    function toggleWeightWarning() {
        weightCheck = weightNameInput.value.length > 0;
        weightWarning.style.display = weightCheck ? 'none' : 'block';
    }

    weightNameInput.addEventListener('keyup', toggleWeightWarning);

    // 유통기한 유효성 검사
    let expCheck = false;

    const expNameInput = document.querySelector('[name="exp_date"]');
    const expWarning = document.querySelector('.exp-warn');

    function toggleExpWarning() {
        expCheck = expNameInput.value.length > 0;
        expWarning.style.display = expCheck ? 'none' : 'block';
    }

    expNameInput.addEventListener('keyup', toggleExpWarning);

    // 안내사항 유효성 검사
    let guideCheck = false;

    const guideNameInput = document.querySelector('[name="as_guide"]');
    const guideWarning = document.querySelector('.guide-warn');

    function toggleGuideWarning() {
        guideCheck = guideNameInput.value.length > 0;
        guideWarning.style.display = guideCheck ? 'none' : 'block';
    }

    guideNameInput.addEventListener('keyup', toggleGuideWarning);

    document.querySelectorAll('#enrollForm').forEach(input => {
        input.addEventListener('keydown', function (event) {
            if (event.key === 'Enter') {
                event.preventDefault();
            }
        });
    });

    document.getElementById('discount-interface').addEventListener('input', function(e) {
        const value = e.target.value;
        if(value.length > 2 || value < 0 || value > 99) { // 2자리 숫자, 0 이상 99 이하의 값 검사
            alert("0과 99사이의 숫자를 입력해주세요.");
            e.target.value = "";
        }
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    document.querySelector('[name="prod_qty"]').addEventListener('input', function(e) {
        // 입력된 값이 숫자가 아니면 제거
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    // 등록버튼 한번누르면 비활성화시켜 동시에 등록되는것을 방지한다.
    // function submitForm() {
    //     const submitBtn = document.querySelector('.enroll-btn');
    //     submitBtn.disabled = true;
    // }

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value='/resources/common/js/scripts.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-area-demo.js' />"></script>
<script src="<c:url value='/resources/common/assets/demo/chart-bar-demo.js' />"></script>
<script src="<c:url value='/resources/common/js/datatables-simple-demo.js' />"></script>
</body>
</html>
