package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.classroom;
import com.hit.edu.projectnew.pojo.reservation;
import org.springframework.data.relational.core.sql.In;

import java.util.List;
import java.util.Map;

public interface ClassroomService {
    //    public String getClassroomByCID(String CID);
    public List<classroom> findAllClassrooms();

    public void addClassroom(classroom classroom);

    public void deleteClassroom(Integer CID);

//    public void updateClassroomStatus(int CID, boolean newStatus);
    public void updateClassroom(classroom classroom);


    public boolean checkClassroomExists(Integer CID);
    public List<classroom> findClassroomsByConditions(Map<String, Object> conditions);

    public classroom findClassroomById(Integer CID);
}