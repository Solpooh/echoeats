package com.pofol.main.board.domain;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class FaqDto {
    private int faq_id;
    private String faq_type;
    private String faq_title;
    private String faq_con;
    private int rownum;
    private Integer page = 1;
    private Integer pageSize = 10;
    private Integer offset;
    private Integer totalCnt;
    private Integer totalPage;
    private List<ImageDto> imageList = new ArrayList<>();

    public String getFaq_type() {
        if("전체".equals(faq_type)) {
            return null;
        }
        return faq_type;
    }

    public Integer getOffset() {
        return (page-1) * pageSize;
    }

}
