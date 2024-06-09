package com.hit.edu.projectnew.pojo;

public class announcement {
    private Integer ID;
    private String annoContent;

    public announcement() {
    }

    public announcement(Integer ID, String annoContent) {
        this.ID = ID;
        this.annoContent = annoContent;
    }

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getAnnoContent() {
        return annoContent;
    }

    public void setAnnoContent(String annoContent) {
        this.annoContent = annoContent;
    }

    @Override
    public String toString() {
        return "announcement{" +
                "ID=" + ID +
                ", annoContent='" + annoContent + '\'' +
                '}';
    }
}