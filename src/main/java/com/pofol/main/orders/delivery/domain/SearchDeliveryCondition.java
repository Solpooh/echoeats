package com.pofol.main.orders.delivery.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.util.UriComponentsBuilder;

import java.text.SimpleDateFormat;
import java.util.Date;

import static java.lang.Math.*;
import static java.util.Objects.*;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchDeliveryCondition {
    private Integer page = 1;
    private Integer pageSize = DEFAULT_PAGE_SIZE;
    private String date_type = "";
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date start_date;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date end_date;
    private String keyword_type = "";
    private String keyword = "";

    public static final int MIN_PAGE_SIZE = 5;
    public static final int DEFAULT_PAGE_SIZE = 10;
    public static final int MAX_PAGE_SIZE = 50;

    public SearchDeliveryCondition(Integer page, Integer pageSize){
        this(page, pageSize, "");
    }

    public SearchDeliveryCondition(Integer page, Integer pageSize, String keyword){
        this.page = page;
        this.pageSize = pageSize;
        this.keyword = keyword;
    }

    public String getQueryString(){
        return getQueryString(page);
    }
    public String getQueryString(Integer page){
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("date_type", date_type)
                .queryParam("start_date", dateFormat(start_date))
                .queryParam("end_date", dateFormat(end_date))
                .queryParam("keyword_type", keyword_type)
                .queryParam("keyword", keyword)
                .build().toString();
    }

    public void setPageSize(Integer pageSize){
        this.pageSize = requireNonNullElse(pageSize, DEFAULT_PAGE_SIZE);
        this.pageSize = max(MIN_PAGE_SIZE, min(this.pageSize, MAX_PAGE_SIZE));
    }

    public Integer getOffset(){
        return (page - 1) * pageSize;
    }

    private String dateFormat(Date date) {
        if (date == null) return "";
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        return format.format(date);
    }
}
