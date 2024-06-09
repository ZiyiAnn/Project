package com.hit.edu.projectnew.pojo;

import java.time.LocalDate;
import java.util.Date;

public class checklist {
    private Integer CID;
    private Integer occuTime;
    private Integer checkStatus;

    private LocalDate dateTime;
    private String reservations;

    public checklist() {
    }

    public checklist(Integer CID, Integer occuTime, Integer checkStatus, LocalDate dateTime, String reservations) {
        this.CID = CID;
        this.occuTime = occuTime;
        this.checkStatus = checkStatus;
        this.dateTime = dateTime;
        this.reservations = reservations;
    }


    public Integer getCID() {
        return CID;
    }

    public void setCID(Integer CID) {
        this.CID = CID;
    }

    public Integer getOccuTime() {
        return occuTime;
    }

    public void setOccuTime(Integer occuTime) {
        this.occuTime = occuTime;
    }

    public Integer getCheckStatus() {
        return checkStatus;
    }

    public void setCheckStatus(Integer checkStatus) {
        this.checkStatus = checkStatus;
    }

    public LocalDate getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDate dateTime) {
        this.dateTime = dateTime;
    }

    public String getReservations() {
        return reservations;
    }

    public void setReservations(String reservations) {
        this.reservations = reservations;
    }

    @Override
    public String toString() {
        return "checklist{" +
                "CID=" + CID +
                ", occuTime=" + occuTime +
                ", checkStatus=" + checkStatus +
                ", dateTime=" + dateTime +
                ", reservations='" + reservations + '\'' +
                '}';
    }
}
