package com.project.model;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Alias("UserDto")
public class UserDto {
    private String id;
    private String companyName;
    private String password;
    private String email;
    private String phoneNumber;
    private String address;
    private String detailedAddress;
    private String postalCode;
    private int memberType;
    private Timestamp joinDate;
}
