$(document).ready(function () {
    // URL 쿼리스트링 가져오기
    function getQueryString() {
        return window.location.search;
    }

    // 목록 버튼 클릭 이벤트
    $('#listButton').on('click', function () {
        location.href = `notice${getQueryString()}`;
    });

    // 검색 keyword가 비어있을 경우
    $('#searchForm').on('submit', function(event) {
        const keyword = $('input[name="keyword"]').val().trim(); // 검색어를 가져옴

        if (keyword === "") {  // 검색어가 비어 있으면
            alert("검색어를 입력해 주세요.");  // 경고 메시지 띄우기
            event.preventDefault();  // 폼 제출 막기
        }
    });
});