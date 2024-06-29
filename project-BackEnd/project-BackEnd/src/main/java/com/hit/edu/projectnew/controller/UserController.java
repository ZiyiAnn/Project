package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.dto.Student;
import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.pojo.classroom;
import com.hit.edu.projectnew.service.AdminService;
import com.hit.edu.projectnew.service.StudentService;
import com.hit.edu.projectnew.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
public class UserController {
  @Autowired
  private StudentService studentService;
  @Autowired
  private TeacherService teacherService;
  @Autowired
  private AdminService adminService;

  @GetMapping("/queryUser")
  public Map<String, Object> getUserbyID(@RequestParam String ID) {
    Map<String, Object> response = new HashMap<>();
    try {
      User user = null;
      if (studentService.isStudent(ID)) {
        user = studentService.getStudentByID(ID);
      } else if (teacherService.isTeacher(ID)) {
        user = teacherService.getTeacherById(ID);
      }else if (adminService.isAdmin(ID)) {
        user = adminService.getAdminByID(ID);
      }

      if (user != null) {
        response.put("success", true);
        response.put("message", "User query is successful.");
        response.put("user", user);
      } else {
        response.put("success", false);
        response.put("message", "No User found.");
      }
    } catch (Exception e) {
      response.put("success", false);
      response.put("message", "Error occurred: " + e.getMessage());
    }
    return response;
  }
  @PostMapping("/userUpdate")
  public Map<String, Object> updateUser(@RequestBody Map<String, String> userInfo) {
    Map<String, Object> response = new HashMap<>();
    int flag = 0;
    String ID = userInfo.get("ID");
    try {
      User user = null;
      if (studentService.isStudent(ID)) {
        user = studentService.getStudentByID(ID);
        flag = 3;
      } else if (teacherService.isTeacher(ID)) {
        user = teacherService.getTeacherById(ID);
        flag = 2;
      }else if (adminService.isAdmin(ID)) {
        user = adminService.getAdminByID(ID);
        flag = 1;
      }

      if (user != null) {
        if (userInfo.containsKey("name") && userInfo.get("name")!="") {
          user.setName(userInfo.get("name"));

        }
        if (userInfo.containsKey("gender") && userInfo.get("gender")!="") {
          String genderValue = userInfo.get("gender");
          if (!genderValue.isEmpty()) {
            user.setGender(Integer.parseInt(genderValue));
          }
        }
        if (userInfo.containsKey("telephone")) {
          String telephoneValue = userInfo.get("telephone");
          if (!telephoneValue.isEmpty()) {
            user.setTelephone(Long.parseLong(telephoneValue));
          }
        }

        if (userInfo.containsKey("email") && userInfo.get("email")!="") {
          user.setEmail(userInfo.get("email"));
        }
        if(flag == 3){
          studentService.updateStudent(user);
        }
        else if(flag == 2){
          teacherService.updateTeacher(user);
        }else if(flag == 1){
          adminService.updateAdmin(user);
        }
        response.put("success", true);
        response.put("message", "userInfo updated successfully.");
      } else {
        response.put("success", false);
        response.put("message", "No User found.");
      }

    } catch (Exception e) {
      response.put("success", false);
      response.put("message", "Failed to update: " + e.getMessage());
    }
    return response;
  }
}
