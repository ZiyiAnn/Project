package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.administrator;
import com.hit.edu.projectnew.pojo.student;
import com.hit.edu.projectnew.pojo.teacher;
import com.hit.edu.projectnew.mapper.AdministratorMapper;
import com.hit.edu.projectnew.mapper.StudentMapper;
import com.hit.edu.projectnew.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService{

    @Autowired
    private StudentMapper studentMapper;

    @Autowired
    private TeacherMapper teacherMapper;

    @Autowired
    private AdministratorMapper administratorMapper;
    @Override
    public administrator findAdminById(Integer id) {
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
}
