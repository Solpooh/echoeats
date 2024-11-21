package com.pofol.main.board.controller;
import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class FileController {
    private final FileService fileService;

    // 이미지 리스트 반환
    @GetMapping(value = "/getImageList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<ImageDto>> getImageList(int item_id, String mode) {
        return new ResponseEntity<>(fileService.getImageList(item_id, mode), HttpStatus.OK);
    }
}
