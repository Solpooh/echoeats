package com.pofol.main.board.service;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FaqRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class FaqServiceImpl implements FaqService {
    private final FaqRepositoryImpl faqRepository;

    public FaqServiceImpl(FaqRepositoryImpl faqRepository) {
        this.faqRepository = faqRepository;
    }

    /* FAQ 등록 */
    @Override
    @Transactional
    public int insertFaq(FaqDto dto) {
        // 이미지를 등록할 때도 있고 안할 때도 있음
        int result = faqRepository.insert(dto);
        if(!dto.getImageList().isEmpty()) {
            for (ImageDto image : dto.getImageList()) {
                image.setFaq_id(dto.getFaq_id());
                int imgResult = faqRepository.imageInsert(image);
            }
        }
        return result;
    }

    @Override
    public int updateFaq(FaqDto dto) {
        return faqRepository.update(dto);
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
        return faqRepository.selectPaged(dto);
    }

    public int countFaq(FaqDto dto) {
        return faqRepository.count(dto);
    }

    @Override
    public List<ImageDto> getImageList(int faq_id) {
        return faqRepository.getImageList(faq_id);
    }

}
