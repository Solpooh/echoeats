package com.pofol.main.board.service;

import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {
    // 생성자 주입 방식으로 바꿔보기
    @Autowired
    NoticeRepository noticeRepository;
    public NoticeServiceImpl() {
    }
    @Override
    public int insertNotice(NoticeDto dto) throws Exception {
        return noticeRepository.insertNotice(dto);
    }

    @Override
    public int updateNotice(NoticeDto dto) throws Exception {
        return noticeRepository.updateNotice(dto);
    }

    @Override
    public int deleteNotice(NoticeDto dto) throws Exception {
        return noticeRepository.deleteNotice(dto);
    }

    @Override
    public NoticeDto getNotice(NoticeDto dto) throws Exception {
        return noticeRepository.getNotice(dto);
    }

    @Override
    public List<NoticeDto> getNoticeList(NoticeDto dto) throws Exception {
        return noticeRepository.getNoticeList(dto);
    }

    @Override
    public int countNotice(NoticeDto dto) throws Exception {
        return noticeRepository.count(dto);
    }

    @Override
    public List<NoticeDto> getPage(Map map) throws Exception {
        return noticeRepository.selectPage(map);
    }
    @Override
    public int getSearchResultCnt(SearchBoardCondition sc) throws Exception {
        return noticeRepository.searchResultCnt(sc);
    }

    @Override
    public List<NoticeDto> getSearchResultPage(SearchBoardCondition sc) throws Exception {
        return noticeRepository.searchSelectPage(sc);
    }

}
