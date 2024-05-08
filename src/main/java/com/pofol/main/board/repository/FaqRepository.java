package com.pofol.main.board.repository;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.orders.order.domain.SearchOrderCondition;

import java.util.List;

public interface FaqRepository {
    int insert(FaqDto dto) throws Exception;
    int update(FaqDto dto) throws Exception;
    int delete(FaqDto dto) throws Exception;

    // faq_type을 입력으로 받아줘야 하기 때문에 매개변수로 객체타입
    List<FaqDto> selectAll(FaqDto dto) throws Exception;
    FaqDto select(int bno) throws Exception;
    int count(FaqDto dto) throws Exception;
}
