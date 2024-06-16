package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.dto.Teacher;
import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.pojo.teacher;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.UpdateProvider;
import org.apache.ibatis.jdbc.SQL;

public interface TeacherMapper {
    @Select("SELECT * FROM teacher WHERE TID = #{TID}")
    teacher findTeacherById(String TID);
    @Select("SELECT TID AS ID, name, gender, telephone, email FROM teacher WHERE TID = #{TID}")
    User getTeacherById(String TID);
    @Select("SELECT COUNT(*) FROM teacher WHERE TID = #{TID}")
    int countByAccountId(String TID);
    @UpdateProvider(type = TeacherMapper.TeacherSqlBuilder.class, method = "buildUpdateTeacher")
    void updateTeacher(@Param("user") User user);
    class TeacherSqlBuilder {
        public String buildUpdateTeacher(final User user) {
            return new SQL() {{
                UPDATE("teacher");
                if (user.getName()!= null ) {
                    SET("name = #{user.name}");
                }
                if (user.getGender() != null) {
                    SET("gender = #{user.gender}");
                }
                if (user.getTelephone() != null) {
                    SET("telephone = #{user.telephone}");
                }
                if (user.getEmail() != null) {
                    SET("email = #{user.email}");
                }
                WHERE("TID = #{user.ID}");
            }}.toString();
        }
    }
}
