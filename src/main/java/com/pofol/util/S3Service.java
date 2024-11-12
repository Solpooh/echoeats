package com.pofol.util;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FaqRepository;
import com.pofol.main.board.service.FileService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.core.ResponseBytes;
import software.amazon.awssdk.core.async.AsyncRequestBody;
import software.amazon.awssdk.core.async.AsyncResponseTransformer;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3AsyncClient;
import software.amazon.awssdk.services.s3.model.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

@RequiredArgsConstructor
@Service
@Slf4j
public class S3Service implements FileService {
    private final S3AsyncClient s3Client;
    private final String bucketName = "ecoeats-fileupload";
    private FaqRepository faqRepository;

    public S3Service() {
        // S3 클라이언트 생성
        this.s3Client = S3AsyncClient.builder()
                .region(Region.AP_NORTHEAST_2)
                .credentialsProvider(ProfileCredentialsProvider.create("default"))
                .build();
    }

    @Override
    public List<ImageDto> fileUpload(MultipartFile[] uploadFiles) {
        List<ImageDto> list = new ArrayList<>();
        List<CompletableFuture<PutObjectResponse>> futures = new ArrayList<>();

        for (MultipartFile file : uploadFiles) {
            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            // "images/2024-11-10/myimage.jpg"
            String uploadPath = "images/" + LocalDate.now().toString() + "/" + fileName;

            CompletableFuture<PutObjectResponse> future = null;

            try {
                future = s3Client.putObject(
                        PutObjectRequest.builder()
                                .bucket(bucketName)
                                .key(uploadPath)
                                .contentType(file.getContentType())
                                .build(),
                        AsyncRequestBody.fromBytes(file.getBytes())
                );
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            futures.add(future);

            future.thenAccept(response -> {
                if (response.sdkHttpResponse().isSuccessful()) {
                    list.add(new ImageDto(fileName, uploadPath, UUID.randomUUID().toString()));
                }
            });
        }
        // 모든 비동기 작업이 완료될 때까지 대기
        CompletableFuture.allOf(futures.toArray(new CompletableFuture[0])).join();
        return list;
    }

    @Override
    public byte[] getFile(String fileName) {
        CompletableFuture<ResponseBytes<GetObjectResponse>> future = s3Client.getObject(
                GetObjectRequest.builder()
                        .bucket(bucketName)
                        .key(fileName)
                        .build(),
                AsyncResponseTransformer.toBytes()
        );

        // byte 배열로 변환해서 반환
        return future.thenApply(ResponseBytes::asByteArray).join();
    }

    @Override
    public void deleteFile(String fileName) {
        CompletableFuture<DeleteObjectResponse> future = s3Client.deleteObject(
                DeleteObjectRequest.builder()
                        .bucket(bucketName)
                        .key(fileName)
                        .build()
        );

        future.join();
    }

    @Override
    public List<ImageDto> getImageList(int item_id, String mode) {
        try {
            return faqRepository.getImageList(item_id, mode);
        } catch (Exception e) {
            throw new RuntimeException("FAQ 이미지 조회 실패", e);
        }
    }

}
