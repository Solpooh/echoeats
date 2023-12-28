//스크롤
window.addEventListener('scroll', function() {
    let scrollPosition = window.scrollY;
    // 특정 스크롤 위치 이상일 때
    if (scrollPosition >= 55) {
        document.querySelector('.css-9i9om4').style.position = 'sticky';
        document.querySelector('.css-9i9om4').style.top = '55px';
    }
});

let checkout = {
    selectedItems: selectedItems,
    tot_prod_name: tot_prod_name,
    tot_prod_price: tot_prod_price,
    origin_prod_price: origin_prod_price,
    dlvy_fee: dlvy_fee,
    pay_way: pay_way
}

let coupon_id; //쿠폰 id 나중에 ajax로도 보내고 결제 버튼을 눌렀울때도 결제할인 금액 table로도 보내야한다.

let ajaxData = function(){ //쿠폰, 적립금 ajax로 보내기

    //ajax로 보낼 데이터
    let paymentDiscount = {
        tot_prod_price: tot_prod_price, //주문 금액
        coupon_id: coupon_id, //쿠폰 id
        point_used: document.getElementById('inputPointUsed').value, //사용한 적립금
        dlvy_fee: dlvy_fee //배송비
    }

    $.ajax({
        type:'POST',
        url: '/order/calculatePayment',
        headers:{"content-type":"application/json"},
        dataType:'json',
        data: JSON.stringify(paymentDiscount),
        success: function(paymentData){
            //쿠폰
            if(paymentData.coupon_disc === null){
                $("#signCoupon").html("");
                $("#outputCouponUsed").html(0);
            }else {
                $("#signCoupon").html("-");
                $("#outputCouponUsed").html(paymentData.coupon_disc.toLocaleString());
            }
            //적립금
            if(paymentData.point_used === null) {
                $("#signPoint").html("");
                $("#outputPointUsed").html(0);
            }else{
                $("#signPoint").html("-");
                $("#outputPointUsed").html(paymentData.point_used.toLocaleString());
            }
            //총 실 결제 금액
            if(paymentData.tot_pay_price === null){
                $("#tot_pay_price").html(0);
            }else{
                $("#tot_pay_price").html(paymentData.tot_pay_price.toLocaleString());
                $("#payment").html(paymentData.tot_pay_price.toLocaleString());
            }
        },
        error: function(){ alert("error!!" ); }
    })
};

//쿠폰 list
$('#couponList').hide(); //페이지를 로드할 때 숨길 요소
$("#couponBtn").click(function(){
    let couponBtn = $("#couponBtn");
    if(couponBtn.val() === 'unchecked'){
        $('#couponList').show();
        couponBtn.val('checked');
    }else {
        $('#couponList').hide();
        couponBtn.val('unchecked');
    }
});

//쿠폰 버튼 클릭 시
let couponListBtn = document.querySelectorAll(".couponListBtn");
for (let i=0; i < couponListBtn.length ; i++){
    couponListBtn[i].addEventListener('click', function(){

        let addCouponDivName =
            '<div id="addCoupon">' +
            '<div class="css-kmlyvgdiv addCouponDiv">\n' +
            '<strong class="css-1bfy7g3div">' +'✅ '+ couponDtoList[i].cp_name + '</strong><br>\n' +
            '<span class="css-bs5mk4">' + couponDtoList[i].min_amt +'원 이상 주문 시\n' ;

        let addCouponDivMax ;
        if(couponDtoList[i].max_disc_amt !== 0){
            addCouponDivMax = '최대'+couponDtoList[i].max_disc_amt;
        }else {
            addCouponDivMax = couponDtoList[i].cash_rate;
        }

        let addCouponDivDate =
            '원 할인 (' + couponDtoList[i].cp_del_date +')' +'</span>\n' +
            '</div>' +
            '<button id="deleteCouponBtn" class="css-h5zdhc" type="button" data-testid="delete">' +
            '<span class="css-6mgkir e5h3i930"></span>' +
            '</button></div>'

        coupon_id = couponDtoList[i].cp_id; //ajax, 결제버튼 클릭시 결제할인금액table

        $('#couponList').hide();
        $('#addCoupon').remove();
        $('.e1brt3tk0').append(addCouponDivName + addCouponDivMax + addCouponDivDate);

        ajaxData();
    })
}

//쿠폰 삭제 버튼 클릭시
$(document).on('click',"#deleteCouponBtn", function(){
    $("#addCoupon").remove();
    coupon_id = null;
    ajaxData();
})
let tot_pay_price = document.getElementById("tot_pay_price").innerText.replace(/,/g, "")*1;
let point = document.getElementById('point').innerText.replace(/,/g, "")*1;
//적립금 입력
function updateValue(input){
    const inputValue = input.value*1;

    if(inputValue === 0){
        input.value = '';
    }else if(inputValue > point || inputValue > tot_pay_price){
        input.value = Math.min(point, tot_pay_price);
    } else{
        input.value = input.value.replace(/\D/g, '');
    }
    ajaxData();
}

//적립금 모두 사용 버튼
document.getElementById("allUseBtn").addEventListener('click', function(){
    if(point > tot_pay_price){
        document.getElementById('inputPointUsed').value = tot_pay_price;
    }else {
        document.getElementById('inputPointUsed').value = point;
    }
    ajaxData();
})

//배송지 변경
document.getElementById('AddrBtn').addEventListener('click', function(){
    if(confirm("배송지 페이지로 이동하여\n다른 배송지로 변경하시겠습니까?")){
        window.location.href = '/address/';
    }
});

document.addEventListener("DOMContentLoaded", function () {

    let delNotesTag =
        "<div id=\"NotFirst\" class=\"css-82a6rk e150alo80\"><span id=\"place\" class=\"css-11y0tcn efthce41\"></span><span class=\"css-bhczxb efthce40\"></span>\n" +
        "<span id=\"entryway\" class=\"css-11y0tcn efthce41\"></span><span id=\"entrywayDetail\"></span>\n" +
        "<div id=\"personData\" class=\"css-rqc9f e14u1xpe0\"></div>\n" +
        "<div class=\"css-iqoq9n e1pxan880\"><button class=\"css-117jo2j e4nu7ef3 delNotesBtn\" type=\"button\" width=\"60\" height=\"30\" radius=\"3\"><span class=\"css-nytqmg e4nu7ef1\">수정</span></button></div></div></div>";

    //배송 요청 사항
    let popup;
    $(document).on("click", ".delNotesBtn", function () {
        popup = window.open("/order/checkout/receiverDetails", "delNotes", "width=600, height=800, left=100, top=50");

        $(popup).on('beforeunload', function () {
            $.ajax({
                type: 'GET',
                url: '/order/checkout/getDelNotes',
                dataType: 'json',
                success: function (delNotes) {
                    // alert("success");
                    let personData = document.getElementById("personData");
                    if (personData === null) { //첫 주문
                        $('#firstDelNotesDiv').remove();
                        $("#delNotes").append(delNotesTag)
                    }
                    getDelNotesSuccess(delNotes)
                },
                error: function () {
                    // alert("error")
                }
            });
        });
    });

    let getDelNotesSuccess = function (delNotes){
        if(delNotes.entryway === 'PASSWORD'){
            delNotes.entryway = '공동현관 비밀번호';
        } else if(delNotes.entryway === 'FREE'){
            delNotes.entryway = '자유 출입 가능';
        } else if(delNotes.entryway === 'CALL_SECURITY_OFFICE'){
            delNotes.entryway = '경비실 호출';
        } else{
            delNotes.entryway = '기타';
        }


        document.getElementById("place").innerText = delNotes.place;
        document.getElementById("entryway").innerText = delNotes.entryway;

        if(delNotes.entryway_detail === null || delNotes.entryway_detail !== ''){
            document.getElementById("entrywayDetail").innerText = '(' + delNotes.entryway_detail + ')';
        }else{
            document.getElementById("entrywayDetail").innerText = '';
        }
        document.getElementById("personData").innerText = delNotes.name + ',' + delNotes.number;
    }
});


    let orderData = {
        pg : 'kakaopay',
        pay_method : 'kakaopay'
    };


    //결제 버튼 클릭 이벤트
    $(".payBtnList").on('click', function (e){
       if(e.target.id === 'kakaopayBtn'){
           $('#kakaopayBtn').removeClass('css-1wlyg0y');
           $('#kakaopayBtn').addClass('css-1fecctx');
           $('#creditcardBtn').removeClass('css-1pvbmgb');
           $('#creditcardBtn').addClass('css-1wlyg0y');
           $('#simplepayBtn').removeClass('css-1pvbmgb');
           $('#simplepayBtn').addClass('css-1wlyg0y');
           $('#mobiliansBtn').removeClass('css-1pvbmgb');
           $('#mobiliansBtn').addClass('css-1wlyg0y');
           $(".css-nemdq9").remove()
           orderData.pg = $("#kakaopayBtn").val();
           orderData.pay_method = 'kakaopay';

       } else if(e.target.id === 'creditcardBtn'){
           $('#creditcardBtn').removeClass('css-1wlyg0y');
           $('#creditcardBtn').addClass('css-1pvbmgb');
           $('#kakaopayBtn').removeClass('css-1fecctx');
           $('#kakaopayBtn').addClass('css-1wlyg0y');
           $('#simplepayBtn').removeClass('css-1pvbmgb');
           $('#simplepayBtn').addClass('css-1wlyg0y');
           $('#mobiliansBtn').removeClass('css-1pvbmgb');
           $('#mobiliansBtn').addClass('css-1wlyg0y');
           $(".css-nemdq9").remove()
           orderData.pg = $("#creditcardBtn").val();
           orderData.pay_method = 'card';

       } else if(e.target.id === 'simplepayBtn'){
           $('#simplepayBtn').removeClass('css-1wlyg0y');
           $('#simplepayBtn').addClass('css-1pvbmgb');
           $('#kakaopayBtn').removeClass('css-1fecctx');
           $('#kakaopayBtn').addClass('css-1wlyg0y');
           $('#creditcardBtn').removeClass('css-1pvbmgb');
           $('#creditcardBtn').addClass('css-1wlyg0y');
           $('#mobiliansBtn').removeClass('css-1pvbmgb');
           $('#mobiliansBtn').addClass('css-1wlyg0y');
           let checkbox = "";
           checkbox = checkbox + '<div class="css-nemdq9 evz7bw03">' +
               '<div class="css-nznuh9 evz7bw02"><label class="css-11zj85u et8nqc33" for="naver-pay">' +
                    '<input data-testid="radio-naver-pay" id="naver-pay" name="naver-pay" type="radio" class="css-1pes2r6 et8nqc32" value="naver-pay" checked=""><span class="css-5xw1m2 e2sqze61"><div class="css-1vic0rk e2sqze60"></div></span><span aria-labelledby="naver-pay" class="css-mgd87h et8nqc31"><span class="css-s5xdrg evz7bw00">네이버페이 </span></span></label></div>' +
               '<div class="css-nznuh9 evz7bw02"><label class="css-11zj85u et8nqc33" for="toss">' +
                    '<input data-testid="radio-toss" id="toss" name="toss" type="radio" class="css-1pes2r6 et8nqc32" value="toss"><span class="css-198i9ca e2sqze61"><div class="css-1dahn5m e2sqze60"></div></span><span aria-labelledby="toss" class="css-mgd87h et8nqc31"><span class="css-s5xdrg evz7bw00">토스 </span></span></label></div>' +
               '<div class="css-nznuh9 evz7bw02"><label class="css-11zj85u et8nqc33" for="payco">' +
                    '<input data-testid="radio-payco" id="payco" name="payco" type="radio" class="css-1pes2r6 et8nqc32" value="payco"><span class="css-198i9ca e2sqze61"><div class="css-1dahn5m e2sqze60"></div></span><span aria-labelledby="payco" class="css-mgd87h et8nqc31"><span class="css-s5xdrg evz7bw00">페이코</span></span></label></div>' +
               '</div>';
           $(".css-gd125q").append(checkbox);

       } else if(e.target.id === 'mobiliansBtn'){
           $('#mobiliansBtn').removeClass('css-1wlyg0y');
           $('#mobiliansBtn').addClass('css-1pvbmgb');
           $('#kakaopayBtn').removeClass('css-1fecctx');
           $('#kakaopayBtn').addClass('css-1wlyg0y');
           $('#creditcardBtn').removeClass('css-1pvbmgb');
           $('#creditcardBtn').addClass('css-1wlyg0y');
           $('#simplepayBtn').removeClass('css-1pvbmgb');
           $('#simplepayBtn').addClass('css-1wlyg0y');
           $(".css-nemdq9").remove()
       }
    });


    //주문서 상품 목록
    $('#prodDetailBtn').click(function(){
        let arrowBtn = document.getElementById("arrowBtn");
        let rotate = arrowBtn.getAttribute("transform");
        if(rotate === "rotate(135 15.5 16.5)"){
            $('.totItems').hide(); //클릭 시 첫 번째 요소 숨김
            $('.items').show(); //클릭 시 두 번째 요소 표시
            arrowBtn.setAttribute("transform", "rotate(-45 15.5 16.5)");
        }else{
            $('.totItems').show(); //클릭 시 첫 번째 요소 숨김
            $('.items').hide(); //클릭 시 두 번째 요소 표시
            arrowBtn.setAttribute("transform", "rotate(135 15.5 16.5)");
        }
    });


    let lastClickTime = 0; //결제 버튼 중복 클릭을 방지하기 위함

    //결제 버튼 누르면
    $('#paymentBtn').click(function(e){

        let personData = document.getElementById("personData");
        if(personData === null){ //첫 주문
            alert("배송 요청사항을 입력해주세요")
            return;
        }

        // 결제 버튼 중복 클릭 방지
        let currentTime = new Date().getTime();
        console.log("전 currentTime", currentTime)
        let timeDiff = currentTime - lastClickTime;
        if(timeDiff < 5000){ //5초 이내에 다시 클릭하면 이벤트를 무시한다.

            e.preventDefault();
            return;
        }
        lastClickTime = currentTime;

        console.log("후 currentTime", currentTime)

        //ajax로 보낼 데이터
        checkout.tot_pay_price = document.getElementById("tot_pay_price").innerText.replace(/,/g, "");
        checkout.prod_disc = checkout.origin_prod_price - checkout.tot_prod_price;
        checkout.coupon_disc = document.getElementById("outputCouponUsed").innerText.replace(/,/g, "");
        checkout.coupon_id = coupon_id;
        checkout.point_used = document.getElementById("outputPointUsed").innerText.replace(/,/g, "");

        $.ajax({
            type:'POST',
            url: '/payment/verify/prev',
            headers:{"content-type": "application/json"},
            dataType: 'text',
            data : JSON.stringify(checkout),
            success: function(result){
                // alert("✅ 1차 검증 성공 = " + result);
                orderData.ord_id = result*1;
                if(checkout.tot_pay_price === '0'){
;                    window.location.href = "/order/completed/"+orderData.ord_id;
                }else{
                    requestPay();
                }

            },
            error: function(){
                alert("🔥 1차 검증 실패 또는 서버 오류")
            }
        });
    })

    var IMP = window.IMP;
    IMP.init("imp38341687");

    function requestPay() {
        IMP.request_pay({
            pg: orderData.pg,
            pay_method: orderData.pay_method,
            merchant_uid: orderData.ord_id,
            name: checkout.tot_prod_name,
            amount: checkout.tot_pay_price,
        }, rsp => {
            if (rsp.success) {
                // axios로 HTTP 요청, 결제 성공시 서버로 전송
                // alert("success")
                console.log("rsp",rsp);
                writePayment(rsp);

            } else {
                // alert("fail")
                writePayment(rsp);
            }
        });
    }

    function writePayment(rsp){
        axios({
            url: "/payment/verify/next",
            method: "post",
            headers: { "Content-Type": "application/json" },
            data: {
                pay_id: rsp.imp_uid,
                ord_id: rsp.merchant_uid,
                tot_prod_name: rsp.name,
                tot_pay_price: rsp.paid_amount,
                pay_way: rsp.pg_provider,
                pg_tid: rsp.pg_tid,
                success: rsp.success
            }
        }).then(response  => {
            // 서버 결제 API 성공시 로직
            // alert("success: " +JSON.stringify(response.data))
            //주문번호
            window.location.href = '/order/completed/'+orderData.ord_id;

        }).catch(error => {
            alert("결제에 실패하셨습니다. 다시 시도해주세요.")
            // alert("error: " + JSON.stringify(error.response))
        });
    }


