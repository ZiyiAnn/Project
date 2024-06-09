package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.pojo.classroom;
import com.hit.edu.projectnew.pojo.reservation;
import com.hit.edu.projectnew.service.ClassroomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController

public class ClassroomController {

    @Autowired
    private ClassroomService classroomService;

    @GetMapping
    public List<classroom> getAllClassrooms() {
        return classroomService.findAllClassrooms();
    }

    @RequestMapping("/classroomAdd")
    @PostMapping
    public Map<String, Object> addClassroom(@RequestBody Map<String, String> classroomInfo) {
        Map<String, Object> response = new HashMap<>();
        Integer CID = Integer.parseInt(classroomInfo.get("CID"));
        Integer content = Integer.parseInt(classroomInfo.get("content"));
        String building = classroomInfo.get("building");
        Integer campus = Integer.parseInt(classroomInfo.get("campus"));
        String equipment = classroomInfo.get("equipment");
        classroom classroom = new classroom();
        classroom.setCID(CID);
        classroom.setContent(content);
        classroom.setBuilding(building);
        classroom.setCampus(campus);
        classroom.setEquipment(equipment);
        try {
            classroomService.addClassroom(classroom);
            response.put("success", true);
            response.put("message", "Classroom added successfully");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
//    @RequestMapping("/classroomDelete")
    @DeleteMapping("/classroomDelete/{CID}")
    public Map<String, Object> deleteClassroom(@PathVariable int CID) {
        Map<String, Object> response = new HashMap<>();
        try {
            classroomService.deleteClassroom(CID);
            response.put("success", true);
            response.put("message", "Classroom deleted successfully");
            response.put("CID", CID); // 返回被删除的教室的CID
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }
//    @PutMapping("/classroomUpdate/{CID}")
//    public Map<String, Object> updateClassroomStatus(@PathVariable int CID, @RequestBody Map<String, Object> updateInfo) {
//        Map<String, Object> response = new HashMap<>();
//
////        // 检查用户是否登录，以及其身份是否为管理员
////        User currentUser = (User) session.getAttribute("currentUser");
////        if (currentUser == null || !currentUser.getRole().equals("admin")) {
////            response.put("success", false);
////            response.put("message", "Only administrators can update classroom status");
////            return response;
////        }
//
//        // 获取更新信息
//        boolean status = (boolean) updateInfo.get("status");
//
//        try {
//            // 更新教室状态
//            classroomService.updateClassroomStatus(CID, status);
//            response.put("success", true);
//            response.put("message", "Classroom status updated successfully");
//            response.put("CID", CID);
//        } catch (Exception e) {
//            response.put("success", false);
//            response.put("message", e.getMessage());
//        }
//        return response;
//
//    }
    // 更新classroom信息的方法
//    @RequestMapping("/classroomUpdate")
//    @PostMapping
//    public Map<String, Object> updateClassroom(@RequestBody Map<String, String> classroomInfo) {
//        Map<String, Object> response = new HashMap<>();
//        Integer CID = Integer.parseInt(classroomInfo.get("CID"));
//        Integer content = Integer.parseInt(classroomInfo.get("content"));
//        String building = classroomInfo.get("building");
//        Integer campus = Integer.parseInt(classroomInfo.get("campus"));
//        String equipment = classroomInfo.get("equipment");
//
//        classroom classroom = new classroom();
//        classroom.setCID(CID);
//        classroom.setContent(content);
//        classroom.setBuilding(building);
//        classroom.setCampus(campus);
//        classroom.setEquipment(equipment);
//
//        boolean exists = classroomService.checkClassroomExists(CID);
//        if (!exists) {
//            response.put("success", false);
//            response.put("message", "Classroom with CID " + CID + " does not exist.");
//            return response;
//        }
//
//        try {
//            classroomService.updataClassroom(classroom);
//            response.put("success", true);
//            response.put("message", "Classroom updated successfully.");
//        } catch (Exception e) {
//            response.put("success", false);
//            response.put("message", "Failed to update classroom.");
//        }
//
//        return response;
//    }
    @PostMapping("/classroomUpdate")
    public Map<String, Object> updateClassroom(@RequestBody Map<String, String> classroomInfo) {
        Map<String, Object> response = new HashMap<>();

        Integer CID = Integer.parseInt(classroomInfo.get("CID"));
        classroom existingClassroom = classroomService.findClassroomById(CID);
        if (existingClassroom == null) {
            response.put("success", false);
            response.put("message", "Classroom with CID " + CID + " does not exist.");
            return response;
        }

        try {
            if (classroomInfo.containsKey("content")) {
                String contentValue = classroomInfo.get("content");
                if (!contentValue.isEmpty()) {
                    existingClassroom.setCampus(Integer.parseInt(contentValue));
                }
            }
            if (classroomInfo.containsKey("building") && classroomInfo.get("building")!="") {
                existingClassroom.setBuilding(classroomInfo.get("building"));
            }
            if (classroomInfo.containsKey("campus")) {
                String campusValue = classroomInfo.get("campus");
                if (!campusValue.isEmpty()) {
                    existingClassroom.setCampus(Integer.parseInt(campusValue));
                }
            }

            if (classroomInfo.containsKey("equipment") && classroomInfo.get("equipment")!="") {
                existingClassroom.setEquipment(classroomInfo.get("equipment"));
            }

            classroomService.updateClassroom(existingClassroom);
            response.put("success", true);
            response.put("message", "Classroom updated successfully.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to update classroom: " + e.getMessage());
        }

        return response;
    }

    @GetMapping("/classroomSelect")
    public Map<String, Object> findClassrooms(@RequestParam Map<String, Object> classroomInfo) {
        Map<String, Object> response = new HashMap<>();
        try {
            List<classroom> classrooms = classroomService.findClassroomsByConditions(classroomInfo);
            response.put("success", true);
            response.put("classrooms", classrooms);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to find classrooms: " + e.getMessage());
        }
        return response;
    }

}
