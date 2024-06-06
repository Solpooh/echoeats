package com.pofol.main.board.controller;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.PageHandler;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/board")
public class NoticeController {
    private final NoticeService noticeService;

    public NoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

//    @ExceptionHandler(RuntimeException.class)
//    public String handleRuntimeException(RuntimeException e, Model m) {
//        m.addAttribute("errorMessage", e.getMessage());
//        return "errorPage"; // error 페이지로 리디렉션
//    }
    // 공지사항 조회 페이지
    @GetMapping(value = "/notice")
    public String notice(SearchBoardCondition sc, Model m) throws Exception {
        try {
            int totalCnt = noticeService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<NoticeDto> list = noticeService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "board/notice/notice";
    }

    // 공지사항 상세조회 페이지
    @GetMapping("/notice_view")
    public String notice_view(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        // 이전 페이지의 검색 조건을 유지하기 위해 현재 페이지 정보를 이전 페이지의 페이지 정보로 설정

        NoticeDto notice = noticeService.getNotice(dto);
        List<ImageDto> imageList = noticeService.getImageList(dto.getNotice_id(), "notice");
        notice.setImageList(imageList);
        m.addAttribute("notice", notice);
        m.addAttribute("page", sc.getPage());
        m.addAttribute("pageSize", sc.getPageSize());

        return "board/notice/notice_view";
    }
}
