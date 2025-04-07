package com.project.model;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Component
public class BoardDto {
    private int boardId;
    private String memberNo;
    private String title;
    private String content;
    private String author;
    private Timestamp creationDate;
    private int viewCount;
}
