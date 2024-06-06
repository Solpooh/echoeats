package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class NoticeServiceImpl implements NoticeService {
    // 생성자 주입 방식으로 바꿔보기
    private final NoticeRepository noticeRepository;
    public NoticeServiceImpl(NoticeRepository noticeRepository) {
        this.noticeRepository = noticeRepository;
    }
    @Override
    @Transactional
    public int insertNotice(NoticeDto dto) {
        try {
            int result = noticeRepository.insertNotice(dto);
            List<ImageDto> imageList = dto.getImageList();
            if (imageList != null && !imageList.isEmpty()) {
                for (ImageDto imageDto : imageList) {
                    imageDto.setItem_id(dto.getNotice_id()); // 외래 키 설정
                    imageDto.setMode("notice"); // 모드 설정
                    noticeRepository.imageInsert(imageDto);
                }
            }
            return result;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    @Transactional
    public int updateNotice(NoticeDto dto) {
        try {
            int result = noticeRepository.updateNotice(dto);
            List<ImageDto> imageList = dto.getImageList();
            if (result == 1 && imageList != null && !imageList.isEmpty()) {
                // 일단 이미지 모두 삭제
                noticeRepository.deleteImageAll(dto.getNotice_id());
                for (ImageDto imageDto : imageList) {
                    imageDto.setItem_id(dto.getNotice_id()); // 외래 키 설정
                    imageDto.setMode("notice");
                    noticeRepository.imageInsert(imageDto);
                }
            }
            return result;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<ImageDto> getImageList(int item_id, String mode) {
        try {
            return noticeRepository.getImageList(item_id, mode);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    @Transactional
    public int deleteNotice(NoticeDto dto) {
        try {
            noticeRepository.deleteImageAll(dto.getNotice_id());
            return noticeRepository.deleteNotice(dto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public NoticeDto getNotice(NoticeDto dto) {
        try {
            return noticeRepository.getNotice(dto);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<NoticeDto> getNoticeList(NoticeDto dto) {
        try {
            return noticeRepository.getNoticeList(dto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int countNotice(NoticeDto dto) {
        try {
            return noticeRepository.count(dto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public List<NoticeDto> getPage(Map map) {
        try {
            return noticeRepository.selectPage(map);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public int getSearchResultCnt(SearchBoardCondition sc) {
        try {
            return noticeRepository.searchResultCnt(sc);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<NoticeDto> getSearchResultPage(SearchBoardCondition sc) {
        try {
            return noticeRepository.searchSelectPage(sc);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
