package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardDto {
    private int board_id;
    private String member_no;
    private String title;
    private String author;
    private Timestamp creation_date;
    private int view_count;
    private String content;
}
