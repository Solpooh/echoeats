package com.pofol.main.board.controller;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.ImageUpload;
import com.pofol.main.board.service.FaqService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;
import java.util.List;

@Controller
@RequestMapping("/board")
public class FaqController {
    private final FaqService faqService;

    public FaqController(FaqService faqService) {
        this.faqService = faqService;
    }

    // FAQ 사용자 페이지
    @GetMapping("/faq")
    public String faqPage() {
        return "board/faq/faq";
    }

    // FAQ 관리자 페이지
    @GetMapping("/faq_admin")
    public String faq_admin() {
        return "board/faq/faq_admin";
    }

    // FAQ 목록
    @ResponseBody
    @PostMapping("/list")
    public Map<String, Object> getFaqList(@RequestBody FaqDto dto) {
        System.out.println("dto = " + dto);
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

    // FAQ 작성 페이지
    @GetMapping("/faq_write")
    public String faq_write(@RequestParam(defaultValue = "new") String mode,
                            FaqDto dto,
                            Model m) {
        if ("edit".equals(mode)) {
            FaqDto faq = faqService.selectFaq(dto.getFaq_id());
            List<ImageDto> imageList = faqService.getImageList(dto.getFaq_id(), "faq");
            faq.setImageList(imageList);
            m.addAttribute("faq", faq);
        }

        m.addAttribute("mode", mode);
        return "board/faq/faq_write";
    }

    // FAQ 등록, 수정 => 수정 후에 페이지 유지하기
    @PostMapping("/saveFaq")
    public String saveFaq(FaqDto dto,
                          @RequestParam String mode) {
        if ("edit".equals(mode)) {
            faqService.updateFaq(dto);
        } else {
            faqService.insertFaq(dto);
        }
        return "redirect:/board/faq_admin";
    }

    // FAQ 삭제 => 삭제 후 페이지 유지하기
    @ResponseBody
    @PostMapping("/deleteFaq")
    public ResponseEntity<?> deleteFaq(@RequestBody FaqDto dto) {
        int result = faqService.deleteFaq(dto);

        List<ImageDto> fileList = faqService.getImageList(dto.getFaq_id(), "faq");
        if (fileList != null) {
            List<Path> pathList = new ArrayList<>();
            fileList.forEach(list -> {
                // 원본 이미지
                Path path = Paths.get("C:\\upload", list.getUploadPath(), list.getUuid() + "_" + list.getFileName());
                pathList.add(path);

                // 섬네일 이미지
                path = Paths.get("C:\\upload", list.getUploadPath(), "s_" + list.getUuid()+"_" + list.getFileName());
                pathList.add(path);
            });
            pathList.forEach(path ->{
                path.toFile().delete();
            });
        }

        if (result > 0) {
            return ResponseEntity.ok().body(dto.getFaq_id());
        } else {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }
}
