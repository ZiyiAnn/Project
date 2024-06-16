package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.Reservecheck;
import com.hit.edu.projectnew.mapper.ReservationMapper;
import com.hit.edu.projectnew.mapper.timeTableMapper;
import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.reservation;
import com.hit.edu.projectnew.pojo.timeTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
@Service
public class ReservationServiceImpl implements ReservationService{
    @Autowired
    private ReservationMapper reservationMapper;
    @Autowired
    private timeTableMapper timeTableMapper;

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
    @Override
    public List<timeTable> getAllTimeTable() {
        return timeTableMapper.getAllTimeTable();
    }

    @Override
    public void deleteReservationByCID(Integer CID) {
        reservationMapper.deleteReservationByCID(CID);
    }

    @Override
    public List<Reservecheck> getUserReservations(String ID) {
        return reservationMapper.getUserReservations(ID);
    }

    @Override
    public void deleteReservation(reservation reservation) {
        reservationMapper.deleteReservation(reservation);
    }

}
