package com.pofol.main.board.domain;

import org.springframework.web.util.UriComponentsBuilder;

import java.util.Objects;

public class SearchBoardCondition {
    private int page = 1;
    private Integer pageSize = DEFAULT_PAGE_SIZE;
    private Integer offset = 0;
    private String  option = "";
    private String  keyword = "";
//    private Integer  offset;

    public static final int MIN_PAGE_SIZE = 5;
    public static final int DEFAULT_PAGE_SIZE = 10;
    public static final int MAX_PAGE_SIZE = 50;

    public SearchBoardCondition(){}

    public SearchBoardCondition(Integer page, Integer pageSize) {
        this(page, pageSize, "", "");
    }

    public SearchBoardCondition(Integer page, Integer pageSize, String option, String keyword) {
        this.page = page;
        this.pageSize = pageSize;
        this.option = option;
        this.keyword = keyword;
    }

    public String getQueryString() {
        return getQueryString(page);
    }

    public String getQueryString(Integer page) {
        // ?page=10&pageSize=10&option=A&keyword=title
        return UriComponentsBuilder.newInstance()
                .queryParam("page",     page)
                .queryParam("pageSize", pageSize)
                .queryParam("option",   option)
                .queryParam("keyword",  keyword)
                .build().toString();
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = Objects.requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);

        // MIN_PAGE_SIZE <= pageSize <= MAX_PAGE_SIZE
        this.pageSize = Math.max(MIN_PAGE_SIZE, Math.min(this.pageSize, MAX_PAGE_SIZE));
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Integer getOffset() {
        return (page-1)*pageSize;
    }

    @Override
    public String toString() {
        return "SearchBoardCondition{" +
                "page=" + page +
                ", pageSize=" + pageSize +
                ", option='" + option + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}