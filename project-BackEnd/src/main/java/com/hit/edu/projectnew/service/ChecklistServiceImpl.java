package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.ChecklistMapper;
import com.hit.edu.projectnew.mapper.ReservationMapper;
import com.hit.edu.projectnew.pojo.checklist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChecklistServiceImpl implements ChecklistService{
    @Autowired
    private ChecklistMapper checklistMapper;

    @Override
    public void addChecklist(checklist checklist) {
        checklistMapper.insertChecklist(checklist);
    }

    @Override
    public void updateChecklist(checklist checklist) {
        checklistMapper.updateCHecklist(checklist);
    }
}
