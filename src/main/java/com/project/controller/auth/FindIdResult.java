package com.project.controller.auth;

public class FindIdResult {
    private boolean success; // 아이디 찾기 성공 여부
    private String userId;   // 찾은 아이디 (성공한 경우)

    // 생성자
    public FindIdResult(boolean success, String userId) {
        this.success = success;
        this.userId = userId;
    }

    // Getters and Setters
    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
}
