package com.pofol.main.board.controller;

import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.PageHandler;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Controller
@RequestMapping("/board")
public class NoticeController {
    @Autowired
    private NoticeService noticeService;

    // 공지사항 조회 페이지
    @RequestMapping(value = "/notice")
    public String notice(SearchBoardCondition sc, Model m) throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String id = authentication.getName();

        System.out.println(id);
        try {
            int totalCnt = noticeService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<NoticeDto> list = noticeService.getSearchResultPage(sc);
            m.addAttribute("list", list);
//            System.out.println("list: " + list);
            m.addAttribute("ph", pageHandler);

            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());

            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/board/notice";
    }

    // 공지사항 상세조회 페이지
    @RequestMapping("/notice_view")
    public String notice_view(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        // 이전 페이지의 검색 조건을 유지하기 위해 현재 페이지 정보를 이전 페이지의 페이지 정보로 설정

        NoticeDto notice = noticeService.getNotice(dto);
        m.addAttribute("notice", notice);
        m.addAttribute("page", sc.getPage());
        m.addAttribute("pageSize", sc.getPageSize());

//        System.out.println("notice : " + notice);
        return "/board/notice_view";
    }

    // 공지사항 등록 페이지
    @RequestMapping("/notice_write")
    // 단순 view만 리턴 => view-controller로 지정해주기
    public String notice_write() {
        return "/board/notice_write";
    }

    // 공지사항 실제입력 처리
    @RequestMapping(value = "/insertNotice", method = RequestMethod.POST)
    public String insertNotice(NoticeDto dto) throws Exception {
        System.out.println("dto : " + dto);

        noticeService.insertNotice(dto);

        return "redirect:/board/notice";
    }

    // 공지사항 수정페이지
    @RequestMapping("/notice_modify")
    public String notice_modify(NoticeDto dto, Model model) throws Exception {
        NoticeDto notice = noticeService.getNotice(dto);
        model.addAttribute("notice", notice);
        System.out.println("notice : " + notice);
        return "/board/notice_modify";
    }

    // 공지사항 실제수정 처리
    @RequestMapping(value = "/updateNotice", method = RequestMethod.POST)
    public String updateNotice(NoticeDto dto, int notice_id) throws Exception {
        System.out.println(notice_id);
        noticeService.updateNotice(dto);
        System.out.println("dto : " + dto);

        return "redirect:/board/notice";
    }

    // 공지사항 삭제 처리
    @RequestMapping("/deleteNotice")
    public String deleteNotice(NoticeDto dto) throws Exception {
        // 공지사항 삭제 시 기존에 보고있던 page로 redirect 되는지 여부 확인하기
        System.out.println("dto : " + dto);

        noticeService.deleteNotice(dto);

        return "redirect:/board/notice";
    }
}
