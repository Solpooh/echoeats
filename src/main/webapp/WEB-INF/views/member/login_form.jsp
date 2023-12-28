<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<link href="/resources/css/member/login_form.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="/resources/product/css/main-css.css">
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Document</title>
</head>
<body>

<%@ include file="../include/header.jspf" %>

<div class="login">
    <div class="title">로그인</div>
    <div class="login_form">
        <form id="loginform">
            <div class="id_pw">
                <div class="outer">
                    <div class="inner">
                        <input type="text" name="mem_id" value="${input_id}" placeholder="아이디를 입력해주세요">
                    </div>
                </div>
                <div class="outer">
                    <div class="inner">
                        <input  type="password" name="mem_pwd" placeholder="비밀번호를 입력해주세요">
                    </div>
                </div>
                <div class="warm">${errormsg} </div>
            </div>
            <div class="find">
                <a class="find_inner">아이디 찾기</a>
                <span></span>
                <a class="find_inner">비밀번호 찾기</a>
            </div>
            <div class="login_form_button">
                <button type="button" class="login_button">
                    <span class="button_name">로그인</span>
                </button>
                <button type="button" class="sign_in_button">
                    <span class="button_name" id="join">회원가입</span>
                </button>
                <a class="kakao_a active">
                    <img src="/resources/images/kakao_login_button.png"></a>
            </div>
        </form>
    </div>
</div>
<footer>
    <div class="css-17cdx60 ebj6vxr6">
        <div id="footer" class="css-1i60c0e ebj6vxr5">
            <div class="css-j6zuv6 ebj6vxr4">
                <div class="css-0 eam2qm511">
                    <h2 class="css-4iyald eam2qm510">고객행복센터</h2>
                    <strong class="css-9jqcug eam2qm58">1644-1107
                        <span class="css-1uz1ro8 eam2qm59">월~토요일 오전 7시 - 오후 6시</span>
                    </strong><div class="css-1fttcpj eam2qm57">
                    <div class="css-ho1qnd eam2qm53">
                        <button class="eam2qm54 css-hupzfj e19i509p0">카카오톡 문의</button>
                        <div class="css-1lxmeik eam2qm52">월~토요일<svg width="1" height="10" viewBox="0 0 1 10" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-w0fx7a eam2qm50">
                            <line x1="0.5" y1="2.18557e-08" x2="0.5" y2="10" stroke="#ccc"></line></svg>오전 7시 - 오후 6시<br>일/공휴일
                            <svg width="1" height="10" viewBox="0 0 1 10" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-w0fx7a eam2qm50"><line x1="0.5" y1="2.18557e-08" x2="0.5" y2="10" stroke="#ccc"></line></svg>오전 7시 - 오후 1시
                        </div>
                    </div>
                    <div class="css-ho1qnd eam2qm53">
                        <button class="css-nyq565 eam2qm56">1:1 문의</button>
                        <div class="css-1lxmeik eam2qm52">365일<br>고객센터 운영시간에 순차적으로 답변드리겠습니다.
                        </div>
                    </div>
                    <div class="css-ho1qnd eam2qm53"><a href="https://docs.google.com/forms/d/e/1FAIpQLScWcjRuN6eWJK-G8x3NwBfE8IyKZIOq7jhD3fUXuKSWwPqzJw/viewform" target="_blank" class="css-nyq565 eam2qm55">대량주문 문의</a>
                        <div class="css-1lxmeik eam2qm52">월~금요일<svg width="1" height="10" viewBox="0 0 1 10" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-w0fx7a eam2qm50"><line x1="0.5" y1="2.18557e-08" x2="0.5" y2="10" stroke="#ccc"></line></svg>오전 9시 - 오후 6시<br>점심시간<svg width="1" height="10" viewBox="0 0 1 10" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-w0fx7a eam2qm50"><line x1="0.5" y1="2.18557e-08" x2="0.5" y2="10" stroke="#ccc"></line></svg>낮 12시 - 오후 1시
                        </div>
                    </div>
                </div>
                    <div class="css-vtjvf eam2qm51">비회원 문의 : <a href="mailto:help@kurlycorp.com">help@kurlycorp.com</a>
                    </div>
                </div>
                <div class="css-1fttcpj ebj6vxr3"><ul class="css-17hse91 e13nap1l2"><li class=" css-slkv2p e13nap1l1"><a href="/introduce" target="_self" class="css-1tfhwyj e13nap1l0">컬리소개</a></li><li class=" css-slkv2p e13nap1l1"><a href="https://www.youtube.com/embed/WEep7BcboMQ?rel=0&amp;showinfo=0&amp;wmode=opaque&amp;enablejsapi=1" target="_self" class="css-1tfhwyj e13nap1l0">컬리소개영상</a></li><li class=" css-slkv2p e13nap1l1"><a href="https://ir.kurly.com" target="_blank" class="css-1tfhwyj e13nap1l0">투자정보</a></li><li class=" css-slkv2p e13nap1l1"><a href="https://kurly.career.greetinghr.com" target="_blank" class="css-1tfhwyj e13nap1l0">인재채용</a></li><li class=" css-slkv2p e13nap1l1"><a href="/user-terms/agreement" target="_self" class="css-1tfhwyj e13nap1l0">이용약관</a></li><li class="bold css-slkv2p e13nap1l1"><a href="/user-terms/privacy-policy" target="_self" class="css-1tfhwyj e13nap1l0">개인정보처리방침</a></li><li class=" css-slkv2p e13nap1l1"><a href="/user-guide" target="_self" class="css-1tfhwyj e13nap1l0">이용안내</a></li></ul>
                    <div class="css-bz7mfs ebj6vxr2">법인명 (상호) : 주식회사 컬리 <span class="css-1ekjygq ebj6vxr1"></span> 사업자등록번호 : 261-81-23567<a href="https://www.ftc.go.kr/bizCommPop.do?wrkr_no=2618123567&amp;apv_perm_no=" target="_blank" rel="noreferrer" class="css-1tby8gd ebj6vxr0">사업자정보 확인</a><br>통신판매업 : 제 2018-서울강남-01646 호<br>주소 : 서울특별시 강남구 테헤란로 133, 18층(역삼동) <span class="css-1ekjygq ebj6vxr1"></span> 대표이사 : 김슬아<br>채용문의 :<a href="mailto:recruit@kurlycorp.com" class="css-1tby8gd ebj6vxr0">recruit@kurlycorp.com</a><br>팩스: 070 - 7500 - 6098
                    </div><ul class="css-zjik7 ek68y4g1"><a href="https://instagram.com/marketkurly" target="_blank" rel="noreferrer" class="css-9ipg3 ek68y4g0"><img src="https://res.kurly.com/pc/ico/1810/ico_instagram.png" alt="컬리 인스타그램 바로가기"></a><a href="https://www.facebook.com/marketkurly" target="_blank" rel="noreferrer" class="css-9ipg3 ek68y4g0"><img src="https://res.kurly.com/pc/ico/1810/ico_fb.png" alt="컬리 페이스북 바로가기"></a><a href="https://blog.naver.com/marketkurly" target="_blank" rel="noreferrer" class="css-9ipg3 ek68y4g0"><img src="https://res.kurly.com/pc/ico/1810/ico_blog.png" alt="컬리 네이버블로그 바로가기"></a><a href="https://m.post.naver.com/marketkurly" target="_blank" rel="noreferrer" class="css-9ipg3 ek68y4g0"><img src="https://res.kurly.com/pc/ico/1810/ico_naverpost.png" alt="컬리 네이버포스트 바로가기"></a><a href="https://www.youtube.com/channel/UCfpdjL5pl-1qKT7Xp4UQzQg" target="_blank" rel="noreferrer" class="css-9ipg3 ek68y4g0"><img src="https://res.kurly.com/pc/ico/1810/ico_youtube.png" alt="컬리 유튜브 바로가기"></a></ul>
                </div>
            </div>
            <div class="css-81eeg3 e1t23cq0">
                <button class="css-12t5wjq e57xuci2"><img src="https://res.kurly.com/pc/ico/2208/logo_isms.svg" alt="isms 로고" class="css-1262i6n e57xuci1"><p class="css-bft4sh e57xuci0">[인증범위] 컬리 쇼핑몰 서비스 개발·운영<br>(심사받지 않은 물리적 인프라 제외)<br>[유효기간] 2022.01.19 ~ 2025.01.18</p></button><button class="css-12t5wjq e57xuci2"><img src="https://res.kurly.com/pc/ico/2208/logo_privacy.svg" alt="eprivacy plus 로고" class="css-1262i6n e57xuci1"><p class="css-bft4sh e57xuci0">개인정보보호 우수 웹사이트 ·<br>개인정보처리시스템 인증 (ePRIVACY PLUS)</p></button><button class="css-12t5wjq e57xuci2"><img src="https://res.kurly.com/pc/ico/2208/logo_tosspayments.svg" alt="payments 로고" class="css-as7ifw e57xuci1"><p class="css-bft4sh e57xuci0">토스페이먼츠 구매안전(에스크로)<br>서비스를 이용하실 수 있습니다.</p></button><button class="css-12t5wjq e57xuci2"><img src="https://res.kurly.com/pc/ico/2208/logo_wooriBank.svg" alt="우리은행 로고" class="css-1262i6n e57xuci1"><p class="css-bft4sh e57xuci0">고객님이 현금으로 결제한 금액에 대해 우리은행과<br>채무지급보증 계약을 체결하여 안전거래를 보장하고<br>있습니다.</p></button>
            </div>
        </div>
        <div class="css-175n8cp etk3uz81">컬리에서 판매되는 상품 중에는 컬리에 입점한 개별 판매자가 판매하는 마켓플레이스(오픈마켓) 상품이 포함되어 있습니다.<br>마켓플레이스(오픈마켓) 상품의 경우 컬리는 통신판매중개자로서 통신판매의 당사자가 아닙니다. 컬리는 해당 상품의 주문, 품질, 교환/환불 등 의무와 책임을 부담하지 않습니다.<em class="css-1vhhy2d etk3uz80">© KURLY CORP. ALL RIGHTS RESERVED</em>
        </div>
    </div>
</footer>




<script>



    $('.login_button').on("click", function (){
        console.log('클릭')
        abc();

    });
    $('#loginform input').on('keydown', function (event) {
        if (event.which === 13) {
            console.log('엔터');
            abc();
        }
    });


    function abc(){
        let id_reg = /^[a-zA-Z](?=.*[0-9])[a-zA-Z0-9_]{6,16}$/;
        let pwd_reg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{10,}$/;
        let form = $('#loginform');

        let id = $('input[name="mem_id"]').val();
        let pwd = $('input[name="mem_pwd"]').val();

        if(!id_reg.test(id) && !pwd_reg.test(pwd)){
            alert('입력하신 내용을 다시 확인해주세요.');

        }else {
            form.attr("method", "post");
            form.attr("action", "/login").submit();
        }
    }


    $('.sign_in_button').on("click", function (){
        console.log('회원가입')
        let form = $('#loginform');
        form.attr("method", "GET");
        form.attr("action", "/member/join").submit();


    });

    $('.btm').on("click", function (){
        console.log('회원가입')
        window.location.href = "/join";

    });

    $('.kakao_a').on("click", function () {
        var currentId = $(this).attr('class');
        //현재 작업 중인 도메인 주소
        var currentDomain = window.location.origin;
        if(currentId.includes('active')){
            $(this).removeClass('active').addClass('non');
            window.location.href ="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=adb16712b617f7a830213eb50de44a79&redirect_uri="+currentDomain+"/auth/kakao/callback";

        }
    });



</script>
</body>
</html>