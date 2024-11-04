package com.pofol.main.board.exception;

public class CustomException {
    public static class NoExistBoardException extends RuntimeException {
        public NoExistBoardException(String message) {
            super(message);
        }
    }
    public static class UnauthorizedException extends RuntimeException {
        public UnauthorizedException(String message) {
            super(message);
        }
    }
    public static class ValidationException extends RuntimeException {
        public ValidationException(String message) {
            super(message);
        }
    }
    public static class ForbiddenException extends RuntimeException {
        public ForbiddenException(String message) {
            super(message);
        }
    }
}
