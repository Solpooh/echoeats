package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

public interface FileService {
    List<ImageDto> fileUpload(MultipartFile[] uploadFiles);
    byte[] getFile(String fileName);
    void deleteFile(String fileName);
    List<ImageDto> getImageList(int item_id, String mode);
}
