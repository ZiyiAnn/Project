package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.TeacherMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TeacherServiceImpl implements TeacherService{
    @Autowired
    private TeacherMapper teacherMapper;
    @Override
    public boolean isTeacher(String TID) {
        if(teacherMapper.countByAccountId(TID)>0){
            return true;
        }else {
            return false;
        }
    }
}
