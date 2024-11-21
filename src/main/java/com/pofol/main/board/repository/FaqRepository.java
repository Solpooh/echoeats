package com.pofol.main.board.repository;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.orders.order.domain.SearchOrderCondition;

import java.util.List;
import java.util.Map;

public interface FaqRepository {
    int insert(FaqDto dto) throws Exception;
    int update(FaqDto dto) throws Exception;
    int delete(FaqDto dto) throws Exception;
    List<FaqDto> selectAll(FaqDto dto) throws Exception;

    // 페이징처리 된 리스트 가져오기
    List<FaqDto> selectPaged(Map map) throws Exception;
    FaqDto select(int bno) throws Exception;
    int count(FaqDto dto) throws Exception;
}
