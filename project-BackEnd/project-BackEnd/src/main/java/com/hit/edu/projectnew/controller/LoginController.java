package com.hit.edu.projectnew.controller;

import com.hit.edu.projectnew.pojo.administrator;
import com.hit.edu.projectnew.pojo.student;
import com.hit.edu.projectnew.pojo.teacher;
import com.hit.edu.projectnew.service.EmailService;
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
                administrator admin = loginService.findAdminById(id);
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
    @Autowired
    private EmailService emailService;
    @PostMapping("/forgotPassword")
    public Map<String, Object> forgotPassword(@RequestBody Map<String, String> forgotInfo) {
        Map<String, Object> response = new HashMap<>();
        try{
            String ID = forgotInfo.get("ID");
            String identity = forgotInfo.get("identity");
            String email = loginService.getEmail(ID, identity);
            if(email == null){
                response.put("success", false);
                response.put("message", "Wrong ID or Wrong Email!");
            }
            String code = loginService.generateVerificationCode(email);
            emailService.sendSimpleMessage(email, "Password Reset Code", "Your verification code is " + code);

            response.put("success", true);
            response.put("message", "Verification code sent to email");
        }catch (Exception e){
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    @PostMapping("/resetPassword")
    public Map<String, Object> resetPassword(@RequestBody Map<String, String> resetInfo) {
        Map<String, Object> response = new HashMap<>();
        try{
            String ID = resetInfo.get("ID");
            String code = resetInfo.get("code");
            String newPassword = resetInfo.get("newPassword");
            String identity = resetInfo.get("identity");
            String email = loginService.getEmail(ID, identity);
            boolean success = loginService.verifyCode(email, code);
            String message = success ? "Password reset successful" : "Invalid verification code";

            if (success) {
                loginService.updatePassword(ID, newPassword, identity);
                System.out.println("----------------4");
            }
            response.put("success", success);
            response.put("message", message);
        }catch (Exception e){
            response.put("success", false);
            response.put("message", "No email!"+e.getMessage());
        }
        return response;
    }
}
