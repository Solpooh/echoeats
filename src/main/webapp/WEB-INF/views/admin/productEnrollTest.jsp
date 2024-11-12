<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="nonce" value="${requestScope.cspNonce}" />

<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="../resources/css/admin/productEnroll.css">
    <%-- 달력 위젯을 위한 스타일 시트 --%>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css"/>

    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous" nonce="${nonce}"></script>
    <%-- 위지윅을 위한 script src --%>
    <script src="https://cdn.ckeditor.com/ckeditor5/40.1.0/classic/ckeditor.js" nonce="${nonce}"></script>
    <%-- 달력위젯을 위한 script src --%>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" nonce="${nonce}"></script>
    <script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js" nonce="${nonce}"></script>
</head>
<body>

</body>
</html>
