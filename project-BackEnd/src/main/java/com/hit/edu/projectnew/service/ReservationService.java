package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.Reservecheck;
import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.reservation;
import com.hit.edu.projectnew.pojo.timeTable;

import java.time.LocalDate;
import java.util.List;

public interface ReservationService {
    public void addReservation(reservation reservation);
    public void copyTypeToOccuStatus(checklist checklist);
    public List<reservation> getNoReservations();
    public List<reservation> getYesReservations();
    public List<reservation> getReservationsByDateAndCID(LocalDate dateTime, Integer CID);
    public List<timeTable> getAllTimeTable();
    public void deleteReservationByCID(Integer CID);
    public List<Reservecheck> getUserReservations(String ID);
    public void deleteReservation(reservation reservation);
}
