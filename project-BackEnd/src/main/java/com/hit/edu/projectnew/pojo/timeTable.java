package com.hit.edu.projectnew.pojo;

import java.time.LocalDate;

public class timeTable {
    private Integer CID;
    private String schedule;
    private LocalDate dateTime;

    public Integer getCID() {
        return CID;
    }

    public void setCID(Integer CID) {
        this.CID = CID;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    public LocalDate getDateTime() {
        return dateTime;
    }

    public void setDateTime(LocalDate dateTime) {
        this.dateTime = dateTime;
    }

    public timeTable(Integer CID, String schedule, LocalDate dateTime) {
        this.CID = CID;
        this.schedule = schedule;
        this.dateTime = dateTime;
    }

    public timeTable() {
    }

    @Override
    public String toString() {
        return "timeTable{" +
                "CID=" + CID +
                ", schedule='" + schedule + '\'' +
                ", dateTime=" + dateTime +
                '}';
    }
}
