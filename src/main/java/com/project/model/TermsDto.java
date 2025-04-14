package com.project.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class TermsDto {
    private int termsId;
    private String termsTitle;
    private String termsContent;
    private String termsType;
    private String termsRequired;
}
