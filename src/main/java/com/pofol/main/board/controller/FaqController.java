package com.pofol.main.board.controller;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.service.FaqService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class FaqController {
    private final FaqService faqService;

    // FAQ 페이지
    @GetMapping("/faq")
    public String faqPage() {
        return "board/faq/faq";
    }

    // FAQ 목록 조회
    @ResponseBody
    @PostMapping("/list")
    public Map<String, Object> getFaqList(@RequestBody FaqDto dto) {
        String faqType = dto.getFaq_type();

        int totalCnt = faqService.countFaq(dto);
        int totalPage = (int) Math.ceil((double) totalCnt / dto.getPageSize());

        dto.setFaq_type(faqType);
        dto.setTotalCnt(totalCnt);
        dto.setTotalPage(dto.getPageSize());


        // 가져온 faqType으로 비즈니스 로직을 수행 -> 목록을 얻어옴
        List<FaqDto> list = faqService.selectPaged(dto);

        Map<String, Object> response = new HashMap<>();
        response.put("faqList", list);
        response.put("totalCnt", totalCnt);
        response.put("totalPage", totalPage);

        return response;
    }

    // FAQ 등록/수정 페이지 화면
    @GetMapping("/faq_write")
    public String faq_write(@RequestParam(defaultValue = "new") String mode,
                            FaqDto dto,
                            Model m) {
        // 수정 모드일 때는 저장된 값을 보여줘야 함
        if ("edit".equals(mode)) {
            // 상세조회
            FaqDto faq = faqService.selectFaq(dto.getFaq_id());
            List<ImageDto> imageList = faqService.getImageList(dto.getFaq_id(), "faq");

            faq.setImageList(imageList);
            m.addAttribute("faq", faq);
        }

        m.addAttribute("mode", mode);

        return "board/faq/faq_write";
    }

    // FAQ 등록/수정 요청 제출
    @PostMapping("/saveFaq")
    public String saveFaq(@RequestParam String mode,
                          FaqDto dto,
                          RedirectAttributes redirectAttributes) {
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
        int result = faqService.deleteFaq(dto);

        if (result > 0) {
            return ResponseEntity.ok().body(dto.getFaq_id());
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }
}
