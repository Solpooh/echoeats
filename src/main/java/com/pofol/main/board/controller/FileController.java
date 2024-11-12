package com.pofol.main.board.controller;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.service.FileService;
import com.pofol.main.board.service.FaqService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class FileController {
    private final FileService fileService;
    private final FaqService faqService;

    // 서버에 이미지 저장
    @PostMapping(value = "/uploadImage", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> upload(MultipartFile[] uploadFile) {
        List<ImageDto> list = fileService.fileUpload(uploadFile);

        // 이미지 파일이 아닌 경우 처리
        if (list.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    // 이미지 출력
    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){
        byte[] imageBytes = fileService.getFile(fileName);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-type", "image/jpeg"); // 확장자에 맞게 설정 가능
        return new ResponseEntity<>(imageBytes, headers, HttpStatus.OK);
    }

    /* 이미지 파일 삭제 */
    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName){
        fileService.deleteFile(fileName);
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

    // 이미지 리스트 반환
    @GetMapping(value = "/getImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> getImageList(int item_id, String mode) {
        return new ResponseEntity<>(fileService.getImageList(item_id, mode), HttpStatus.OK);
    }
}
