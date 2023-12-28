<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<div class="css-j0lifa ed9qr673">
    <div class="css-fhxb3m ed9qr672"><h2 class="css-1268zpe ed9qr671">주문 내역</h2>
        <span class="css-a3vgo2 ed9qr670">최대 지난 3년간의 주문 내역까지 확인할 수 있어요</span></div>
    <div class="css-fhxb3m ed9qr672">
        <div class="css-wkgeho e1ykq6gv2">
            <div>
                <div class="MuiFormControl-root css-tzsjye">
                    <div variant="outlined"
                         class="MuiOutlinedInput-root MuiInputBase-root MuiInputBase-colorPrimary MuiInputBase-formControl jss1 css-eg1co4">
                        <div tabindex="0" role="button" aria-expanded="false" aria-haspopup="listbox"
                             aria-label="Without label"
                             class="MuiSelect-select MuiSelect-outlined MuiOutlinedInput-input MuiInputBase-input css-qiwgdb">
                            3개월
                        </div>
                        <input aria-hidden="true" tabindex="-1" class="MuiSelect-nativeInput css-1k3x8v3" value="3">
                        <svg class="MuiSvgIcon-root MuiSvgIcon-fontSizeMedium MuiSelect-icon MuiSelect-iconOutlined css-1636szt"
                             focusable="false" aria-hidden="true" viewBox="0 0 24 24" data-testid="ArrowDropDownIcon">
                            <path d="M7 10l5 5 5-5z"></path>
                        </svg>
                        <fieldset aria-hidden="true" class="MuiOutlinedInput-notchedOutline css-igs3ac">
                            <legend class="css-nnbavb"><span class="notranslate"></span></legend>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="css-1dmsa3j e1jm6dy15"></div>
<div class="css-1c8nox e1ykq6gv1">
    <c:forEach var="ordDto" items="${ordList}" varStatus="status">
        <div class="css-4wlxei e1437c6414">
            <div class="css-1hbtwy0 e1437c6413">
                            <span class="css-asma03 e1437c6412">
                                <fmt:formatDate value='${ordDto.ord_date}' pattern='yyyy-MM-dd' type='date'/>
                                (<fmt:formatDate value='${ordDto.ord_date}' pattern='HH:mm' type='time'/>)
                                </span><a class="css-l9y4tx e1437c6411 ordDetView" data-ordId="${ordDto.ord_id}">주문내역
                상세보기</a>
            </div>
            <div class="css-7apail e1437c6410">
                <div class="css-fhxb3m e1437c649"><img src="${ordDto.prod_img_id}" class="css-1oc1pau e1437c648">
                    <div class="css-1fttcpj e1437c647">
                        <dl class="css-1ccl3pq e1437c646">
                            <dt class="css-dzjp62 e1437c645">상품명</dt>
                            <dd class="css-1o8e829 e1437c643"><c:out value="${ordDto.tot_prod_name}"/></dd>
                        </dl>
                        <dl class="css-1ccl3pq e1437c646">
                            <dt class="css-dzjp62 e1437c645">주문번호</dt>
                            <dd class="css-1i58pf4 e1437c644">${ordDto.ord_id}</dd>
                        </dl>
                        <dl class="css-1ccl3pq e1437c646">
                            <dt class="css-dzjp62 e1437c645">결제방법</dt>
                            <dd class="css-1i58pf4 e1437c644">${ordDto.pay_way}</dd>
                        </dl>
                        <dl class="css-1ccl3pq e1437c646">
                            <dt class="css-dzjp62 e1437c645">결제금액</dt>
                            <dd class="css-1i58pf4 e1437c644">
                                <fmt:formatNumber value="${ordDto.tot_pay_price}" pattern="#,###"/>원
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="css-s5xdrg e1437c642">
                    <span class="css-1fdt947 e1437c641">${ordDto.column_sts}</span>

                    <div class="css-1bbz142 e1437c640">


                        <c:choose>
                            <c:when test="${ordDto.column_sts == '주문완료'}">
                                <button class="css-oyz24n e4nu7ef3" type="button" height="36" radius="3"><span
                                        class="css-nytqmg e4nu7ef1">주문취소</span></button>
                            </c:when>
                            <c:when test="${ordDto.column_sts == '배송완료'}">
                                <button class="css-oyz24n e4nu7ef3" type="button" height="36" radius="3"><span
                                        class="css-nytqmg e4nu7ef1">1:1 문의</span></button>
                            </c:when>
                            <c:otherwise>
                                <span class="css-oyz25n e4nu7ef3" type="button" height="36" radius="3"><span
                                        class="css-nytqmg2 e4nu7ef1">주문취소</span></span>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
