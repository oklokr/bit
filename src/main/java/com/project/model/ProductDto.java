package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ProductDto {
    private int productId;
    private String id;
    private String image;
    private String productName;
    private String categoryCode;
    private String categoryName;
    private String productDescription;
    private Timestamp productRegistrationDate;
}