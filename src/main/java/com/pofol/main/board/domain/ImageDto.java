package com.pofol.main.board.domain;

import lombok.Data;

@Data
public class ImageDto {
    // 경로
    private String uploadPath;

    // uuid
    private String uuid;

    // 파일 이름
    private String fileName;

    // faq_id 또는 notice_id
    private int item_id;

    // 모드 (faq 또는 notice)
    private String mode;
    public ImageDto() {}

    public ImageDto(String fileName, String uploadPath, String uuid) {
        this.fileName = fileName;
        this.uploadPath = uploadPath;
        this.uuid = uuid;
    }
}
