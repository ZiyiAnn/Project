package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.dto.Reservecheck;
import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.reservation;
import org.apache.ibatis.annotations.*;
import org.springframework.data.relational.core.sql.In;

import java.time.LocalDate;
import java.util.List;

public interface ReservationMapper {
    @Insert("INSERT INTO reservation (CID, occuStatus, occuTime, reservations, reason, type, dateTime) VALUES (#{CID}, #{occuStatus}, #{occuTime}, #{reservations}, #{reason}, #{type}, #{dateTime})")
    void insertReservation(reservation reservation);
    @Update("UPDATE reservation SET occuStatus = type WHERE CID=#{CID} and occuTime=#{occuTime} and dateTime= #{dateTime} and reservations=#{reservations}")
    void copyTypeToOccuStatus(checklist checklist);
    @Select("SELECT r.* FROM reservation r " +
            "JOIN checklist c ON r.CID = c.CID AND r.dateTime = c.dateTime AND r.occuTime = c.occuTime AND r.reservations = c.reservations " +
            "WHERE c.checkStatus = 0")
    List<reservation> getNoReservations();

    @Select("SELECT r.* FROM reservation r " +
            "JOIN checklist c ON r.CID = c.CID AND r.dateTime = c.dateTime AND r.occuTime = c.occuTime AND r.reservations = c.reservations " +
            "WHERE c.checkStatus IN (1, 2)")
    List<reservation> getYesReservations();

    @Select("SELECT * from reservation WHERE dateTime=#{dateTime} AND CID=#{CID}")
    List<reservation> getReservationsByDateAndCID(LocalDate dateTime, Integer CID);

    @Select("SELECT * from reservation WHERE dateTime=#{dateTime} AND CID=#{CID} AND occuTime=#{occuTime}")
    List<reservation> getReservationsByDateAndCIDAndTime(LocalDate dateTime, Integer CID, Integer occuTime);

    @Select("SELECT type from reservation WHERE dateTime=#{dateTime} AND CID=#{CID} AND occuTime=#{occuTime} AND reservations=#{reservations}")
    Integer getReservationsByPrimary(LocalDate dateTime, Integer CID, Integer occuTime, String reservations);

    @Update("UPDATE reservation " +
        "SET occuStatus = #{type} " +
        "WHERE CID = #{CID} " +
        "AND occuTime = #{occuTime} " +
        "AND dateTime = #{dateTime}")
    void updateOccuStatusInReservations(@Param("type") int type,
                                        @Param("CID") int CID,
                                        @Param("occuTime") int occuTime,
                                        @Param("dateTime") LocalDate dateTime);

    @Update("UPDATE checklist " +
        "SET checkStatus = 2 " +
        "WHERE CID = #{CID} " +
        "AND occuTime = #{occuTime} " +
        "AND dateTime = #{dateTime}"+
        "AND checkStatus = 0")
    void updateCheckStatusInChecklist(@Param("CID") int CID,
                                      @Param("occuTime") int occuTime,
                                      @Param("dateTime") LocalDate dateTime);
    @Delete("DELETE FROM reservation WHERE CID = #{CID} AND occuStatus = 2")
    void deleteReservationByCID(Integer CID);

    @Select("SELECT r.CID AS CID, r.occuStatus AS occuStatus ,r.occuTime AS occuTime, r.reservations AS reservations, r.reason AS reason, r.dateTime AS dateTime, r.type AS type, c.checkStatus AS checkStatus FROM reservation r " +
        "JOIN checklist c ON r.CID = c.CID AND r.dateTime = c.dateTime AND r.occuTime = c.occuTime AND r.reservations = c.reservations " +
        "WHERE r.reservations = #{ID}")
    List<Reservecheck> getUserReservations(String ID);

    @Delete("DELETE FROM reservation WHERE CID=#{CID} and occuTime=#{occuTime} and dateTime=#{dateTime} and reservations=#{reservations} ")
    void deleteReservation(reservation reservation);
}
