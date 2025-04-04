package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductRequestParam {
    private String id;
    private String productName;
    private Timestamp productRegistrationDate;
    private String categoryCode;
    private int page = 0;
    private int size = 10;
}
