package com.pofol.main.board.repository;

import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class NoticeRepositoryImpl implements NoticeRepository {
    @Autowired
    private SqlSession session;
    private static String namespace = "com.pofol.repository.NoticeRepository.";

    //공지사항 전체리스트 보기
    public List<NoticeDto> getNoticeList(NoticeDto dto) {
        System.out.println("===> MyBatis 사용  getNoticeList(dto) 실행");
        return session.selectList(namespace + "getNoticeList", dto);
    }
    //공지사항 상세보기
    public NoticeDto getNotice(NoticeDto dto) {
        System.out.println("getNotice() 실행");
        return session.selectOne(namespace + "getNotice", dto);
    }

    //공지사항 입력
    public int insertNotice(NoticeDto dto) {
        System.out.println("insertNotice() 실행");
        return session.insert(namespace + "insertNotice", dto);
    }

    //공지사항 수정
    public int updateNotice(NoticeDto dto) {
        System.out.println("updateNotice() 실행");
        return session.update(namespace + "updateNotice", dto);
    }

    //공지사항 삭제
    public int deleteNotice(NoticeDto dto) {
        System.out.println(" deleteNotice() 실행");
        return session.delete(namespace + "deleteNotice", dto);
    }

    @Override
    public int count(NoticeDto dto) throws Exception {
        return session.selectOne(namespace + "count", dto);
    }
    @Override
    public List<NoticeDto> selectPage(Map map) throws Exception {
        return session.selectList(namespace + "selectPage", map);
    }

    @Override
    public int searchResultCnt(SearchBoardCondition sc) throws Exception {
        return session.selectOne(namespace + "searchResultCnt", sc);
    }

    @Override
    public List<NoticeDto> searchSelectPage(SearchBoardCondition sc) throws Exception {
        return session.selectList(namespace + "searchSelectPage", sc);
    }
}
