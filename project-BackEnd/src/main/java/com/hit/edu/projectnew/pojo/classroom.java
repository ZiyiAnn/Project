package com.hit.edu.projectnew.pojo;

public class classroom {
    private Integer CID;
    private Integer content;
    private String building;
    private Integer campus;
    private String equipment;

    public classroom() {
    }

    public classroom(Integer CID, Integer content, String building, Integer campus, String equipment) {
        this.CID = CID;
        this.content = content;
        this.building = building;
        this.campus = campus;
        this.equipment = equipment;
    }

    public Integer getCID() {
        return CID;
    }

    public void setCID(Integer CID) {
        this.CID = CID;
    }

    public Integer getContent() {
        return content;
    }

    public void setContent(Integer content) {
        this.content = content;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public Integer getCampus() {
        return campus;
    }

    public void setCampus(Integer campus) {
        this.campus = campus;
    }

    public String getEquipment() {
        return equipment;
    }

    public void setEquipment(String equipment) {
        this.equipment = equipment;
    }

    @Override
    public String toString() {
        return "classroom{" +
                "CID=" + CID +
                ", content=" + content +
                ", building='" + building + '\'' +
                ", campus=" + campus +
                ", equipment='" + equipment + '\'' +
                '}';
    }
}
