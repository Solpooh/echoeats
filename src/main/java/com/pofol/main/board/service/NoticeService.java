package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;

import java.util.List;
import java.util.Map;

public interface NoticeService {
    int insertNotice(NoticeDto dto) throws Exception;
    int updateNotice(NoticeDto dto) throws Exception;
    int deleteNotice(NoticeDto dto) throws Exception;
    NoticeDto getNotice(NoticeDto dto) throws Exception;
    List<NoticeDto> getNoticeList(NoticeDto dto) throws Exception;
    int countNotice(NoticeDto dto) throws Exception;
    List<NoticeDto> getPage(Map map) throws Exception;
    int getSearchResultCnt(SearchBoardCondition sc) throws Exception;
    List<NoticeDto> getSearchResultPage(SearchBoardCondition sc) throws Exception;
    List<ImageDto> getImageList(int item_id, String mode) throws Exception;

}
