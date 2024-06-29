package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.Student;
import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.pojo.classroom;

public interface StudentService {
    public boolean isStudent(String SID);
    public User getStudentByID(String SID);
    public void updateStudent(User user);
}
