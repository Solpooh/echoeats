package com.pofol.main.board.repository;

import com.pofol.main.board.domain.ImageDto;

import java.util.List;

public interface FileRepository {
    /* 이미지 등록 */
    int imageInsert(ImageDto dto) throws Exception;

    /* 이미지 데이터 반환 */
    List<ImageDto> getImageList(int item_id, String mode) throws Exception;

    /* 지정 게시물 이미지 전체 삭제 */
    void deleteImageAll(int item_id, String mode) throws Exception;

    /* 어제 날짜 이미지 가져오기 */
    List<ImageDto> checkFileList() throws Exception;
}
