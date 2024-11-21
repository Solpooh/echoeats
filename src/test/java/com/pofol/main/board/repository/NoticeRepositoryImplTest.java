package com.pofol.main.board.repository;

import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.SearchBoardCondition;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class) // Junit5
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})

public class NoticeRepositoryImplTest {
    @Autowired
    NoticeRepository noticeRepository;
    @Autowired
    FileRepository fileRepository;

    @Test
    public void searchResultCnt() throws Exception {
    }

    @Test
    public void searchSelectPage() throws Exception {
        SearchBoardCondition sc = new SearchBoardCondition(1, 10, "T", "은행");
        List<NoticeDto> list = noticeRepository.searchSelectPage(sc);
        System.out.println("noticeList = " + list);
        assertTrue(list.size() == 5);
    }

    @Test
    public void checkImageListTest() throws Exception {
        fileRepository.checkFileList();
    }
}