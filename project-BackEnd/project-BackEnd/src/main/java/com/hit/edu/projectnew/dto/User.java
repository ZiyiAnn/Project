package com.hit.edu.projectnew.dto;

public class User {
  private String ID;

  private String name;
  private Integer gender;
  private Long telephone;
  private String email;


  public String getID() {
    return ID;
  }

  public void setID(String ID) {
    this.ID = ID;
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
}
