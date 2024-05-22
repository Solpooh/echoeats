//package com.pofol.main.board.tags;
//
//import javax.servlet.jsp.JspException;
//import javax.servlet.jsp.JspWriter;
//import javax.servlet.jsp.tagext.SimpleTagSupport;
//import java.io.IOException;
//import java.net.URLEncoder;
//
//public class EncodeUrlTag extends SimpleTagSupport {
//    private String value;
//
//    public void setValue(String value) {
//        this.value = value;
//    }
//
//    @Override
//    public void doTag() throws JspException, IOException {
//        if (value != null) {
//            JspWriter out = getJspContext().getOut();
//            out.print(URLEncoder.encode(value, "UTF-8"));
//        }
//    }
//}