package com.pofol.main.board.repository;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.orders.order.domain.SearchOrderCondition;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class FaqRepositoryImpl implements FaqRepository {
    private final SqlSession session;

    public FaqRepositoryImpl(SqlSession session) {
        this.session = session;
    }

    private static String namespace = "com.pofol.main.repository.FaqRepository.";

    // 등록하기
    public int insert(FaqDto dto) {
        return session.insert(namespace + "insert", dto);
    }
    // 수정하기
    public int update(FaqDto dto) {
        return session.update(namespace + "update", dto);
    }

    // 삭제하기
    public int delete(FaqDto dto) {
        return session.delete(namespace + "delete", dto);
    }

    // 전체 리스트 보여주기
    public List<FaqDto> selectAll(FaqDto dto) {
        return session.selectList(namespace + "selectAll", dto);
    }

    // 페이징된 리스트 보여주기
    public List<FaqDto> selectPaged(FaqDto dto) {
        return session.selectList(namespace + "selectPaged", dto);
    }

    // 내용 상세보기
    public FaqDto select(int bno) {
        return session.selectOne(namespace + "select", bno);
    }

    public int count(FaqDto dto) {
        return session.selectOne(namespace + "count", dto);
    }

    @Override
    public int imageInsert(ImageDto dto) {
        return session.insert(namespace + "imageInsert", dto);
    }

    @Override
    public List<ImageDto> getImageList(int faq_id) {
        return session.selectList(namespace + "getImageList", faq_id);
    }


}