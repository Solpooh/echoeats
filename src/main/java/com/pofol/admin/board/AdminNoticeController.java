package com.pofol.admin.board;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.PageHandler;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminNoticeController {
    private final NoticeService noticeService;

    public AdminNoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

    // 공지사항 조회 관리자페이지
    @GetMapping("/notice")
    public String notice(SearchBoardCondition sc, Model m) throws Exception {
        try {
            int totalCnt = noticeService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler ph = new PageHandler(totalCnt, sc);

            List<NoticeDto> list = noticeService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", ph);

            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/board/notice/notice_admin";
    }

    // 공지사항 상세조회 관리자페이지
    @GetMapping("/notice_view")
    public String notice_view(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        // 이전 페이지의 검색 조건을 유지하기 위해 현재 페이지 정보를 이전 페이지의 페이지 정보로 설정

        NoticeDto notice = noticeService.getNotice(dto);
        List<ImageDto> imageList = noticeService.getImageList(dto.getNotice_id(), "notice");
        notice.setImageList(imageList);

        m.addAttribute("notice", notice);
        m.addAttribute("page", sc.getPage());
        m.addAttribute("pageSize", sc.getPageSize());

        return "admin/board/notice/notice_adminView";
    }

    // 공지사항 등록 관리자페이지
    @GetMapping("/notice_write")
    public String notice_write() {
        return "admin/board/notice/notice_adminWrite";
    }

    // 공지사항 수정 관리자페이지
    @GetMapping("/notice_modify")
    public String notice_modify(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        NoticeDto notice = noticeService.getNotice(dto);
        List<ImageDto> imageList = noticeService.getImageList(dto.getNotice_id(), "notice");
        notice.setImageList(imageList);
        m.addAttribute("notice", notice);
        m.addAttribute("page", sc.getPage());
        m.addAttribute("pageSize", sc.getPageSize());

        return "admin/board/notice/notice_adminModify";
    }

    // 공지사항 실제수정 처리
    @PostMapping("/updateNotice")
    public String updateNotice(SearchBoardCondition sc, NoticeDto dto) throws Exception {
        noticeService.updateNotice(dto);

        return "redirect:/admin/notice?page=" + sc.getPage() + "&pageSize=" + sc.getPageSize();
    }

    // 공지사항 삭제 처리
    @PostMapping("/deleteNotice")
    public String deleteNotice(SearchBoardCondition sc, NoticeDto dto, Model m) throws Exception {
        try {
            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());

            int rowCnt = noticeService.deleteNotice(dto);

            if(rowCnt != 1) {
                throw new Exception("공지사항 삭제 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
//        noticeRepository.deleteNotice(dto);
        return "redirect:/admin/notice";
    }

    // 공지사항 실제등록 처리
    @PostMapping("/insertNotice")
    public String insertNotice(NoticeDto dto) throws Exception {
        System.out.println("dto : " + dto);
        /* 만약 내용을 작성중에 있는데, 예외가 발생해서 작성한 내용이 모두 날라갈 수 있을 것을 대비해
        작성했던 내용을 되살릴 수 있도록 구현
        + 자동 임시저장 기능??
        + 수정기능에서도 마찬가지임 !! */
        try {
            int rowCnt = noticeService.insertNotice(dto);
            if (rowCnt != 1)
                throw new Exception("게시글 등록 실패");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/admin/notice";
    }
}
