package com.project.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InventroyRequestParam {
    private String id;
    private String productName;
    private int page = 0;
    private int size = 10;
}
