package com.pofol.main.board.service;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FaqRepository;
import com.pofol.main.board.repository.FaqRepositoryImpl;
import com.pofol.main.board.service.FaqServiceImpl;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.ArrayList;
import java.util.List;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class FaqServiceImplTest {
    @Autowired
    private FaqService service;
    @Autowired
    private FaqRepository repository;

    @Test
    public void insertFaqTest() {
        FaqDto dto = new FaqDto();
        dto.setFaq_type("회원");
        dto.setFaq_con("블라블라블라");
        dto.setFaq_title("제목 테스트");

        List<ImageDto> imageList = new ArrayList<>();
        ImageDto dto1 = new ImageDto();
        ImageDto dto2 = new ImageDto();

        dto1.setFileName("test image");
        dto1.setUploadPath("test image 1");
        dto1.setUuid("test1111");

        dto2.setFileName("test image2");
        dto2.setUploadPath("test image 2");
        dto2.setUuid("test2222");

        imageList.add(dto1);
        imageList.add(dto2);

        dto.setImageList(imageList);
        int result = service.insertFaq(dto);
        System.out.println("dto = " + dto);
    }
    @Test
    public void getImageListTest() throws Exception {
        int faq_id = 66;
        System.out.println("repository = " + repository.getImageList(faq_id));
    }
}
