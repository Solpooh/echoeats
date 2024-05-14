package com.pofol.main.board.controller;

import com.pofol.main.board.domain.FaqDto;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.service.FaqService;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
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

    // FAQ 등록하기
    @RequestMapping(value = "/insertFaq", method = RequestMethod.POST)
    public String faq_register(FaqDto dto) {
        System.out.println("FAQ 입력");
        System.out.println("dto : " + dto);

        faqService.insertFaq(dto);
        return "redirect:/board/faq_admin";
    }

    /* 첨부 파일 업로드 */
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
        // 향상된 for
        String uploadFolder = "C:\\upload";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Date date = new Date();
        String str = sdf.format(date);
        String datePath = str.replace("-", File.separator); // '/' 로 바꾸기
        /* 폴더 생성 */
        File uploadPath = new File(uploadFolder, datePath);

        if(!uploadPath.exists()) {
            uploadPath.mkdirs();
        }
        List<ImageDto> list = new ArrayList<>();

        for(MultipartFile multipartFile : uploadFile) {
            File checkfile = new File(Objects.requireNonNull(multipartFile.getOriginalFilename()));
            String type = null;

            try {
                type = Files.probeContentType(checkfile.toPath());
                System.out.println("MIME TYPE:" + type);
            } catch (IOException e) {
                e.printStackTrace();
            }
            if(type == null || !type.startsWith("image")) {
                return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
            }
            /* 이미지 정보 객체 */
            ImageDto dto = new ImageDto();

            /* 파일 이름 */
            String uploadFileName = multipartFile.getOriginalFilename();
            dto.setFileName(uploadFileName);
            dto.setUploadPath(datePath);

            /* uuid 적용 파일 이름 */
            String uuid = UUID.randomUUID().toString();
            dto.setUuid(uuid);

            uploadFileName = uuid + "_" + uploadFileName;

            /* 파일 위치, 파일 이름을 합친 File 객체 */
            File saveFile = new File(uploadPath, uploadFileName);

            /* 파일 저장 */
            try {
                multipartFile.transferTo(saveFile);

                File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
                BufferedImage bo_image = ImageIO.read(saveFile);

                //비율
                double ratio = 3;
                //넓이 높이
                int width = (int) (bo_image.getWidth() / ratio);
                int height = (int) (bo_image.getHeight() / ratio);

                Thumbnails.of(saveFile)
                        .size(width, height)
                        .toFile(thumbnailFile);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // 값을 설정해준 여러 이미지를 List에 저장
            list.add(dto);
        } // for

        ResponseEntity<List<ImageDto>> result = new ResponseEntity<>(list, HttpStatus.OK);

        return result;
    }

    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){
        File file = new File("C:\\upload\\" + fileName);
        ResponseEntity<byte[]> result = null;

        try {

            HttpHeaders header = new HttpHeaders();

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

    @GetMapping(value = "/getImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> getImageList(int faq_id) {
        return new ResponseEntity<>(faqService.getImageList(faq_id), HttpStatus.OK);
    }

    // FAQ 수정 페이지
    @RequestMapping("/faq_modify")
    public String faq_modify(FaqDto dto, Model m) {
        FaqDto faq = faqService.selectFaq(dto.getFaq_id());
        m.addAttribute("faq", faq);

        System.out.println("faq : " + faq);

        return "board/faq_modify";
    }

    // FAQ 수정하기
    @RequestMapping(value = "/updateFaq", method = RequestMethod.POST)
    public String updateNotice(FaqDto dto) {
        System.out.println("===> FAQ 수정");
        int result = faqService.updateFaq(dto);
        System.out.println("result = " + result);

        // redirectAttributes로 성공메시지 출력?
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
