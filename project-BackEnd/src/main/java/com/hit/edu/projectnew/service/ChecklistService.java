package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.ReservationMapper;
import com.hit.edu.projectnew.pojo.checklist;
import org.springframework.beans.factory.annotation.Autowired;

public interface ChecklistService {

    public void addChecklist(checklist checklist);
    public void updateChecklist(checklist checklist);
}
