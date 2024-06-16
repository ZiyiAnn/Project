package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.dto.Reservecheck;
import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.reservation;
import com.hit.edu.projectnew.pojo.timeTable;
import com.hit.edu.projectnew.service.ChecklistService;
import com.hit.edu.projectnew.service.ReservationService;
import com.hit.edu.projectnew.service.StudentService;
import com.hit.edu.projectnew.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

import java.text.ParseException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@RestController
public class ReservationController {
    @Autowired
    private ReservationService reservationService;
    @Autowired
    private ChecklistService checklistService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private TeacherService teacherService;

    @RequestMapping("/reserveClassroom")
    @PostMapping
    public Map<String, Object> reserveClassroom(@RequestBody Map<String, String> reservationInfo) {
        Map<String, Object> response = new HashMap<>();
        Integer CID = Integer.parseInt(reservationInfo.get("CID"));
        Integer occuStatus = 1;
        Integer occuTime = Integer.parseInt(reservationInfo.get("occuTime"));
        String reservations = reservationInfo.get("reservations");
        String reason = reservationInfo.get("reason");
        Integer type = Integer.parseInt(reservationInfo.get("type"));
        String dateString = reservationInfo.get("dateTime"); // 假设前端传递的日期字段名为 "date"
        LocalDate dateTime = LocalDate.parse(dateString);
        Integer checkStatus = 0;

        // 检查账号是否在学生表或教师表中
        boolean isStudent = studentService.isStudent(reservations);
        boolean isTeacher = teacherService.isTeacher(reservations);
        if (!isStudent && !isTeacher) {
            response.put("success", false);
            response.put("message", "Account not found in student or teacher records.");
            return response;
        }

        // 获取当前日期和时间
        LocalDateTime currentDateTime = LocalDateTime.now();
        // 获取七天后的日期和时间
        LocalDateTime sevenDaysLaterDateTime = currentDateTime.plusDays(7);
// 检查预约时间是否在当前时间之后且在七天内
        LocalDateTime reservationDateTime = dateTime.atTime(23, 59);
        if (reservationDateTime.isBefore(currentDateTime) || reservationDateTime.isAfter(sevenDaysLaterDateTime)) {
            response.put("success", false);
            response.put("message", "Reservation time must be after the current time and within seven days.");
            return response;
        }

        reservation reservation = new reservation();
        checklist checklist = new checklist();

        reservation.setCID(CID);
        reservation.setOccuStatus(occuStatus);
        reservation.setOccuTime(occuTime);
        reservation.setReservations(reservations);
        reservation.setReason(reason);
        reservation.setType(type);
        reservation.setDateTime(dateTime);

        checklist.setCID(CID);
        checklist.setOccuTime(occuTime);
        checklist.setCheckStatus(checkStatus);
        checklist.setDateTime(dateTime);
        checklist.setReservations(reservations);

        try {
            reservationService.addReservation(reservation);
            checklistService.addChecklist(checklist);
            response.put("success", true);
            response.put("message", "Reservation added successfully.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to add reservation: " + e.getMessage());
        }

        return response;
    }
    @PutMapping("/updateChecklist")
//    @RequestMapping("/updateChecklist")
//    @PostMapping
    public Map<String, Object> updateChecklist(@RequestBody Map<String, String> checklistInfo) {
        Map<String, Object> response = new HashMap<>();
        try {
            Integer CID = Integer.parseInt(checklistInfo.get("CID"));
            Integer occuTime = Integer.parseInt(checklistInfo.get("occuTime"));
            Integer checkStatus = Integer.parseInt(checklistInfo.get("checkStatus"));
            String reservations = checklistInfo.get("reservations");
            String dateString = checklistInfo.get("dateTime"); // 假设前端传递的日期字段名为 "date"
            LocalDate dateTime = LocalDate.parse(dateString);

            checklist checklist = new checklist();
            checklist.setCID(CID);
            checklist.setOccuTime(occuTime);
            checklist.setCheckStatus(checkStatus);
            checklist.setDateTime(dateTime);
            checklist.setReservations(reservations);

            checklistService.updateChecklist(checklist);
//            审核通过
            if (checkStatus==1){
                reservationService.copyTypeToOccuStatus(checklist);
            }
            response.put("success", true);
            response.put("message", "Checklist updated successfully.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to update checklist: " + e.getMessage());
        }
        return response;
    }
    @GetMapping("/checkReservationsNo")
    public Map<String, Object> getNoReservations() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<reservation> reservations = reservationService.getNoReservations();
            response.put("success", true);
            response.put("reservations", reservations);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to fetch reservations: " + e.getMessage());
        }
        return response;
    }
    @GetMapping("/checkReservationsYes")
    public Map<String, Object> getYesReservations() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<reservation> reservations = reservationService.getYesReservations();
            response.put("success", true);
            response.put("reservations", reservations);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to fetch reservations: " + e.getMessage());
        }
        return response;
    }
    // 新的端点，用于获取特定日期和教室的预约情况
    @GetMapping("/preReserveClassroom")
    public Map<String, Object> getReservationsByDateAndCID(@RequestParam String dateTime, @RequestParam Integer CID) {
        Map<String, Object> response = new HashMap<>();
        try {
            LocalDate reservationDate = LocalDate.parse(dateTime);
            List<reservation> reservations = reservationService.getReservationsByDateAndCID(reservationDate, CID);

            // 初始化时间段的状态
            Map<Integer, Integer> timeSlots = new HashMap<>();
            for (int i = 1; i <= 12; i++) {
                timeSlots.put(i, 0); // 默认所有时间段均未预约
            }

            // 更新被预约的时间段状态
            for (reservation res : reservations) {
                timeSlots.put(res.getOccuTime(), 1);
            }

            response.put("success", true);
            response.put("timeSlots", timeSlots);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to fetch reservations: " + e.getMessage());
        }
        return response;
    }
    @GetMapping("/Schedule")
    public Map<String, Object> classroomUpdateSchedule() {
        Map<String, Object> response = new HashMap<>();
        try {
            List<timeTable> timeTables = reservationService.getAllTimeTable();
            for (timeTable table : timeTables) {
                String schedule = table.getSchedule(); // 获取课表的字符串表示
                int CID = table.getCID(); // 获取教室号
                LocalDate dateTime = table.getDateTime();
                for (int i = 0; i < schedule.length(); i++) {
                    if (schedule.charAt(i) == '1') {
                        // 如果当前时间段有课，则添加预约申请
                        reservation newReservation = new reservation();
                        newReservation.setCID(CID);
                        newReservation.setOccuStatus(5); // 占用状态设为5
                        newReservation.setOccuTime(i + 1); // 时间段为当前循环的索引加1
                        newReservation.setReservations("Admin"); // 申请者先为空
                        newReservation.setReason("class"); // 原因先为空
                        newReservation.setType(5); // 类型设为5
                        newReservation.setDateTime(dateTime);
                        // 将新的预约申请添加到数据库中
                        checklist newChecklist = new checklist();
                        newChecklist.setCID(CID);
                        newChecklist.setOccuTime(i+1);
                        newChecklist.setReservations("Admin");
                        newChecklist.setDateTime(dateTime);
                        newChecklist.setCheckStatus(1);

                       reservationService.addReservation(newReservation);
                       checklistService.addChecklist(newChecklist);
                    }
                }
            }
            response.put("success", true);
            response.put("message", "Reservations added successfully.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to add reservations: " + e.getMessage());
        }
        return response;
    }
    @PutMapping("/classroomUpdateStatus")
    public Map<String, Object> repairClassroom(@RequestBody Map<String, String> reservationInfo) {
        Map<String, Object> response = new HashMap<>();
        try {
            Integer CID = Integer.parseInt(reservationInfo.get("CID"));
            Integer occuTime = Integer.parseInt(reservationInfo.get("occuTime"));
            String dateString = reservationInfo.get("dateTime"); // 假设前端传递的日期字段名为 "date"
            Integer status = Integer.parseInt(reservationInfo.get("status"));
            LocalDate dateTime = LocalDate.parse(dateString);

            reservation reservation = new reservation();
            reservation.setCID(CID);
            reservation.setDateTime(dateTime);
            reservation.setReservations("Admin");
            reservation.setOccuTime(occuTime);
//
//            checklist newChecklist = new checklist();
//            newChecklist.setCID(CID);
//            newChecklist.setOccuTime(occuTime);
//            newChecklist.setReservations("Admin");
//            newChecklist.setDateTime(dateTime);
//            newChecklist.setCheckStatus(1);
            // 首先将教室状态设置为空闲
            if(status == 1){
//                reservationService.updateClassroomStatus(CID, dateTime, occuTime, status);
                // 然后删除对应的预约和审核记录
                reservationService.deleteReservationByCID(CID);
//                checklistService.deleteChecklistByCID(CID);
                response.put("success", true);
                response.put("message", "Classroom repair completed successfully.");
            } else if (status == 2) {
                reservation.setOccuStatus(2);
                reservation.setType(2);
                reservation.setReason("Repair");
                reservationService.addReservation(reservation);
//                checklistService.addChecklist(newChecklist);
                response.put("success", true);
                response.put("message", "Classroom repair registration.");
            }else if (status == 5){
                reservation.setOccuStatus(5);
                reservation.setType(5);
                reservation.setReason("Class");
                reservationService.addReservation(reservation);
//                checklistService.addChecklist(newChecklist);
                response.put("success", true);
                response.put("message", "Classroom class registration.");
            } else if (status == 3) {
                reservation.setOccuStatus(3);
                reservation.setType(3);
                reservation.setReason("Exam");
                reservationService.addReservation(reservation);
//                checklistService.addChecklist(newChecklist);
                response.put("success", true);
                response.put("message", "Classroom exam registration.");
            }


        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to repair classroom: " + e.getMessage());
        }
        return response;
    }

    @GetMapping("/checkUserReservations")
    public Map<String, Object> getUserReservations(@RequestParam String ID) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<Reservecheck> reservations = reservationService.getUserReservations(ID);
            response.put("success", true);
            response.put("reservations", reservations);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to fetch reservations: " + e.getMessage());
        }
        return response;
    }
    @PostMapping("/deleteUserReservations")
    public Map<String, Object> deleteUserReservations(@RequestBody Map<String, String> reservationInfo) {
        Map<String, Object> response = new HashMap<>();
        try {
            Integer CID = Integer.parseInt(reservationInfo.get("CID"));
            Integer occuTime = Integer.parseInt(reservationInfo.get("occuTime"));
            String dateString = reservationInfo.get("dateTime");
            LocalDate dateTime = LocalDate.parse(dateString);
            String reservations = reservationInfo.get("reservations");

            reservation reservation = new reservation();
            reservation.setCID(CID);
            reservation.setDateTime(dateTime);
            reservation.setOccuTime(occuTime);
            reservation.setReservations(reservations);

            checklist checklist = new checklist();
            checklist.setCID(CID);
            checklist.setDateTime(dateTime);
            checklist.setOccuTime(occuTime);
            checklist.setReservations(reservations);
            reservationService.deleteReservation(reservation);
            checklistService.deleteChecklist(checklist);
            response.put("success", true);
            response.put("reservations", reservation);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to fetch reservation: " + e.getMessage());
        }
        return response;
    }
}
