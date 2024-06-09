package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.ReservationMapper;
import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
@Service
public class ReservationServiceImpl implements ReservationService{
    @Autowired
    private ReservationMapper reservationMapper;
    // 预约
    public void addReservation(reservation reservation) {
        reservationMapper.insertReservation(reservation);
    }

    public void copyTypeToOccuStatus(checklist checklist) {
        reservationMapper.copyTypeToOccuStatus(checklist);
    }
    public List<reservation> getNoReservations() {
        return reservationMapper.getNoReservations();
    }

    @Override
    public List<reservation> getYesReservations() {
        return  reservationMapper.getYesReservations();
    }

    @Override
    public List<reservation> getReservationsByDateAndCID(LocalDate dateTime, Integer CID) {
        return reservationMapper.getReservationsByDateAndCID(dateTime, CID);
    }

}
