package com.pofol.main.board.domain;

public class FaqDto {
    private int faq_id;
    private String faq_type;
    private String faq_title;
    private String faq_con;
    public int getFaq_id() {
        return faq_id;
    }

    public void setFaq_id(int faq_id) {
        this.faq_id = faq_id;
    }

    public FaqDto() {}
    public FaqDto(int faq_id, String faq_type, String faq_title, String faq_con) {
        this.faq_id = faq_id;
        this.faq_type = faq_type;
        this.faq_title = faq_title;
        this.faq_con = faq_con;
    }
    public String getFaq_type() {
        if("전체".equals(faq_type)) {
            return null;
        }
        return faq_type;
    }

    public void setFaq_type(String faq_type) {
        this.faq_type = faq_type;
    }

    public String getFaq_title() {
        return faq_title;
    }

    public void setFaq_title(String faq_title) {
        this.faq_title = faq_title;
    }

    public String getFaq_con() {
        return faq_con;
    }

    public void setFaq_con(String faq_con) {
        this.faq_con = faq_con;
    }


    @Override
    public String toString() {
        return "FaqDto{" +
                "faq_id=" + faq_id +
                ", faq_type='" + faq_type + '\'' +
                ", faq_title='" + faq_title + '\'' +
                ", faq_con='" + faq_con + '\'' +
                '}';
    }
}
