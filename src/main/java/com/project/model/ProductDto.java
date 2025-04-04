package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ProductDto {
    private int productId;
    private int memberNo;
    private int category_code;
    private String productName;
    private String productDescription;
    private String image;
    private Timestamp productRegistrationDate;
}
