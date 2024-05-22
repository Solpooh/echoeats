package com.pofol.main.board.domain;

import net.coobird.thumbnailator.Thumbnails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.*;

@Component
public class ImageUpload {
    private static final Logger logger = LoggerFactory.getLogger(ImageUpload.class);
    private static final String UPLOAD_FOLDER = "C:\\upload";
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


    // ImageDto 객체를 담아서 반환
    public List<ImageDto> handleFileUpload(MultipartFile[] uploadFiles) {
        List<ImageDto> imageList = new ArrayList<>();
        String datePath = getDatePath();

        File uploadPath = getUploadPath(datePath);
        createDirectoryIfNotExists(uploadPath);

        for (MultipartFile multipartFile : uploadFiles) {
            try {
                if (isImageFile(multipartFile)) {
                    ImageDto imageDto = saveImageFile(multipartFile, uploadPath, datePath);
                    imageList.add(imageDto);
                }
            } catch (IOException e) {
                logger.error("File upload error", e);
            }
        }
        return imageList;
    }

    private String getDatePath() {
        Date date = new Date();
        return sdf.format(date).replace("-", File.separator);
    }

    private File getUploadPath(String datePath) {
        return new File(UPLOAD_FOLDER, datePath);
    }

    private void createDirectoryIfNotExists(File uploadPath) {
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }
    }

    private boolean isImageFile(MultipartFile multipartFile) throws IOException {
        File checkFile = new File(Objects.requireNonNull(multipartFile.getOriginalFilename()));
        String type = null;
        try {
            type = Files.probeContentType(checkFile.toPath());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return type != null && type.startsWith("image");
    }

    private ImageDto saveImageFile(MultipartFile multipartFile, File uploadPath, String datePath) throws IOException {
        ImageDto imageDto = new ImageDto();
        String originalFileName = multipartFile.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
        String uploadFileName = uuid + "_" + originalFileName;

        imageDto.setFileName(originalFileName);
        imageDto.setUploadPath(datePath);
        imageDto.setUuid(uuid);

        // 폴더에 비로소 저장
        File saveFile = new File(uploadPath, uploadFileName);
        try {
            multipartFile.transferTo(saveFile);
        } catch (IOException | IllegalStateException e) {
            e.printStackTrace();
        }

        createThumbnail(saveFile, uploadPath, uploadFileName);

        return imageDto;
    }

    private void createThumbnail(File saveFile, File uploadPath, String uploadFileName) throws IOException {
        File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
        BufferedImage boImage = ImageIO.read(saveFile);

        int width = (int) (boImage.getWidth() / 3);
        int height = (int) (boImage.getHeight() / 3);

        Thumbnails.of(saveFile)
                .size(width, height)
                .toFile(thumbnailFile);
    }
}
