package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.teacher;
import org.apache.ibatis.annotations.Select;

public interface TeacherMapper {
    @Select("SELECT * FROM teacher WHERE tid = #{tid}")
    teacher findTeacherById(String tid);
    @Select("SELECT COUNT(*) FROM teacher WHERE TID = #{TID}")
    int countByAccountId(String TID);
}
