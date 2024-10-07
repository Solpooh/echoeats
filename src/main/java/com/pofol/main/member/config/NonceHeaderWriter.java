//package com.pofol.main.member.config;
//
//import org.springframework.security.web.header.HeaderWriter;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import java.util.UUID;
//
//public class NonceHeaderWriter implements HeaderWriter {
//    @Override
//    public void writeHeaders(HttpServletRequest request, HttpServletResponse response) {
//        String nonce = UUID.randomUUID().toString();
//        request.setAttribute("nonce", nonce);
//        response.setHeader("Content-Security-Policy", "script-src 'self' https://code.jquery.com 'nonce-" + nonce + "';");
//    }
//}
