package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.ChecklistMapper;
import com.hit.edu.projectnew.mapper.ReservationMapper;
import com.hit.edu.projectnew.pojo.checklist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class ChecklistServiceImpl implements ChecklistService{
    @Autowired
    private ChecklistMapper checklistMapper;
    @Autowired
    private ReservationMapper reservationMapper;

    @Override
    public void addChecklist(checklist checklist) {
        checklistMapper.insertChecklist(checklist);
    }

    @Override
    public void updateChecklist(checklist checklist) {
        checklistMapper.updateCHecklist(checklist);
    }

    @Override
    public void deleteChecklistByCID(Integer CID) {
        checklistMapper.deleteChecklistByCID(CID);
    }

    @Override
    public void deleteChecklist(checklist checklist) {
        checklistMapper.deleteChecklist(checklist);
    }

    @Override
    public List<checklist> getChecklistsByDateAndCIDAndTime(LocalDate dateTime, Integer CID, Integer occuTime) {
        return checklistMapper.getChecklistsByDateAndCIDAndTime(dateTime, CID, occuTime);
    }

    public void updateStatuses(checklist checklist) throws Exception {
        // Step 1: Get the type from reservations
        Integer type = reservationMapper.getReservationsByPrimary(checklist.getDateTime(), checklist.getCID(), checklist.getOccuTime(), checklist.getReservations());

        if (type == null) {
            throw new Exception("No matching record found in reservations");
        }

        // Step 2: Update occuStatus in reservations
        reservationMapper.updateOccuStatusInReservations(type, checklist.getCID(), checklist.getOccuTime(), checklist.getDateTime());

        // Step 3: Update checkStatus in checklist
        reservationMapper.updateCheckStatusInChecklist(checklist.getCID(), checklist.getOccuTime(), checklist.getDateTime());
    }
}
