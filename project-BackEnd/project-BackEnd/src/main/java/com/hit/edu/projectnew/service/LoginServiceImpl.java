package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.administrator;
import com.hit.edu.projectnew.pojo.student;
import com.hit.edu.projectnew.pojo.teacher;
import com.hit.edu.projectnew.mapper.AdministratorMapper;
import com.hit.edu.projectnew.mapper.StudentMapper;
import com.hit.edu.projectnew.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class LoginServiceImpl implements LoginService{

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private AdministratorMapper administratorMapper;
    @Override
    public administrator findAdminById(String id) {
        return administratorMapper.findAdminById(id);
    }
    @Override
    public teacher findTeacherById(String id) {
        return teacherMapper.findTeacherById(id);
    }
    @Override
    public student findStudentById(String id) {
        return studentMapper.findStudentById(id);
    }

    private Map<String, String> verificationCodes = new HashMap<>();

    public String generateVerificationCode(String email) {
        String code = String.valueOf(new Random().nextInt(999999));
        verificationCodes.put(email, code);
        return code;
    }

    public boolean verifyCode(String email, String code) {
        return code.equals(verificationCodes.get(email));
    }

    public void updatePassword(String id, String newPassword, String identity) {
        switch (identity) {
            case "1": // Administrator
                administratorMapper.updatePassword(id, newPassword);
                break;
            case "2": // Teacher
                teacherMapper.updatePassword(id, newPassword);
                break;
            case "3": // Student
                studentMapper.updatePassword(id, newPassword);
                break;
            default:
                throw new IllegalArgumentException("Invalid identity");
        }
    }

    @Override
    public String getEmail(String ID, String identity) {
        switch (identity) {
            case "1": // Administrator
                String email1 = administratorMapper.getEmail(ID);
                return email1;
            case "2": // Teacher
                String email2 = teacherMapper.getEmail(ID);
                return email2;
            case "3": // Student
                String email3 = studentMapper.getEmail(ID);
                return email3;
            default:
                throw new IllegalArgumentException("Invalid identity");
        }
    }
}
