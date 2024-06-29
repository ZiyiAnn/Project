package com.hit.edu.projectnew.pojo;

import org.springframework.data.relational.core.sql.In;

import java.time.LocalDate;
import java.util.Date;

public class reservation {
    private Integer CID;
    private Integer occuStatus;
    private Integer occuTime;
    private String reservations;
    private String reason;

    private Integer type;
    private LocalDate dateTime;
    public reservation() {
    }

    public reservation(Integer CID, Integer occuStatus, Integer occuTime, String reservations, String reason, Integer type, LocalDate dateTime) {
        this.CID = CID;
        this.occuStatus = occuStatus;
        this.occuTime = occuTime;
        this.reservations = reservations;
        this.reason = reason;
        this.type = type;
        this.dateTime = dateTime;
    }

//    public reservation(Integer CID, Integer occuStatus, Integer occuTime, String reservations, String reason, Integer type) {
//        this.CID = CID;
//        this.occuStatus = occuStatus;
//        this.occuTime = occuTime;
//        this.reservations = reservations;
//        this.reason = reason;
//        this.type = type;
//    }

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

    @Override
    public String toString() {
        return "reservation{" +
                "CID=" + CID +
                ", occuStatus=" + occuStatus +
                ", occuTime=" + occuTime +
                ", reservations='" + reservations + '\'' +
                ", reason='" + reason + '\'' +
                ", type=" + type +
                ", dateTime=" + dateTime +
                '}';
    }
}
