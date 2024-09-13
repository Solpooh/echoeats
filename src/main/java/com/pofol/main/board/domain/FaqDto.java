package com.pofol.main.board.domain;

import lombok.Getter;

import java.util.ArrayList;
import java.util.List;


public class FaqDto {
    private int faq_id;
    private String faq_type;
    private String faq_title;
    private String faq_con;
    private Integer page = 1;
    private Integer pageSize = 10;
    private Integer offset;
    private Integer totalCnt;
    private Integer totalPage;
    /* 이미지 정보 */
    private List<ImageDto> imageList = new ArrayList<>();
    public int getFaq_id() {
        return faq_id;
    }

    public void setFaq_id(int faq_id) {
        this.faq_id = faq_id;
    }

    public FaqDto() {
//        this.imageList = new ArrayList<>();
    }

    public FaqDto(int faq_id, String faq_type, String faq_title, String faq_con, Integer page, Integer pageSize, Integer offset, Integer totalCnt, Integer totalPage, List<ImageDto> imageList) {
        this.faq_id = faq_id;
        this.faq_type = faq_type;
        this.faq_title = faq_title;
        this.faq_con = faq_con;
        this.page = page;
        this.pageSize = pageSize;
        this.offset = offset;
        this.totalCnt = totalCnt;
        this.totalPage = totalPage;
        this.imageList = imageList;
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

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getOffset() {
        return (page-1) * pageSize;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getTotalCnt () {
        return totalCnt;
    }

    public void setTotalCnt(Integer totalCnt) {
        this.totalCnt = totalCnt;
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer pageSize) {
        this.totalPage = totalPage;
    }

    public List<ImageDto> getImageList() {
        return imageList;
    }

    public void setImageList(List<ImageDto> imageList) {
        this.imageList = imageList;
    }

    @Override
    public String   toString() {
        return "FaqDto{" +
                "faq_id=" + faq_id +
                ", faq_type='" + faq_type + '\'' +
                ", faq_title='" + faq_title + '\'' +
                ", faq_con='" + faq_con + '\'' +
                ", page=" + page +
                ", pageSize=" + pageSize +
                ", offset=" + offset +
                ", totalCnt=" + totalCnt +
                ", totalPage=" + totalPage +
                ", imageList=" + imageList +
                '}';
    }
}
