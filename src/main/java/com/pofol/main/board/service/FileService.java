package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.concurrent.CompletableFuture;

public interface FileService {
    List<ImageDto> fileUpload(List<MultipartFile> uploadFiles);
    byte[] getFile(String fileName);
    CompletableFuture<Void> deleteFile(List<ImageDto> imageList);
    List<ImageDto> getImageList(int item_id, String mode);
}
