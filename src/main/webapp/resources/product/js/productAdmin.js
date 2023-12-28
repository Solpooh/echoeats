const startPageDate = document.querySelectorAll('.duet-date-picker');

// 관리자 페이지에서 상품 수정 버튼
const updateButton = document.querySelector('#updateButton');

updateButton.addEventListener("click", function () {

    updateButton.form.action = '/admin/product/modify';
    updateButton.form.method = 'POST';
})

// 카테고리 정렬
let cate1Array = [];
let cate2Array = [];
let cate1Object = {};
let cate2Object = {};

let cate1Select = $('#eCategory1');
let cate2Select = $('#eCategory2');

// 카테고리 배열 초기화 메서드
const makeCategoryArray = function(obj, array, categoryList, tier) {
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
    cate2Select.append('<option selected value="">- 중분류 선택 -</option>');
    for(let i = 0; i < cate2Array.length; i++) {
        if (cate2Array[i].parent_code === selectVal) {
            cate2Select.append('<option value="' + cate2Array[i].cat_code + '">' + cate2Array[i].cat_name + '</option>');
        }
    }
});

$(document).ready(function () {

    for (let i = 0; i < startPageDate.length; i++) {
        startPageDate[i].value = '';
    }
})