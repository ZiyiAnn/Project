package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.dto.Student;
import com.hit.edu.projectnew.dto.Teacher;
import com.hit.edu.projectnew.dto.User;

public interface TeacherService {
    public boolean isTeacher(String TID);
    public User getTeacherById(String TID);
    public void updateTeacher(User user);
}
