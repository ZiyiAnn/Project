package com.hit.edu.projectnew.pojo;

import org.springframework.data.relational.core.sql.In;

public class photo {
  private Integer CID;
  private String fileName;
  private byte[] photoData;

  public Integer getCID() {
    return CID;
  }

  public void setCID(Integer CID) {
    this.CID = CID;
  }

  public String getFileName() {
    return fileName;
  }

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }

  public byte[] getPhotoData() {
    return photoData;
  }

  public void setPhotoData(byte[] photoData) {
    this.photoData = photoData;
  }
}
