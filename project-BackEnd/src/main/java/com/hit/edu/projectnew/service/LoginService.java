package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.administrator;
import com.hit.edu.projectnew.pojo.student;
import com.hit.edu.projectnew.pojo.teacher;

public interface LoginService {
    public administrator findAdminById(Integer id);
    public teacher findTeacherById(String id);
    public student findStudentById(String id);
}
