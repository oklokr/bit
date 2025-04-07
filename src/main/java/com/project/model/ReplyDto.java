package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyDto {
    private int reply_id;
    private int board_id;
    private String member_no;
    private String author;
    private Timestamp creation_date;
    private String reply_title;
    private String reply_content;
    //같은 댓글인지 구분 = ref
    private int reply_order;
    private int reply_step;
    private int reply_level;
}
