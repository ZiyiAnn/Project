package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.ReservationMapper;
import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.reservation;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.util.List;

public interface ChecklistService {

    public void addChecklist(checklist checklist);
    public void updateChecklist(checklist checklist);
    public void deleteChecklistByCID(Integer CID);
    public void deleteChecklist(checklist checklist);
    public List<checklist> getChecklistsByDateAndCIDAndTime(LocalDate dateTime, Integer CID, Integer occuTime);
    public void updateStatuses(checklist checklist) throws Exception;
}
