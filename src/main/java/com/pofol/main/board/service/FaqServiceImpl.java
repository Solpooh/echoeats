package com.pofol.main.board.service;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.repository.FaqRepositoryImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaqServiceImpl implements FaqService {
    private final FaqRepositoryImpl faqRepository;

    public FaqServiceImpl(FaqRepositoryImpl faqRepository) {
        this.faqRepository = faqRepository;
    }

    @Override
    public int insertFaq(FaqDto dto) {
        return faqRepository.insert(dto);
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
    public int countFaq(FaqDto dto) {
        return faqRepository.count(dto);
    }
}
