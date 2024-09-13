package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

public interface FileService {
    List<ImageDto> fileUpload(MultipartFile[] uploadFiles);
    String getDatePath();
    File getUploadPath(String datePath);
    void createDirectoryIfNotExists(File uploadPath);
    boolean isImageFile(MultipartFile multipartFile) throws IOException;
    ImageDto saveImageFile(MultipartFile file, File uploadPath, String datePath) throws IOException;
    void createThumbnail(File saveFile, File uploadPath, String uploadFileName) throws IOException;
    void deleteFiles(List<ImageDto> fileList);
}
