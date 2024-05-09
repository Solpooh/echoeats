package com.pofol.main.board.controller;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.service.FaqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board")
public class FaqController {
    private final FaqService faqService;

    public FaqController(FaqService faqService) {
        this.faqService = faqService;
    }

    // FAQ 사용자 페이지
    @RequestMapping(value = "/faq")
    public String faqPage() {
        return "board/faq";
    }
    // FAQ 관리자 페이지
    @RequestMapping("/faq_admin")
    public String faq_admin(){
        return "board/faq_admin";
    }

    // AJAX 로 FAQ 목록 가져오기
    @ResponseBody
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    public Map<String, Object> getFaqList(@RequestBody FaqDto dto) {
        String faqType = dto.getFaq_type();
        System.out.println("faqType: " + faqType);
        System.out.println("dto: " + dto);

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

    // FAQ 작성 페이지
    @RequestMapping("/faq_write")
    public String faq_write() {
        return "board/faq_write";
    }

    // FAQ 등록 페이지
    @RequestMapping(value = "/insertFaq", method = RequestMethod.POST)
    public String faq_register(FaqDto dto) {
        System.out.println("FAQ 입력");
        System.out.println("dto : " + dto);

        faqService.insertFaq(dto);
        return "redirect:/board/faq_admin";
    }

    // FAQ 수정 페이지
    @RequestMapping("/faq_modify")
    public String faq_modify(FaqDto dto, Model model) {
        FaqDto faq = faqService.selectFaq(dto.getFaq_id());
        model.addAttribute("faq", faq);

        System.out.println("faq : " + faq);

        return "board/faq_modify";
    }

    @RequestMapping(value = "/updateFaq", method = RequestMethod.POST)
    public String updateNotice(FaqDto dto) {
        System.out.println("===> FAQ 수정");
        int result = faqService.updateFaq(dto);
        System.out.println("result = " + result);
        return "redirect:/board/faq_admin";
    }

    @ResponseBody
    @RequestMapping(value = "/deleteFaq", method = RequestMethod.POST)
    public ResponseEntity<?> deleteFaq(@RequestBody FaqDto dto) {
        int result = faqService.deleteFaq(dto);

        if (result > 0) {
            return ResponseEntity.ok().body(dto.getFaq_id());
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }


}
