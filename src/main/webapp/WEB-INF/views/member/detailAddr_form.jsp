<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String addr = request.getParameter("addr"); %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>detail</title>
    <link rel="stylesheet" href="/resources/css/member/detailAddr_form.css">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>


<body>
<div id="__next" data-reactroot="">
    <div class="css-sv3mbe e1u1sq1y0">
        <div class="css-ixlb9s ecqulhg2">
            <div class="css-0 e11n32x24"><strong class="css-1702mcg e11n32x23"><span type="direct"
                                                                                     class="css-1kxzrwz e11n32x22">에코배송</span> 지역입니다.<p class="css-1d1s4ku e11n32x21">매일 새벽,
                문 앞까지 신선함을 전해드려요.</p></strong></div>
            <div class="css-19u3hc5 e1n7pxx51">
                <p class="css-ks8pmw e1n7pxx50" id="addr"><%=addr%></p>
                <button class="css-1w63xsn e4nu7ef3" type="button" width="120" height="44" radius="3">
                    <span class="css-nytqmg e4nu7ef1">
                        <img src="/resources/icons/eco_green_search.svg" alt="" class="css-1m3kac1 e4nu7ef0">재검색</span>
                </button>
            </div>
            <div class="css-1hxvx8x e1uzxhvi6">
                <div height="44" class="css-t7kbxx e1uzxhvi3"><input data-testid="input-box" id="addressDetail"
                                                                     name="addressDetail" placeholder="나머지 주소를 입력해 주세요" type="text" height="44"
                                                                     class="css-1quw3ub e1uzxhvi2" value=""></div>
            </div>
            <div class="css-a0w530 ecqulhg1"><label class="css-1wkyvs2 e1dcessg3"><input type="checkbox"
                                                                                         class="css-agvwxo e1dcessg2" id="checkbox">
                <div class="css-79hxr7 e1dcessg1"><svg width="24" height="24" viewBox="0 0 24 24"
                                                       fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path
                            d="M23.5 12C23.5 18.3513 18.3513 23.5 12 23.5C5.64873 23.5 0.5 18.3513 0.5 12C0.5 5.64873 5.64873 0.5 12 0.5C18.3513 0.5 23.5 5.64873 23.5 12Z"
                            stroke="#ddd" fill="#fff"></path>
                    <path d="M7 12.6667L10.3846 16L18 8.5" stroke="#ddd" stroke-width="1.5"
                          stroke-linecap="round" stroke-linejoin="round"></path>
                </svg></div><span>기본 배송지로 저장</span>
            </label></div><button class="css-10voksq e4nu7ef3" type="button" height="44" radius="3" id="save_btn"><span
                class="css-nytqmg e4nu7ef1">저장</span></button>
        </div>
    </div>
</div>
<script>
    let mem_id = "${mem_id}";
    let checkbox = document.getElementById("checkbox");
    let def_addr = "N";

    //체크박스
    checkbox.addEventListener("change", function (){
        let svgPath = checkbox.parentElement.querySelector(".css-79hxr7 path");
        if (checkbox.checked) {
            svgPath.setAttribute("stroke", "#fff");
            svgPath.setAttribute("fill", "#00c73c");
            def_addr = "Y";
        } else {
            svgPath.setAttribute("stroke", "#ddd");
            svgPath.setAttribute("fill", "#fff");
            def_addr = "N";
        }
    })

    $("#save_btn").click(function sendData() {
        let addr = document.getElementById("addr").innerText;
        let dtl_addr = document.getElementById("addressDetail").value;
        let data = {
            dtl_addr: dtl_addr,
            addr: addr,
            def_addr: def_addr,
            mem_id: mem_id
        };
        console.log(data)
        $.ajax({
            type: "POST",
            url:"detail",
            headers:{
                "content-type": "application/json"
            },
            data: JSON.stringify(data),
            dataType: "json",
            success: function(response) {
                console.log(response)
                alert("성공");
                window.close();
            },
            error: function(error){
                console.log(error);
            }
        })
    })

</script>
</body>

</html>
