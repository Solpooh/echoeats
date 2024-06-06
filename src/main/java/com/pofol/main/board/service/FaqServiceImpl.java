package com.pofol.main.board.service;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FaqRepositoryImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.awt.*;
import java.util.List;

@Service
public class FaqServiceImpl implements FaqService {
    private final FaqRepositoryImpl faqRepository;

    public FaqServiceImpl(FaqRepositoryImpl faqRepository) {
        this.faqRepository = faqRepository;
    }

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
            throw new RuntimeException(e);
        }
    }

    @Override
    @Transactional
    public int updateFaq(FaqDto dto) {
        try {
            int result = faqRepository.update(dto);
            List<ImageDto> imageList = dto.getImageList();
            if (result == 1 && imageList != null && !imageList.isEmpty()) {
                // 일단 이미지 모두 삭제
                faqRepository.deleteImageAll(dto.getFaq_id());
                for (ImageDto imageDto : imageList) {
                    imageDto.setItem_id(dto.getFaq_id()); // 외래 키 설정
                    imageDto.setMode("faq");
                    faqRepository.imageInsert(imageDto);
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
            return faqRepository.getImageList(item_id, mode);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    @Transactional
    public int deleteFaq(FaqDto dto) {
        try {
            faqRepository.deleteImageAll(dto.getFaq_id());
            return faqRepository.delete(dto);
        } catch (Exception e) {
            throw new RuntimeException(e);
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
    public List<FaqDto> selectPaged(FaqDto dto) {
        try {
            List<FaqDto> faqList = faqRepository.selectPaged(dto);
            for (FaqDto faq : faqList) {
                // faq_id로 이미지 조회
                List<ImageDto> imageList = faqRepository.getImageList(faq.getFaq_id(), "faq");
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
