package com.pofol.main.board.repository;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.orders.order.domain.SearchOrderCondition;

import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class FaqRepositoryImpl implements FaqRepository {
    private final SqlSession session;

    private static final String namespace = "com.pofol.main.repository.FaqRepository.";

    @Override
    public int insert(FaqDto dto) {
        return session.insert(namespace + "insert", dto);
    }
    @Override
    public int update(FaqDto dto) {
        return session.update(namespace + "update", dto);
    }
    @Override
    public int delete(FaqDto dto) {
        return session.delete(namespace + "delete", dto);
    }
    // 전체 리스트 보여주기
    @Override
    public List<FaqDto> selectAll(FaqDto dto) {
        return session.selectList(namespace + "selectAll", dto);
    }
    // 페이징된 리스트 보여주기
    @Override
    public List<FaqDto> selectPaged(Map map) {
        return session.selectList(namespace + "selectPaged", map);
    }
    // 내용 상세보기
    @Override
    public FaqDto select(int bno) {
        return session.selectOne(namespace + "select", bno);
    }
    @Override
    public int count(FaqDto dto) {
        return session.selectOne(namespace + "count", dto);
    }
    @Override
    public int imageInsert(ImageDto dto) {
        return session.insert(namespace + "imageInsert", dto);
    }
    @Override
    public List<ImageDto> getImageList(int item_id, String mode) {
        Map<String, Object> map = new HashMap<>();
        map.put("item_id", item_id);
        map.put("mode", mode);
        return session.selectList(namespace + "getImageList", map);
    }
    @Override
    public void deleteImageAll(int faq_id) {
        session.delete(namespace + "deleteImageAll", faq_id);
    }
    @Override
    public List<ImageDto> checkFileList() {
        return session.selectList(namespace + "checkFileList");
    }
}