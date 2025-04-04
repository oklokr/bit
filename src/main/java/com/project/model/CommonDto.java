package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CommonDto {
    private int commonId;
    private String commonCode;
    private Timestamp commonCreateDate;
}
