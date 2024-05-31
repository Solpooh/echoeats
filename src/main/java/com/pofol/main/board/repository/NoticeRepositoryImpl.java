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
    private final SqlSession session;

    public NoticeRepositoryImpl(SqlSession session) {
        this.session = session;
    }

    private static final String namespace = "com.pofol.repository.NoticeRepository.";

    //공지사항 전체리스트 보기
    public List<NoticeDto> getNoticeList(NoticeDto dto) {
        return session.selectList(namespace + "getNoticeList", dto);
    }

    //공지사항 상세보기
    public NoticeDto getNotice(NoticeDto dto) {
        return session.selectOne(namespace + "getNotice", dto);
    }

    //공지사항 입력
    public int insertNotice(NoticeDto dto) {
        return session.insert(namespace + "insertNotice", dto);
    }

    //공지사항 수정
    public int updateNotice(NoticeDto dto) {
        return session.update(namespace + "updateNotice", dto);
    }

    //공지사항 삭제
    public int deleteNotice(NoticeDto dto) {
        return session.delete(namespace + "deleteNotice", dto);
    }

    @Override
    public int count(NoticeDto dto) throws Exception {
        return session.selectOne(namespace + "count", dto);
    }
    @Override
    public List<NoticeDto> selectPage(Map map){
        return session.selectList(namespace + "selectPage", map);
    }

    @Override
    public int searchResultCnt(SearchBoardCondition sc) {
        return session.selectOne(namespace + "searchResultCnt", sc);
    }

    @Override
    public List<NoticeDto> searchSelectPage(SearchBoardCondition sc) {
        return session.selectList(namespace + "searchSelectPage", sc);
    }
}
