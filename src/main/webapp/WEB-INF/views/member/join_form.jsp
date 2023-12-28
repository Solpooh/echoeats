<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <script src = "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="/resources/css/member/join.css">
    <link rel="stylesheet" href="/resources/product/css/main-css.css">
</head>
<body>

<%@ include file="../include/header.jspf" %>

<div class="css-pculus e1ovi4141">
    <div class="title">회원가입</div>
    <div class="sign_in_form">
        <div class="first">
            <span class="star">*</span>
            필수입력사항
        </div>
        <%--        <form class="form" id="form">--%>
        <div class="form">
            <div class="form_in id">
                <div class="one">
                    <label class="one_label">
                        아이디
                        <span class="one_span">*
                      </span></label>
                </div>
                <div class="two">
                    <input type="text" id="mem_id" name="memberId" placeholder="아이디를 입력해주세요">
                    <div id="idErrorMsg" style="color: red; font-size: 12px;"></div>
                </div>
                <div class="three">
                    <button id="idCheck_btn"><span>중복확인</span></button>
                </div>
            </div>
            <div class="form_in pwd">
                <div class="one">
                    <label class="one_label">
                        비밀번호
                        <span class="one_span">*
                            </span></label>
                </div>
                <div class="two">
                    <input type="password" id="mem_pwd" placeholder="비밀번호를 입력해주세요">
                    <div id="pwdErrorMsg" style="color: red; font-size: 12px;"></div>
                </div>
                <div class="three">

                </div>
            </div>
            <div class="form_in pwd_check">
                <div class="one">
                    <label class="one_label">
                        비밀번호 확인
                        <span class="one_span">*
                            </span></label>
                </div>
                <div class="two">
                    <input type="password" id="mem_pwd2" placeholder="비밀번호를 한번 더 입력해주세요">
                    <div id="pwd2ErrorMsg" style="color: red; font-size: 12px;"></div>
                </div>
                <div class="three">

                </div>
            </div>
            <div class="form_in name">
                <div class="one">
                    <label class="one_label">
                        이름
                        <span class="one_span">*
                            </span></label>
                </div>
                <div class="two">
                    <input type="text" id="mem_name" placeholder="이름을 입력해 주세요">
                </div>
                <div class="three">

                </div>
            </div>
            <div class="form_in email">
                <div class="one">
                    <label class="one_label">
                        이메일
                        <span class="one_span">*
                            </span></label>
                </div>
                <div class="two">
                    <input type="text" id="mem_email" placeholder="예: ecoeats@ecoeats.com">
                    <div id="emailErrorMsg" style="color: red; font-size: 12px;"></div>
                </div>
                <div class="three">
                    <button id="emailCheck_btn"><span>중복확인</span></button>
                </div>
            </div>
            <div class="form_in phone">
                <div class="one">
                    <label class="one_label">
                        휴대폰
                        <span class="one_span">*
                            </span></label>
                </div>
                <div class="two">
                    <input type="text" id="mem_phone" placeholder="숫자만 입력해주세요">
                    <div id="phoneErrorMsg" style="color: red; font-size: 12px;"></div>
                </div>
                <div class="three">
                    <button type="button" disabled><span>인증번호 받기</span></button>
                </div>
            </div>
            <div class="form_in address">
                <div class="one">
                    <label class="one_label">
                        주소
                        <span class="one_span">*
                                        </span></label>
                </div>
                <div class="two">
                    <input type="text" id="addr" readonly="">
                    <input type="text" id="subAddr" placeholder="상세주소를 입력해주세요">
                    <%--                    <span class="address_warm">배송지에 따라 상품 정보가 달라질 수 있습니다.</span>--%>
                </div>
                <div class="three">
                    <button type="button" class="address_button" type="button" height="44" radius="4" onclick="kakaopost()">
                        <span><img src="" alt=""> 주소 검색</span>
                    </button>
                </div>
            </div>
            <div class="form_in gender">
                <div class="one">
                    <label class="one_label">
                        성별
                        <span class="one_span">
                            </span></label>
                </div>
                <div class="two">
                    <div class="two_gender">
                        <label>
                            <input type="radio" name="gender" value="남자">
                            <span class="gender_checkbox"><div></div></span>
                            <span class="gender_text">남자</span>
                        </label>
                        <label>
                            <input type="radio" name="gender" value="여자">
                            <span class="gender_checkbox"><div></div></span>
                            <span class="gender_text">여자</span>
                        </label>
                        <label>
                            <input type="radio" name="gender" value="none">
                            <span class="gender_checkbox"><div></div></span>
                            <span class="gender_text">선택안함</span>
                        </label>
                    </div>
                </div>
                <div class="three">

                </div>
            </div>
            <div class="form_in birth">
                <div class="one">
                    <label class="one_label">
                        생년월일
                        <span class="one_span">
                            </span></label>
                </div>
                <div class="two">
                    <div class="two_birth">
                        <div><input type="text" id="mem_birthYYYY" placeholder="YYYY"></div>
                        <span></span>
                        <div><input type="text" id="mem_birthMM" placeholder="MM"></div>
                        <span></span>
                        <div><input type="text" id="mem_birthDD" placeholder="DD"></div>
                    </div>
                </div>
                <div class="three">
                </div>
            </div>
        </div>
        <div class="mini_space"></div>
        <div class="checkbox">
            <div class="checkbox_text">
                <label>이용약관동의
                    <span>*
                        </span>
                </label>
            </div>
            <div class="checkbox_check">
                <div class="check_all">
                    <label>
                        <input type="checkbox" id="all_check">
                        <div></div>
                        <span>전체 동의합니다.</span>
                    </label>
                    <p>선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 있습니다.</p>
                </div>
                <div>
                    <div>
                        <label>
                            <input type="checkbox" name="checkbox" id="info1">
                            <div></div>
                            <span>이용약관 동의</span>
                        </label>
                        <span>(필수)</span>
                    </div>
                    <a href="">약관보기 ></a>
                </div>
                <div>
                    <div>
                        <label>
                            <input type="checkbox" name="checkbox" id="info2">
                            <div></div>
                            <span>개인정보 수집∙이용 동의</span>
                        </label>
                        <span>(필수)</span>
                    </div>
                    <a href="">약관보기 ></a>
                </div>
                <div>
                    <div>
                        <label>
                            <input type="checkbox" name="checkbox" id="checkbox1">
                            <div></div>
                            <span>개인정보 수집∙이용 동의</span>
                        </label>
                        <span>(선택)</span>
                    </div>
                    <a href="">약관보기 ></a>
                </div>
                <div class="event">   <!-- 무료배송,할인쿠폰 등 혜택/정보 수신 동의-->
                    <div>
                        <label>
                            <input type="checkbox" name="checkbox" id="checkbox2">
                            <div></div>
                            <span>무료배송,할인쿠폰 등 혜택/정보 수신 동의</span>
                        </label>
                        <span>(선택)</span>
                    </div>
                </div>
                <div>
                    <div>
                        <label>
                            <input type="checkbox" name="checkbox" id="info3">
                            <div></div>
                            <span>본인은 만 14세 이상입니다.</span>
                        </label>
                        <span>(필수)</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="sign_in_button">
            <button id="sign_in_button">
                <span>가입하기</span>
            </button>
        </div>
    </div>
</div>

<script>
    const form1 = document.getElementsByClassName('form')[0];
    const friend = document.getElementById('friend');

    // 아이디, 비밀번호, 전화번호, 이름 정규표현식
    function regMemberid(mem_id) {
        //영문자 또는 숫자 6~16자
        var regExp = /^[A-za-z0-9]{6,15}$/;
        return regExp.test(mem_id);
    }

    function regPassword(mem_pwd) {
        //8~16자 영문, 숫자 조합
        var regExp = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z\S]{8,16}$/;
        return regExp.test(mem_pwd);
    }

    function regPhoneNumber(mem_phone) {
        // 전화번호 형식: 01X-XXXX-XXXX 또는 01X-XXX-XXXX
        var regExp = /^01[0-9]\d{7,8}$/;
        return regExp.test(mem_phone);
    }
    // 휴대폰 번호 입력 필드에 대한 이벤트 처리
    document.getElementById('mem_phone').addEventListener('input', function() {
        // 현재 입력된 값에서 숫자만 추출
        var filteredValue = this.value.replace(/[^\d]/g, '');

        // 입력 필드에 필터링된 값 설정
        this.value = filteredValue;
    });


    // function regMemberName(mem_name) { //이름
    //     var regExp = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
    //     return regExp.test(mem_name);
    // }

    function regMemberEmail(mem_email) { //이메일
        var regExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        return regExp.test(mem_email);
    }
    //아이디 정규식 체크
    $("#idErrorMsg").text("").hide();
    document.getElementById('mem_id').addEventListener('input', function() {
        var mem_id = this.value;

        if (!regMemberid(mem_id)) {
            $("#idErrorMsg").text("영문자 또는 숫자 6~16자로 해주세요.").show();
        } else {
            $("#idErrorMsg").text("").hide();
        }
    });

    //비밀번호 정규식 체크
    $("#pwdErrorMsg").text("").hide();
    document.getElementById('mem_pwd').addEventListener('input', function() {
        var mem_pwd = this.value;

        if (!regPassword(mem_pwd)) {
            $("#pwdErrorMsg").text("8~16자 영문, 숫자 조합으로 해주세요.").show();
        } else {
            $("#pwdErrorMsg").text("").hide();
        }
    });
    //비밀번호 일치 체크
    $("#pwd2ErrorMsg").text("").hide();
    document.getElementById('mem_pwd2').addEventListener('input', function() {
        let mem_pwd2 = document.getElementById('mem_pwd2').value;
        let mem_pwd = document.getElementById('mem_pwd').value;
        if(mem_pwd !== mem_pwd2){
            $("#pwd2ErrorMsg").text("비밀번호를 일치하게 입력해주세요.").show();
        } else {
            $("#pwd2ErrorMsg").text("").hide();
        }
    });
    //이메일 정규식 체크
    $("#emailErrorMsg").text("").hide();
    document.getElementById('mem_email').addEventListener('input', function() {
        var mem_email = this.value;

        if (!regMemberEmail(mem_email)) {
            $("#emailErrorMsg").text("올바르지 않은 이메일형식입니다.").show();
        } else {
            $("#emailErrorMsg").text("").hide();
        }
    });
    //전화번호 정규식 체크
    $("#phoneErrorMsg").text("").hide();
    document.getElementById('mem_phone').addEventListener('input', function() {
        var mem_phone = this.value;

        if (!regPhoneNumber(mem_phone)) {
            $("#phoneErrorMsg").text("01X-XXX-XXXX 또는 01X-XXXX-XXXX입니다.").show();
        } else {
            $("#phoneErrorMsg").text("").hide();
        }
    });

    var idCheck = 0;
    var pwdCheck = 0;
    var phoneCheck = 0;
    var info = 0
    var emailCheck = 0;

    // 아이디 중복 체크
    $("#idCheck_btn").click(function () {
        var inputed = $('#mem_id').val();
        console.log(inputed);
        $.ajax({
            data: {
                mem_id: inputed
            },
            url: "checkId",
            dataType: "json",
            success: function (data) {
                if (data == 1) {
                    alert("아이디가 중복되었어요.")
                    idCheck = 0;
                } else if (regMemberid(inputed) == false || inputed.length > 14) {
                    alert("영문자 또는 숫자 6~16자로 해주세요.")
                    idCheck = 0;
                } else if (data == 0 && regMemberid(inputed)) {
                    alert("사용가능한 아이디이십니다.")
                    idCheck = 1;
                    $("#idCheck_btn").prop("disabled", true).css("background-color", "#CCCCCC");
                    $("#mem_id").prop("readonly", true);
                }
            },
        })
    });
    // 이메일 체크
    $("#emailCheck_btn").click(function () {
        var inputed = $('#mem_email').val();
        $.ajax({
            data: {
                mem_email: inputed
            },
            url: "checkEmail",
            dataType: "json",
            success: function (data) {
                if (data == 1) {
                    alert("이메일이 중복되었습니다.")
                    emailCheck = 0;
                } else if (regMemberEmail(inputed) == false) {
                    alert("올바르지 않은 이메일 형식입니다.")
                    emailCheck = 0;
                } else if (data == 0 && regMemberEmail(inputed)) {
                    alert("사용가능한 이메일이십니다.")
                    emailCheck = 1;
                    $("#emailCheck_btn").prop("disabled", true).css("background-color", "#CCCCCC");
                    $("#mem_email").prop("readonly", true);
                }
            },
        })
    });

    //비밀번호 체크
    function checkPwd() {
        if ($("#mem_pwd").val() === $("#mem_pwd2").val()) {
            pwdCheck = 1;
        }
    }
    //번호 정규식 체크
    function checkPhone() {
        if(regPhoneNumber($("#mem_phone").val())){
            phoneCheck = 1;
        }
    }



    //주소검색 api
    function kakaopost() {
        new daum.Postcode({
            oncomplete: function (data) {
                document.querySelector("#addr").value =  data.address
            }
        }).open();
    }


    //체크박스
    checkboxs = document.getElementsByName('checkbox');
    checkall = document.getElementById('all_check');
    checkall.onchange = function () {
        if (checkall.checked) {
            for (let i = 0; i < checkboxs.length; i++) {
                checkboxs[i].checked = true;
            }
        } else {
            for (let i = 0; i < checkboxs.length; i++) {
                checkboxs[i].checked = false;
            }
        }
        if(checkbox1.checked){
            per_info_col = "Y";
        }else {
            per_info_col = "N";
        }
        if(checkbox2.checked){
            free_ship_recep = "Y";
        }else {
            free_ship_recep = "N";
        }
    }
    checkboxs.forEach(function (checkbox) {
        checkbox.addEventListener('change', function () {
            if (!checkbox.checked) {
                checkall.checked = false;
            } else {
                for (let i = 0; i < checkboxs.length; i++) {
                    if (checkboxs[i].checked === false) {
                        return;
                    }
                }
                checkall.checked = true;
            }
        });
    });

    //성별 선택
    let genders = document.getElementsByName("gender");
    let gender;

    genders.forEach(function (x) {
        x.addEventListener('change', function () {
            if (x.checked == true) {
                gender = x.value;
                console.log(gender);
            }
        });
    });


    //개인정보수집동의
    checkbox1 = document.getElementById("checkbox1");
    checkbox2 = document.getElementById("checkbox2");
    let info1 = document.getElementById("info1");
    let info2 = document.getElementById("info2");
    let info3 = document.getElementById("info3");

    //현재 도메인 주소 동적으로 추가
    var currentDomain = window.location.origin;

    let per_info_col = "N";
    let free_ship_recep = "N";

    checkbox1.addEventListener('change', function () {
        if(checkbox1.checked){
            per_info_col = "Y";
        }else {
            per_info_col = "N";
        }
    })
    checkbox2.addEventListener('change', function () {
        if(checkbox2.checked){
            free_ship_recep = "Y";
        }else {
            free_ship_recep = "N";
        }
    })

    //이용약관동의 필수체크
    function infoCheck(){
        return (info1.checked && info2.checked && info3.checked);
    }
    //가입하기
    let index = {
        init: function() {
            $("#sign_in_button").on("click", ()=>{
                this.save();
            })
        },

        save: function () {
            let data = {
                mem_id: $("#mem_id").val(),
                mem_pwd: $("#mem_pwd").val(),
                mem_name:$("#mem_name").val(),
                mem_email:$("#mem_email").val(),
                mem_phone:$("#mem_phone").val(),
                mem_gender:gender,
                mem_birth:$("#mem_birthYYYY").val() + $("#mem_birthMM").val() + $("#mem_birthDD").val(),
                per_info_col: per_info_col, free_ship_recep: free_ship_recep,
                rg_date: "now()", md_date:"now()"
            };
            console.log(data)
            $.ajax({
                type: "POST",
                url: "join",
                data: JSON.stringify(data),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            }).done(function () {
                let inputed = {
                    mem_id: $("#mem_id").val(),
                    addr: $("#addr").val(),
                    dtl_addr: $("#subAddr").val(),
                    def_addr: "Y"
                }
                $.ajax({
                    type: "POST",
                    url: currentDomain+"/address/detail",  //고친 곳
                    data: JSON.stringify(inputed),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json"
                })
                checkPwd();
                checkPhone();
                if (idCheck == 0) {
                    alert("id중복확인 눌러주세요")
                } else if (pwdCheck == 0) {
                    alert("비밀번호가 동일하지않습니다.")
                }
                else if (phoneCheck == 0) {
                    alert("허용되지 않는 전화번호입니다.")
                }
                else if (emailCheck == 0) {
                    alert("email중복확인 눌러주세요.")
                }
                else if (!infoCheck()){
                    alert("필수이용약관을 동의해주세요")
                }
                else if (idCheck == 1 && pwdCheck == 1 && emailCheck == 1 && infoCheck()) {
                    alert("회원가입이 완료되었습니다.")
                    location.href = currentDomain+"/main";    //고친 곳
                }
            }).fail(function (error){
                alert("회원가입에 실패하셨습니다.")
                alert(JSON.stringify(error));
            });
            // })
        }
    }
    index.init();



</script>
</body>
</html>