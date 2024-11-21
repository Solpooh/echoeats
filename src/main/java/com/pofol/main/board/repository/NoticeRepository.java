package com.pofol.main.board.repository;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;

import java.util.List;
import java.util.Map;

public interface NoticeRepository {
    int insertNotice(NoticeDto dto) throws Exception;
    int updateNotice(NoticeDto dto) throws Exception;
    int deleteNotice(NoticeDto dto) throws Exception;
    List<NoticeDto> getNoticeList(NoticeDto dto) throws Exception;
    NoticeDto getNotice(NoticeDto dto) throws Exception;
    int count(NoticeDto dto) throws Exception;
    List<NoticeDto> selectPage(Map map) throws Exception;
    int searchResultCnt(SearchBoardCondition sc) throws Exception;
    List<NoticeDto> searchSelectPage(SearchBoardCondition sc) throws Exception;
}
