package com.pofol.main.board.controller;

import com.pofol.main.board.domain.*;
import com.pofol.main.board.service.FaqService;
import com.pofol.main.board.service.FileService;
import com.pofol.util.S3Service;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class FaqController {
    private final FaqService faqService;
    private final FileService fileService;

    // FAQ 목록 조회
    @ResponseBody
    @PostMapping("/list")
    public ResponseEntity<Map<String, Object>> getFaqList(@RequestBody FaqRequest request) {
        FaqDto dto = request.getFaqDto();
        SearchBoardCondition sc = request.getSearchBoardCondition();

        // 전체 개수 조회
        int totalCnt = faqService.countFaq(dto);

        // 페이지 계산
        PageHandler pageHandler = new PageHandler(totalCnt, sc);

        // 페이징된 FAQ 목록 가져오기
        Map<String, Object> map = new HashMap<>();
        map.put("offset", sc.getOffset());
        map.put("pageSize", sc.getPageSize());
        map.put("faq_type", dto.getFaq_type());

        List<FaqDto> list = faqService.selectPaged(map);

        // 결과 맵 구성
        Map<String, Object> result = new HashMap<>();
        result.put("faqList", list);
        result.put("pageHandler", pageHandler);

        return ResponseEntity.ok(result);
    }


    // FAQ 등록/수정 GET
    @GetMapping("/faq_write")
    public String faq_write(@RequestParam(defaultValue = "new") String mode,
                            FaqDto dto,
                            Model m) {
        // 수정 모드
        if ("edit".equals(mode)) {
            // 상세조회
            FaqDto faq = faqService.selectFaq(dto.getFaq_id());
            List<ImageDto> imageList = fileService.getImageList(dto.getFaq_id(), "faq");

            faq.setImageList(imageList);
            m.addAttribute("faq", faq);
        }

        m.addAttribute("mode", mode);

        return "board/faq/faq_write";
    }

    // FAQ 등록/수정 POST
    @PostMapping("/saveFaq")
    public String saveFaq(@RequestParam String mode,
                          FaqDto dto,
                          @RequestParam(required = false, value = "uploadFile") List<MultipartFile> files,
                          RedirectAttributes redirectAttributes) {
        // 유효한 파일이 있는 경우에만 파일 업로드 처리
        if (files != null && !files.isEmpty()) {
            dto.setImageList(fileService.fileUpload(files));
        }

        if ("edit".equals(mode)) {
            faqService.updateFaq(dto);
            redirectAttributes.addFlashAttribute("message", "MOD_OK");
        } else {
            faqService.insertFaq(dto);
            redirectAttributes.addFlashAttribute("message", "WRT_OK");
        }

        return "redirect:/board/faq";
    }

    // FAQ 삭제
    @ResponseBody
    @PostMapping("/deleteFaq")
    public ResponseEntity<?> deleteFaq(@RequestBody FaqDto dto) {
        List<ImageDto> list = faqService.deleteFaq(dto);

        // S3 객체에 있는 파일 삭제
        fileService.deleteFile(list);

        if (list != null) {
            return ResponseEntity.ok().body(dto.getFaq_id());
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }
}
