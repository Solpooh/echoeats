package com.pofol.main.board.service;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FaqRepository;
import com.pofol.main.board.repository.FaqRepositoryImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.awt.*;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class FaqServiceImpl implements FaqService {
    private final FaqRepository faqRepository;

    @Override
    @Transactional
    public int insertFaq(FaqDto dto) {
        try {
            int result = faqRepository.insert(dto);
            List<ImageDto> imageList = dto.getImageList();
            if (imageList != null && !imageList.isEmpty()) {
                for (ImageDto imageDto : imageList) {
                    imageDto.setItem_id(dto.getFaq_id()); // 외래 키 설정
                    imageDto.setMode("faq"); // 모드 설정
                    faqRepository.imageInsert(imageDto);
                }
            }
            return result;
        } catch (Exception e) {
            throw new RuntimeException("FAQ 등록 실패", e);
        }
    }

    @Override
    @Transactional
    public int updateFaq(FaqDto dto) {
        try {
            int result = faqRepository.update(dto);
            List<ImageDto> imageList = dto.getImageList();
            if (result == 1 && imageList != null && !imageList.isEmpty()) {
                // 이미지 모두 삭제
                faqRepository.deleteImageAll(dto.getFaq_id());

                // 새로운 이미지로 업데이트
                for (ImageDto imageDto : imageList) {
                    imageDto.setItem_id(dto.getFaq_id()); // 외래 키 설정
                    imageDto.setMode("faq");
                    faqRepository.imageInsert(imageDto);
                }
            }
            return result;
        } catch (Exception e) {
            throw new RuntimeException("FAQ 수정 실패", e);
        }
    }


    @Override
    @Transactional
    public int deleteFaq(FaqDto dto) {
        try {
            // 이미지 정보 삭제
            faqRepository.deleteImageAll(dto.getFaq_id());

//            List<ImageDto> fileList = getImageList(dto.getFaq_id(), "faq");
//            fileService.deleteFiles(fileList);

            // FAQ 삭제
            return faqRepository.delete(dto);

        } catch (Exception e) {
            throw new RuntimeException("FAQ 삭제 실패", e);
        }
    }

    @Override
    public FaqDto selectFaq(int bno) {
        try {
            return faqRepository.select(bno);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<FaqDto> selectAllFaq(FaqDto dto) {
        try {
            return faqRepository.selectAll(dto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public List<FaqDto> selectPaged(Map map) {
        try {
            List<FaqDto> faqList = faqRepository.selectPaged(map);
            log.info("faqLIST" + faqList);
            for (FaqDto faq : faqList) {
                log.info("faqsize" + faqList.size());
                // faq_id로 이미지 조회
                List<ImageDto> imageList = faqRepository.getImageList(faq.getFaq_id(), "faq");
                log.info("Image list for FAQ ID " + faq.getFaq_id() + ": " + imageList);

                faq.setImageList(imageList);
            }
            return faqList;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public int countFaq(FaqDto dto) {
        try {
            return faqRepository.count(dto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
