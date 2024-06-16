package com.hit.edu.projectnew.dto;

import java.time.LocalDate;

public class Reservecheck {
  private Integer CID;
  private Integer occuStatus;
  private Integer occuTime;
  private String reservations;
  private String reason;

  private Integer type;
  private LocalDate dateTime;
  private Integer checkStatus;

  public Integer getCID() {
    return CID;
  }

  public void setCID(Integer CID) {
    this.CID = CID;
  }

  public Integer getOccuStatus() {
    return occuStatus;
  }

  public void setOccuStatus(Integer occuStatus) {
    this.occuStatus = occuStatus;
  }

  public Integer getOccuTime() {
    return occuTime;
  }

  public void setOccuTime(Integer occuTime) {
    this.occuTime = occuTime;
  }

  public String getReservations() {
    return reservations;
  }

  public void setReservations(String reservations) {
    this.reservations = reservations;
  }

  public String getReason() {
    return reason;
  }

  public void setReason(String reason) {
    this.reason = reason;
  }

  public Integer getType() {
    return type;
  }

  public void setType(Integer type) {
    this.type = type;
  }

  public LocalDate getDateTime() {
    return dateTime;
  }

  public void setDateTime(LocalDate dateTime) {
    this.dateTime = dateTime;
  }

  public Integer getCheckStatus() {
    return checkStatus;
  }

  public void setCheckStatus(Integer checkStatus) {
    this.checkStatus = checkStatus;
  }
}
