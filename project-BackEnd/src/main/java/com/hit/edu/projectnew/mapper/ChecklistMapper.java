package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.checklist;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

public interface ChecklistMapper {
    @Insert("INSERT INTO checklist (CID, occuTime,checkStatus,dateTime, reservations) VALUES (#{CID}, #{occuTime}, #{checkStatus}, #{dateTime}, #{reservations})")
    void insertChecklist(checklist checklist);

    @Update("UPDATE checklist SET checkStatus=#{checkStatus} WHERE CID=#{CID} and occuTime=#{occuTime} and dateTime=#{dateTime} and reservations=#{reservations}")
    void updateCHecklist(checklist checklist);
}
