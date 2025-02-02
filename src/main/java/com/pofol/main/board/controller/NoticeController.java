package com.pofol.main.board.controller;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.NoticeDto;
import com.pofol.main.board.domain.PageHandler;
import com.pofol.main.board.domain.SearchBoardCondition;
import com.pofol.main.board.exception.CustomException;
import com.pofol.main.board.service.FileService;
import com.pofol.main.board.service.NoticeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RequestMapping
@RequiredArgsConstructor
@Controller
public class NoticeController {
    private final NoticeService noticeService;
    private final FileService fileService;

    private String getViewName(String uri, String viewName) {
        return uri.startsWith("/admin")? "admin/board/notice/" + viewName : "board/notice/" + viewName;
    }

    // 상세조회 메서드
    private void selectNotice(NoticeDto dto, Model m) throws Exception {
        NoticeDto notice = noticeService.getNotice(dto);

        if (notice == null) {
            throw new CustomException.NoExistBoardException("존재하지 않는 게시물입니다.");
        }

        List<ImageDto> imageList = fileService.getImageList(dto.getNotice_id(), "notice");
        notice.setImageList(imageList);
        m.addAttribute("notice", notice);
    }

    // 공지사항 목록 조회
    @GetMapping({"/board/notice", "/admin/notice"})
    public String notice(HttpServletRequest request,
                         @ModelAttribute("sc") SearchBoardCondition sc,
                         Model m) throws Exception {
        int totalCnt = noticeService.getSearchResultCnt(sc);
        m.addAttribute("totalCnt", totalCnt);

        PageHandler pageHandler = new PageHandler(totalCnt, sc);
        List<NoticeDto> list = noticeService.getSearchResultPage(sc);

        if (list.isEmpty()) {
            throw new CustomException.NoExistBoardException("공지사항 목록이 존재하지 않습니다.");
        }

        m.addAttribute("list", list);
        m.addAttribute("ph", pageHandler);

        return getViewName(request.getRequestURI(),"notice");
    }

    // 공지사항 상세조회
    @GetMapping({"/board/notice_view", "/admin/notice_view"})
    public String notice_view(HttpServletRequest request,
                              @ModelAttribute("sc") SearchBoardCondition sc,
                              NoticeDto dto,
                              Model m) throws Exception {
        // 이전 페이지의 검색 조건을 유지하기 위해 현재 페이지 정보를 이전 페이지의 페이지 정보로 설정

        selectNotice(dto, m);

        return getViewName(request.getRequestURI(), "notice_view");
    }

    // 공지사항 등록/수정 페이지 (관리자)
    @GetMapping("/admin/notice_write")
    public String notice_write(@RequestParam(defaultValue = "new") String mode,
                               @ModelAttribute("sc") SearchBoardCondition sc,
                               NoticeDto dto,
                               Model m) throws Exception{
        if ("edit".equals(mode)) {
            selectNotice(dto, m);
        }
        m.addAttribute("mode", mode);

        return "/admin/board/notice/notice_write";
    }

    // 공지사항 등록/수정 처리 (관리자)
    @PostMapping("/admin/insertNotice")
    public String insertNotice(@RequestParam(defaultValue = "new") String mode,
                               @ModelAttribute("sc") SearchBoardCondition sc,
                               NoticeDto dto,
                               @RequestParam(required = false, value = "uploadFile") List<MultipartFile> files,
                               RedirectAttributes redirectAttributes) throws Exception {
        // 유효한 파일이 있는 경우에만 파일 업로드 처리
        if (files != null && !files.isEmpty()) {
            dto.setImageList(fileService.fileUpload(files));
        }

        if ("edit".equals(mode)) {
            noticeService.updateNotice(dto);
            redirectAttributes.addFlashAttribute("message", "MOD_OK");

            return "redirect:/admin/notice" + sc.getQueryString();
        }
        noticeService.insertNotice(dto);
        redirectAttributes.addFlashAttribute("message", "WRT_OK");

        return "redirect:/admin/notice";
    }


    // 공지사항 삭제 처리 (관리자)
    @PostMapping("/admin/deleteNotice")
    public String deleteNotice(@ModelAttribute("sc") SearchBoardCondition sc,
                               NoticeDto dto,
                               RedirectAttributes redirectAttributes) throws Exception {
        List<ImageDto> list = noticeService.deleteNotice(dto);

        fileService.deleteFile(list);

        redirectAttributes.addFlashAttribute("message", "DEL_OK");

        return "redirect:/admin/notice" + sc.getQueryString();
    }
}
