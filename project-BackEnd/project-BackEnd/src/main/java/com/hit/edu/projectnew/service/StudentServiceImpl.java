package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.Student;
import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.mapper.StudentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentMapper studentMapper;
    @Override
    public boolean isStudent(String SID) {
        if(studentMapper.countByAccountId(SID)>0){
            return true;
        }else {
            return false;
        }
    }

    @Override
    public User getStudentByID(String SID) {
        return studentMapper.getStudentById(SID);
    }

    @Override
    public void updateStudent(User user) {
        studentMapper.updateStudent(user);
    }
}
