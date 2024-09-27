package com.pofol.main.board.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Objects;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class SearchBoardCondition {
    private int page = 1;
    private Integer pageSize = DEFAULT_PAGE_SIZE;
    private String option = "";
    private String keyword = "";

    public static final int MIN_PAGE_SIZE = 5;
    public static final int DEFAULT_PAGE_SIZE = 10;
    public static final int MAX_PAGE_SIZE = 50;

    public SearchBoardCondition(Integer page, Integer pageSize) {
        this(page, pageSize, "", "");
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

    public void setPageSize(Integer pageSize) {
        this.pageSize = Objects.requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);

        // MIN_PAGE_SIZE <= pageSize <= MAX_PAGE_SIZE
        this.pageSize = Math.max(MIN_PAGE_SIZE, Math.min(this.pageSize, MAX_PAGE_SIZE));
    }

    public Integer getOffset() {
        return (page - 1) * pageSize;
    }
}