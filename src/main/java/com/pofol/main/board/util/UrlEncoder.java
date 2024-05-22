package com.pofol.main.board.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class UrlEncoder {
    public static String encode(String value) {
        try {
            return URLEncoder.encode(value, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return value;
        }
    }
}