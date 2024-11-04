package com.pofol.main.board.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(CustomException.NoExistBoardException.class)
    public static ResponseEntity<String> noExistBoard() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("해당 게시물이 존재하지 않습니다");
    }
    @ExceptionHandler(CustomException.UnauthorizedException.class)
    public static ResponseEntity<String> authorizationFailed() {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("권한이 없습니다.");
    }
    @ExceptionHandler(CustomException.ValidationException.class)
    public static ResponseEntity<String> validationFailed() {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("유효성 검사 실패");
    }
    @ExceptionHandler(CustomException.ForbiddenException.class)
    public static ResponseEntity<String> noPermission() {
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body("허가되지 않은 접근입니다");
    }
    @ExceptionHandler(Exception.class)
    public static ResponseEntity<String> dataBaseError() {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
    }
}
