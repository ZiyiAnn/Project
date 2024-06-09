package com.hit.edu.projectnew.pojo;

public class student {
    private String SID;
    private String name;
    private Integer gender;
    private Long telephone;
    private String email;
    private String code;

    public student() {
    }

    public student(String SID, String name, Integer gender, Long telephone, String email, String code) {
        this.SID = SID;
        this.name = name;
        this.gender = gender;
        this.telephone = telephone;
        this.email = email;
        this.code = code;
    }

    public String getSID() {
        return SID;
    }

    public void setSID(String SID) {
        this.SID = SID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Long getTelephone() {
        return telephone;
    }

    public void setTelephone(Long telephone) {
        this.telephone = telephone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "student{" +
                "SID='" + SID + '\'' +
                ", name='" + name + '\'' +
                ", gender=" + gender +
                ", telephone=" + telephone +
                ", email='" + email + '\'' +
                ", code='" + code + '\'' +
                '}';
    }
}
