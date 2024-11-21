package com.pofol.util;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FileRepository;
import com.pofol.main.board.service.FileService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.async.AsyncRequestBody;
import software.amazon.awssdk.services.s3.S3AsyncClient;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.DeleteObjectResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class S3Service implements FileService {
    private final S3AsyncClient S3AsyncClient;
    private final FileRepository fileRepository;
    @Override
    public List<ImageDto> fileUpload(List<MultipartFile> uploadFiles) {
        List<ImageDto> list = new ArrayList<>();

        String dateFormat = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

        for (MultipartFile file : uploadFiles) {
            String uuid = UUID.randomUUID().toString();
            String fileName = file.getOriginalFilename();
            String uploadPath = dateFormat + "/" + uuid + "_" + fileName;

            // 업로드하기 위한 요청 생성
            PutObjectRequest objectRequest = PutObjectRequest.builder()
                    .bucket("ecoeats-fileupload")
                    .key(uploadPath)
                    .contentType(file.getContentType())
                    .build();

            // MultipartFile의 데이터를 byte[]로 읽음
            try {
                byte[] fileBytes = file.getBytes();

                CompletableFuture<PutObjectResponse> future = S3AsyncClient.putObject(
                        objectRequest,
                        AsyncRequestBody.fromBytes(fileBytes)
                );

                future.whenComplete((resp, err) -> {
                    try {
                        if (resp != null) {
                            list.add(new ImageDto(fileName, dateFormat, uuid));
                            System.out.println("업로드 완료, 세부사항 = " + resp);
                        } else {
                            err.printStackTrace();
                        }
                    } finally {
                        S3AsyncClient.close();
                    }
                });

                future.join();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return list;
    }

    @Override
    public byte[] getFile(String fileName) {
        return null;
    }

    @Override
    public CompletableFuture<Void> deleteFile(List<ImageDto> imageList) {
        for (ImageDto image : imageList) {
            String uploadPath = image.getUploadPath() + "/" + image.getUuid() + "_" + image.getFileName();

            DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
                    .bucket("ecoeats-fileupload")
                    .key(uploadPath)
                    .build();

            CompletableFuture<DeleteObjectResponse> response = S3AsyncClient.deleteObject(deleteObjectRequest);

            response.whenComplete((res, ex) -> {
                if (res != null) {
                    System.out.println("이미지 삭제 완료 " + res);
                } else {
                    throw new RuntimeException("An S3 exception occurred during delete", ex);
                }
            });
        }
        return null;
    }

    @Override
    public List<ImageDto> getImageList(int item_id, String mode) {
        try {

            return fileRepository.getImageList(item_id, mode);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
