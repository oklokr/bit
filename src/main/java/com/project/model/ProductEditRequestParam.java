package com.project.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductEditRequestParam {
    private Integer productId;
    private String image;
    private String productName; 
    private String categoryCode; 
    private String productDescription;
}
