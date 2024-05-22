<%@ tag import="java.nio.charset.StandardCharsets" %>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="value" required="true" %>
<%
    String encodedValue = java.net.URLEncoder.encode((String) attributes.get("value"), StandardCharsets.UTF_8);
    out.print(encodedValue);
%>
