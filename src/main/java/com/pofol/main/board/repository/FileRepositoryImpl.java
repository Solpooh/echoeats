package com.pofol.main.board.repository;

import com.pofol.main.board.domain.ImageDto;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class FileRepositoryImpl implements FileRepository {
    private final SqlSession session;
    private static final String namespace = "com.pofol.main.repository.fileRepository.";

    @Override
    public int imageInsert(ImageDto dto) {
        return session.insert(namespace + "imageInsert", dto);
    }
    @Override
    public List<ImageDto> getImageList(int item_id, String mode) {
        Map<String, Object> map = new HashMap<>();
        map.put("item_id", item_id);
        map.put("mode", mode);
        return session.selectList(namespace + "getImageList", map);
    }
    @Override
    public void deleteImageAll(int item_id, String mode) {
        Map<String, Object> map = new HashMap<>();
        map.put("item_id", item_id);
        map.put("mode", mode);

        session.delete(namespace + "deleteImageAll", map);
    }
    @Override
    public List<ImageDto> checkFileList() {
        return session.selectList(namespace + "checkFileList");
    }
}
