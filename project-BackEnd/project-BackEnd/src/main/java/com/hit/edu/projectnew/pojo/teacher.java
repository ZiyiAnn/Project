package com.hit.edu.projectnew.pojo;

public class teacher {
    private String TID;
    private String name;
    private Integer gender;
    private Long telephone;
    private String email;
    private String code;

    public teacher() {
    }

    public teacher(String TID, String name, Integer gender, Long telephone, String email, String code) {
        this.TID = TID;
        this.name = name;
        this.gender = gender;
        this.telephone = telephone;
        this.email = email;
        this.code = code;
    }

    public String getTID() {
        return TID;
    }

    public String getName() {
        return name;
    }

    public Integer getGender() {
        return gender;
    }

    public Long getTelephone() {
        return telephone;
    }

    public String getEmail() {
        return email;
    }

    public String getCode() {
        return code;
    }

    public void setTID(String TID) {
        this.TID = TID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public void setTelephone(Long telephone) {
        this.telephone = telephone;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setCode(String code) {
        this.code = code;
    }



    @Override
    public String toString() {
        return "teacher{" +
                "TID='" + TID + '\'' +
                ", name='" + name + '\'' +
                ", gender=" + gender +
                ", telephone=" + telephone +
                ", email='" + email + '\'' +
                ", code='" + code + '\'' +
                '}';
    }
}
