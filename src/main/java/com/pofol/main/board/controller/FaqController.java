package com.pofol.main.board.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
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

import java.awt.*;
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
    private final ImageUpload imageUpload;

    public FaqController(FaqService faqService, ImageUpload imageUpload) {
        this.faqService = faqService;
        this.imageUpload = imageUpload;
    }

    // FAQ 사용자 페이지
    @RequestMapping(value = "/faq")
    public String faqPage() {
        return "board/faq";
    }

    // FAQ 관리자 페이지
    @RequestMapping("/faq_admin")
    public String faq_admin() {
        return "board/faq_admin";
    }

    // FAQ 목록
    @ResponseBody
    @RequestMapping(value = "/list", method = RequestMethod.POST)
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
    @RequestMapping("/faq_write")
    public String faq_write(@RequestParam(defaultValue = "new") String mode,
                            FaqDto dto,
                            Model m) {
        if ("edit".equals(mode)) {
            FaqDto faq = faqService.selectFaq(dto.getFaq_id());
            List<ImageDto> imageList = faqService.getImageList(dto.getFaq_id());
            faq.setImageList(imageList);
            System.out.println("faq = " + faq);
            m.addAttribute("faq", faq);
        }

        m.addAttribute("mode", mode);
        return "board/faq_write";
    }

    // FAQ 등록, 수정
    @PostMapping(value = "/saveFaq")
    public String saveFaq(FaqDto dto,
                          @RequestParam String mode) {
        if ("edit".equals(mode)) {
            faqService.updateFaq(dto);
        } else {
            faqService.insertFaq(dto);
        }
        return "redirect:/board/faq_admin";
    }

    // 서버에 이미지 저장
    @PostMapping(value = "/uploadImage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
        List<ImageDto> list = imageUpload.handleFileUpload(uploadFile);

        // 이미지 파일이 아닌 경우 처리
        if (list.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    // 이미지 출력
    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){
        File file = new File("C:\\upload\\" + fileName);
        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();
            // content-type 확실하게 명시
            header.add("Content-type", Files.probeContentType(file.toPath()));
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
        }catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    /* 이미지 파일 삭제 */
    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName){
        File file = null;
        System.out.println("deleteFile........" + fileName);
        try {
            /* 썸네일 파일 삭제 */
            file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

            file.delete();

            /* 원본 파일 삭제 */
            String originFileName = file.getAbsolutePath().replace("s_", "");
            file = new File(originFileName);

            file.delete();
            System.out.println("originFileName : " + originFileName);

        } catch(Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);

        }
        return new ResponseEntity<String>("success", HttpStatus.OK);
    }

    // 이미지 리스트 반환
    @GetMapping(value = "/getImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> getImageList(int faq_id) {
        return new ResponseEntity<>(faqService.getImageList(faq_id), HttpStatus.OK);
    }

    // FAQ 삭제
    @ResponseBody
    @RequestMapping(value = "/deleteFaq", method = RequestMethod.POST)
    public ResponseEntity<?> deleteFaq(@RequestBody FaqDto dto) {
        int result = faqService.deleteFaq(dto);

        List<ImageDto> fileList = faqService.getImageList(dto.getFaq_id());
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
