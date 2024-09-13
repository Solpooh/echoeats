package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.repository.NoticeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {
    private final NoticeRepository noticeRepository;
    private final FileService fileService;
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
                // 이미지 모두 삭제
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
            // 이미지 정보 삭제
            noticeRepository.deleteImageAll(dto.getNotice_id());

            // 로컬 파일 시스템에서 삭제할 이미지 목록 가져오기
            List<ImageDto> fileList = getImageList(dto.getNotice_id(), "notice");
            fileService.deleteFiles(fileList);

            // FAQ 삭제
            return noticeRepository.deleteNotice(dto);

        } catch (Exception e) {
            throw new RuntimeException("NOTICE 삭제 실패", e);
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
