package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.pojo.administrator;
import com.hit.edu.projectnew.pojo.student;
import com.hit.edu.projectnew.pojo.teacher;
import com.hit.edu.projectnew.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private LoginService loginService;

    @PostMapping
    public Map<String, Object> login(@RequestBody Map<String, String> loginInfo) {
        String identity = loginInfo.get("identity");
        String id = loginInfo.get("id");
        String password = loginInfo.get("password");

        boolean success = false;
        String message = "Invalid credentials";

        switch (identity) {
            case "1": // Administrator
                administrator admin = loginService.findAdminById(Integer.parseInt(id));
                if (admin != null && admin.getCode().equals(password)) {
                    success = true;
                    message = "Login successful";
                }
                break;
            case "2": // Teacher
                teacher teacher = loginService.findTeacherById(id);
                if (teacher != null && teacher.getCode().equals(password)) {
                    success = true;
                    message = "Login successful";
                }
                break;
            case "3": // Student
                student student = loginService.findStudentById(id);
                if (student != null && student.getCode().equals(password)) {
                    success = true;
                    message = "Login successful";
                }
                break;
            default:
                message = "Invalid identity";
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", success);
        response.put("message", message);

        return response;
    }
}
