package com.pofol.main.board.controller;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.domain.ImageUpload;
import com.pofol.main.board.service.FaqService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.List;

@RestController
public class ImageController {
    private final ImageUpload imageUpload;
    private final FaqService faqService;

    public ImageController(ImageUpload imageUpload, FaqService faqService) {
        this.imageUpload = imageUpload;
        this.faqService = faqService;
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
            return new ResponseEntity<>("fail", HttpStatus.NOT_IMPLEMENTED);

        }
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    // 이미지 리스트 반환
    @GetMapping(value = "/getImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> getImageList(int item_id, String mode) {
        return new ResponseEntity<>(faqService.getImageList(item_id, mode), HttpStatus.OK);
    }
}
