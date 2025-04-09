package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReplyDto {
    private int replyId;
    private int boardId;
    private String id;
    private String author;
    private Timestamp creationDate;
    private String replyTitle;
    private String replyContent;
    private int replyRef;
    private int replyStep;
    private int replyLevel;
}
