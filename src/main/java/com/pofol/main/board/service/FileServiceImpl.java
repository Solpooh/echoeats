package com.pofol.main.board.service;

import com.pofol.main.board.domain.ImageDto;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class FileServiceImpl implements FileService {
    private static final String UPLOAD_FOLDER = "C:\\upload";
    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");


    // ImageDto 객체를 담아서 반환
    @Override
    public List<ImageDto> fileUpload(MultipartFile[] uploadFiles) {
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
                e.printStackTrace();
            }
        }
        return imageList;
    }

    @Override
    public String getDatePath() {
        Date date = new Date();
        return sdf.format(date).replace("-", File.separator);
    }

    @Override
    public File getUploadPath(String datePath) {
        return new File(UPLOAD_FOLDER, datePath);
    }

    @Override
    public void createDirectoryIfNotExists(File uploadPath) {
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }
    }

    @Override
    public boolean isImageFile(MultipartFile multipartFile) throws IOException {
        File checkFile = new File(Objects.requireNonNull(multipartFile.getOriginalFilename()));
        String type = null;
        try {
            type = Files.probeContentType(checkFile.toPath());
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return type != null && type.startsWith("image");
    }

    @Override
    public ImageDto saveImageFile(MultipartFile file, File uploadPath, String datePath) throws IOException {
        ImageDto imageDto = new ImageDto();
        String originalFileName = file.getOriginalFilename();
        String uuid = UUID.randomUUID().toString();
        String uploadFileName = uuid + "_" + originalFileName;

        imageDto.setFileName(originalFileName);
        imageDto.setUploadPath(datePath);
        imageDto.setUuid(uuid);

        // 폴더에 비로소 저장
        File saveFile = new File(uploadPath, uploadFileName);
        try {
            file.transferTo(saveFile);
        } catch (IOException | IllegalStateException e) {
            e.printStackTrace();
        }

        createThumbnail(saveFile, uploadPath, uploadFileName);

        return imageDto;
    }

    @Override
    public void createThumbnail(File saveFile, File uploadPath, String uploadFileName) throws IOException {
        File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
        BufferedImage boImage = ImageIO.read(saveFile);

        int width = (int) (boImage.getWidth() / 3);
        int height = (int) (boImage.getHeight() / 3);

        Thumbnails.of(saveFile)
                .size(width, height)
                .toFile(thumbnailFile);
    }

    @Override
    public void deleteFiles(List<ImageDto> fileList) {
        if (fileList != null && !fileList.isEmpty()) {
            List<Path> pathList = new ArrayList<>();
            fileList.forEach(list -> {
                // 원본 이미지
                pathList.add(Paths.get(UPLOAD_FOLDER, list.getUploadPath(), list.getUuid() + "_" + list.getFileName()));
                // 썸네일 이미지
                pathList.add(Paths.get(UPLOAD_FOLDER, list.getUploadPath(), "s_" + list.getUuid() + "_" + list.getFileName()));
            });

            // 파일 삭제
            pathList.forEach(path -> {
                try {
                    Files.deleteIfExists(path);
                } catch (Exception e) {
                    // 예외 처리: 로그 기록 및 트랜잭션 롤백
                    e.printStackTrace();
                }
            });
        }
    }
}
