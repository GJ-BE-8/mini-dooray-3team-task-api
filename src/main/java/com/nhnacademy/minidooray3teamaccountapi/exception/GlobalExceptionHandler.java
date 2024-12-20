package com.nhnacademy.minidooray3teamaccountapi.exception;

import com.nhnacademy.minidooray3teamaccountapi.dto.ErrorDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<String> handleNotFound(ResourceNotFoundException ex) {
        return ResponseEntity.status(404).body(ex.getMessage());
    }

    @ExceptionHandler(ProjectNotFoundException.class)
    public ResponseEntity<ErrorDTO> handleProjectNotFound(ProjectNotFoundException ex) {
        return errorResponse(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    /**
     * 사용자를 찾을 수 없는 경우
     */
    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<ErrorDTO> handleUserNotFound(UserNotFoundException ex) {
        return errorResponse(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    /**
     * 프로젝트에 이미 멤버가 존재하는 경우
     */
    @ExceptionHandler(MemberAlreadyExistsException.class)
    public ResponseEntity<ErrorDTO> handleMemberAlreadyExists(MemberAlreadyExistsException ex) {
        return errorResponse(HttpStatus.BAD_REQUEST, ex.getMessage());
    }

    /**
     * 프로젝트 멤버를 찾을 수 없는 경우
     */
    @ExceptionHandler(MemberNotFoundException.class)
    public ResponseEntity<ErrorDTO> handleMemberNotFound(MemberNotFoundException ex) {
        return errorResponse(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    /**
     * 권한이 없는 경우
     */
    @ExceptionHandler(UnauthorizedAccessException.class)
    public ResponseEntity<ErrorDTO> handleUnauthorizedAccess(UnauthorizedAccessException ex) {
        return errorResponse(HttpStatus.FORBIDDEN, ex.getMessage());
    }

    /**
     * 응답 DTO를 생성하여 반환
     */
    private ResponseEntity<ErrorDTO> errorResponse(HttpStatus status, String message) {
        ErrorDTO error = new ErrorDTO(
                message,
                status.value(),
                LocalDateTime.now()
        );
        return ResponseEntity.status(status).body(error);
    }
}


