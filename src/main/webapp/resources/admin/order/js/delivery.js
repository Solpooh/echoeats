//운송장 번호 입력
function updateValue(input){
    const inputValue = input.value;

    if(inputValue === '0'){
        input.value = '';
    }
    else{
        input.value = inputValue.replace(/[^-0-9]/g, '').slice(0,12);
    }
}

//배송중 처리 버튼을 누르면
document.getElementById("deliveringBtn").addEventListener('click', function(){
    //.allChk 체크박스에 check된 것만 가지고 온다.
    let list = document.querySelectorAll('input[name="dlvyChk"]:checked');
    if(list.length === 0 ){
        alert("체크된 항목이 없습니다.")
        return;
    }

    let waybillNumArr = []; //운송장 번호 입력할 배열

    try{
        list.forEach((item) => {
            //먼저 dlvyChk 체크박스에 dateset으로 운송장 번호를 등록해야한다.
            //0. 배송상태가 "DELIVERY_PREPARING"인지 확인
            if(item.dataset.status !== "DELIVERY_PREPARING"){
                throw new Error("배송상태가 올바르지 않습니다. 다시 선택해주세요.")
            }
            //1. 클릭한 checkbox와 같은 tr에 있는 .waybillNum을 가져오고 싶다.
            let waybillNum = item.closest('tr').querySelector('.waybillnum').value;

            //2. 운송장 번호가 제대로 입력되었는지 확인한다.
            if(waybillNum.length !== 12){
                throw new Error("운송장번호를 정확히 입력해주세요(숫자 12자리)")
            }

            //3. 운송장번호가 기존에 있었던 운송장인지 확인한다.
            let findElement = waybillNumArr.find((element) => element.waybillNum === waybillNum);

            if( findElement !== undefined){ //arr안에 운송장번호가 있을 때
                //포장타입이 배열안에 있는 포장타입과 item의 포장타입과 맞는지 확인한다.
                if(findElement.packType === item.dataset.packtype){ //포장타입이 같으면
                    item.dataset.waybillNum = waybillNum; //운송장번호를 item에 dataset으로 넣어준다.
                }else{
                    throw new Error("포장타입이 일치하지 않습니다.")
                }
            } else{ //운송장번호가 배열에 없을 때
                //-1) 운송장번호와 packtype을 객체로 해서 배열에 추가한다.
                waybillNumArr.push({
                    waybillNum: waybillNum,
                    packType: item.dataset.packtype
                });

                //-2) 운송장번호를 item에 dataset으로 넣어준다.
                item.dataset.waybillNum = waybillNum;
            }
        });
    }catch (e){
        alert(e.message);
        location.reload();
        return false;
    }

    let ajaxData = [];

    list.forEach((item,index,list) => {
        ajaxData.push({
            ord_det_id: item.dataset.id,
            waybill_num: item.dataset.waybillNum,
            dlvy_sts: item.dataset.status,
            pack_type: item.dataset.packtype
        });
    });

    ajax(ajaxData,"registerWaybillNum")
});

//배송 완료 처리 -> 운송장번호 하나라도 상태가 배송완료로 바뀌면 같은 운송장번호를 가진 주문상세의 상태도 모두 바뀐다.
document.getElementById("deliveryCompleteBtn").addEventListener('click', function(){

    let list = document.querySelectorAll('input[name="dlvyChk"]:checked');
    if(list.length === 0 ){
        alert("체크된 항목이 없습니다.")
        return;
    }
    let ajaxSet = new Set();

    try{
        list.forEach((item) => {
            if(item.dataset.status !== "DELIVERING"){
                throw new Error("배송상태가 올바르지 않습니다. 다시 선택해주세요")
            }
            let waybillNum = item.closest('tr').querySelector('.waybillvalue').innerText;
            ajaxSet.add(waybillNum);
        });
    }catch (e) {
        alert(e.message);
        location.reload();
        return false;
    }
    console.log("set", ajaxSet);
    let ajaxData = Array.from(ajaxSet);
    ajax(ajaxData,"DeliveryComplete")
});


let ajax = function(ajaxData, url){
    $.ajax({
        type:'POST',
        url: '/admin/delivery/'+url,
        headers:{"content-type": "application/json"},
        dataType: 'text',
        data : JSON.stringify(ajaxData),
        success: function(result){
            if(result === 'DELIVERING'){
                alert("배송중 처리가 성공적으로 완료되었습니다.")
            }else {
                //DELIVERY_COMPLETE
                alert("배송완료 처리가 성공적으로 완료되었습니다.")
            }
            location.reload();
        },
        error: function (result){
            if (result.responseText === "Mismatch PackType") {
                alert("포장타입이 일치하지 않습니다. \n운송장 번호를 다시 입력해주세요.\n(주의: 같은 포장 타입일 때만 같은 운송장 번호를 입력할 수 있습니다.)")
            }else{
                alert("🔥"+ result.responseText);
            }
        }
    })
}