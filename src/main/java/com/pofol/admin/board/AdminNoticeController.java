package com.pofol.admin.board;

import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.PageHandler;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.repository.NoticeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Controller
@RequestMapping("/admin1")
public class AdminNoticeController {
    @Autowired
    private NoticeRepository noticeRepository;

    // 공지사항 조회 관리자페이지
    @RequestMapping("/notice")
    public String notice(SearchBoardCondition sc, Model m) throws Exception {
        try {
            int totalCnt = noticeRepository.searchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler ph = new PageHandler(totalCnt, sc);

            List<NoticeDto> list = noticeRepository.searchSelectPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", ph);

            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());


            Instant startOfToday = LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant();
            m.addAttribute("startOfToday", startOfToday.toEpochMilli());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/admin/board/notice_admin";
    }

    // 공지사항 상세조회 관리자페이지
    @RequestMapping("/notice_view")
    public String notice_view(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        // 이전 페이지의 검색 조건을 유지하기 위해 현재 페이지 정보를 이전 페이지의 페이지 정보로 설정

        NoticeDto notice = noticeRepository.getNotice(dto);
        m.addAttribute("notice", notice);
        m.addAttribute("page", sc.getPage());
        m.addAttribute("pageSize", sc.getPageSize());

//        System.out.println("notice : " + notice);
        return "/admin/board/notice_adminView";
    }

    // 공지사항 등록 관리자페이지
    @RequestMapping("/notice_write")
    public String notice_write() {
        return "/admin/board/notice_adminWrite";
    }

    // 공지사항 수정 관리자페이지
    @RequestMapping("/notice_modify")
    public String notice_modify(NoticeDto dto, Model model) throws Exception {
        NoticeDto notice = noticeRepository.getNotice(dto);
        model.addAttribute("notice", notice);
        System.out.println("notice : " + notice);
        return "/admin/board/notice_adminModify";
    }

    // 공지사항 실제수정 처리
    @RequestMapping(value = "/updateNotice", method = RequestMethod.POST)
    public String updateNotice(NoticeDto dto, int notice_id) throws Exception {
        System.out.println(notice_id);
        noticeRepository.updateNotice(dto);
        System.out.println("dto : " + dto);

        return "redirect:/admin1/notice";
    }

    // 공지사항 삭제 처리
    @RequestMapping("/deleteNotice")
    public String deleteNotice(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        System.out.println("dto : " + dto);
        try {
            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());

            int rowCnt = noticeRepository.deleteNotice(dto);

            if(rowCnt != 1) {
                throw new Exception("공지사항 삭제 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
//        noticeRepository.deleteNotice(dto);
        return "redirect:/admin1/notice";
    }

    // 공지사항 실제등록 처리
    @RequestMapping(value = "/insertNotice", method = RequestMethod.POST)
    public String insertNotice(NoticeDto dto) throws Exception {
        System.out.println("dto : " + dto);
        /* 만약 내용을 작성중에 있는데, 예외가 발생해서 작성한 내용이 모두 날라갈 수 있을 것을 대비해
        작성했던 내용을 되살릴 수 있도록 구현
        + 자동 임시저장 기능??
        + 수정기능에서도 마찬가지임 !!
         */
        noticeRepository.insertNotice(dto);

        return "redirect:/admin1/notice";
    }
}
