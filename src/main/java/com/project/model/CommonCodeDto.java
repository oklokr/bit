package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class CommonCodeDto {
    private int commonCodeId;
    private String commonCode;
    private String commonName;
    private String commonValue;
    private Timestamp creationDate;
    private int commonId;
}
