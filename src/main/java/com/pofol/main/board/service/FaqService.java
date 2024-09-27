package com.pofol.main.board.service;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface FaqService {
    int updateFaq(FaqDto dto);

    /* FAQ 등록 */
    int insertFaq(FaqDto dto);

    int deleteFaq(FaqDto dto);
    FaqDto selectFaq(int bno);
    List<FaqDto> selectAllFaq(FaqDto dto);
    List<FaqDto> selectPaged(Map map);
    int countFaq(FaqDto dto);
    List<ImageDto> getImageList(int item_id, String mode);

}
