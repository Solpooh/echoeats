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
    public int updateFaq(FaqDto dto) {
        int result = faqRepository.update(dto);
        List<ImageDto> imageList = dto.getImageList();
        if (result == 1 && imageList != null && !imageList.isEmpty()) {
            // 일단 이미지 모두 삭제
            faqRepository.deleteImageAll(dto.getFaq_id());
            for (ImageDto imageDto : imageList) {
                imageDto.setFaq_id(dto.getFaq_id()); // 외래 키 설정
                faqRepository.imageInsert(imageDto);
            }
        }
        return result;
    }

    /* FAQ 등록 */
    @Override
    @Transactional
    public int insertFaq(FaqDto dto) {
        int result = faqRepository.insert(dto);
        List<ImageDto> imageList = dto.getImageList();
        if (imageList != null && !imageList.isEmpty()) {
            for (ImageDto imageDto : imageList) {
                imageDto.setFaq_id(dto.getFaq_id()); // 외래 키 설정
                faqRepository.imageInsert(imageDto);
            }
        }
        return result;
    }

    @Override
    public int deleteFaq(FaqDto dto) {
        return faqRepository.delete(dto);
    }

    @Override
    public FaqDto selectFaq(int bno) {
        return faqRepository.select(bno);
    }

    @Override
    public List<FaqDto> selectAllFaq(FaqDto dto) {
        return faqRepository.selectAll(dto);
    }

    @Override
    public List<FaqDto> selectPaged(FaqDto dto) {
        List<FaqDto> faqList = faqRepository.selectPaged(dto);
        for (FaqDto faq : faqList) {
            // faq_id로 이미지 조회
            List<ImageDto> imageList = faqRepository.getImageList(faq.getFaq_id());
            faq.setImageList(imageList);
        }
        return faqList;
    }

    public int countFaq(FaqDto dto) {
        return faqRepository.count(dto);
    }

    @Override
    public List<ImageDto> getImageList(int faq_id) {
        return faqRepository.getImageList(faq_id);
    }

}
