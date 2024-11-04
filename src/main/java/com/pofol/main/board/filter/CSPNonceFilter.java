package com.pofol.main.board.filter;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

@Component
public class CSPNonceFilter extends GenericFilterBean {
    private static final int NONCE_SIZE = 32;
    private static final String CSP_NONCE_ATTRIBUTE = "cspNonce";
    private final SecureRandom secureRandom = new SecureRandom();

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        byte[] nonceArray = new byte[NONCE_SIZE];
        secureRandom.nextBytes(nonceArray);
        String nonce = Base64.getEncoder().encodeToString(nonceArray);

        request.setAttribute(CSP_NONCE_ATTRIBUTE, nonce);

        // Content-Security-Policy 헤더 설정
        String cspHeader = "script-src 'self' 'nonce-" + nonce + "'";

        response.setHeader("Content-Security-Policy", cspHeader);

        filterChain.doFilter(request, new CSPNonceResponseWrapper(response, nonce));
    }

    public static class CSPNonceResponseWrapper extends HttpServletResponseWrapper {
        private String nonce;

        public CSPNonceResponseWrapper(HttpServletResponse response, String nonce) {
            super(response);
            this.nonce = nonce;
        }

        @Override
        public void setHeader(String name, String value) {
            if (name.equals("Content-Security-Policy") && !StringUtils.isEmpty(value)) {
                super.setHeader(name, value.replace("{nonce}", nonce));
            } else {
                super.setHeader(name, value);
            }
        }

        @Override
        public void addHeader(String name, String value) {
            if (name.equals("Content-Security-Policy") && !StringUtils.isEmpty(value)) {
                super.addHeader(name, value.replace("{nonce}", nonce));
            } else {
                super.addHeader(name, value);
            }
        }
    }
}
