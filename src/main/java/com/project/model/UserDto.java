package com.project.model;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
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
    
    public UserDto() {}

    public String getId() { return id; }
    public void setId( String id ) { this.id = id; }
    public String getCompanyName() { return companyName; }
    public void setCompanyName(String companyName) { this.companyName = companyName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String toString() {
        return "UserDto{Id='" + id + "', companyName='" + companyName + "', email='" + email + "', phoneNumber='" + phoneNumber + "'}";
    }
}
