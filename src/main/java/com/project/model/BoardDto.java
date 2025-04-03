package com.project.model;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Component
public class BoardDto {
    private int board_id;
    private String member_no;
    private String title;
    private String content;
    private String author;
    private Timestamp creation_date;
    private int view_count;
}
