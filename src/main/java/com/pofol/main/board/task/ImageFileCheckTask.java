package com.pofol.main.board.task;

import com.pofol.main.board.domain.ImageDto;
import com.pofol.main.board.repository.FaqRepositoryImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Component
@RequiredArgsConstructor
public class ImageFileCheckTask {
    private final FaqRepositoryImpl faqRepository;

    private String getYesFolder() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        String str = sdf.format(cal.getTime());
        return str.replace("-", File.separator);
    }

    // 매일 새벽 1시에 수행
    @Scheduled(cron = "0 0 1 * * *")
    public void checkFiles() throws Exception {
        System.out.println("File Check Task Run...");
        System.out.println(new Date());
        System.out.println("==================");

        // DB에 저장된 파일 리스트
        List<ImageDto> fileList = faqRepository.checkFileList();

        // 비교 기준 파일 리스트(Path 객체)
        List<Path> checkFilePath = new ArrayList<>();
        // 원본이미지
        fileList.forEach(dto -> {
            Path path = Paths.get("C:\\upload", dto.getUploadPath(), dto.getUuid() + "_" + dto.getFileName());
            checkFilePath.add(path);
        });
        // 썸네일이미지
        fileList.forEach(dto -> {
            Path path = Paths.get("C:\\upload", dto.getUploadPath(), "s_" + dto.getUuid() + "_" + dto.getFileName());
            checkFilePath.add(path);
        });
        // 디렉토리 파일 리스트
        File targetDir = Paths.get("C:\\upload", getYesFolder()).toFile();
        File[] targetFile = targetDir.listFiles();

        // 삭제 대상 파일 리스트(분류)
        List<File> removeFileList = new ArrayList<>(Arrays.asList(targetFile));
        for(File file : targetFile){
            checkFilePath.forEach(checkFile ->{
                if(file.toPath().equals(checkFile))
                    removeFileList.remove(file);
            });
        }
        // 삭제 대상 파일 제거
        System.out.println("file Delete : ");
        for(File file : removeFileList) {
            System.out.println(file);
            file.delete();
        }

        System.out.println("========================================");
    }
}
