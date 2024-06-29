package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.administrator;
import com.hit.edu.projectnew.pojo.student;
import com.hit.edu.projectnew.pojo.teacher;

public interface LoginService {
    public administrator findAdminById(String id);
    public teacher findTeacherById(String id);
    public student findStudentById(String id);
    public String generateVerificationCode(String email);
    public boolean verifyCode(String email, String code);
    public void updatePassword(String id, String newPassword, String identity);
    String getEmail(String ID, String identity);
}
