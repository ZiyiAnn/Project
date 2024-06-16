package com.hit.edu.projectnew.mapper;


import com.hit.edu.projectnew.dto.Student;
import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.pojo.classroom;
import com.hit.edu.projectnew.pojo.student;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.UpdateProvider;
import org.apache.ibatis.jdbc.SQL;

public interface StudentMapper {
    @Select("SELECT * FROM student WHERE SID = #{SID}")
    student findStudentById(String SID);
    @Select("SELECT SID AS ID, name, gender, telephone, email FROM student WHERE SID = #{SID}")
    User getStudentById(String SID);
    @Select("SELECT COUNT(*) FROM student WHERE SID = #{SID}")
    int countByAccountId(String SID);
    @UpdateProvider(type = StudentMapper.StudentSqlBuilder.class, method = "buildUpdateStudent")
    void updateStudent(@Param("user") User user);
    class StudentSqlBuilder {
        public String buildUpdateStudent(final User user) {
            return new SQL() {{
                UPDATE("student");
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
                WHERE("SID = #{user.ID}");
            }}.toString();
        }
    }
    @Update("UPDATE student SET code = #{newPassword} WHERE SID = #{id}")
    void updatePassword(@Param("id") String id, @Param("newPassword") String newPassword);

    @Select("SELECT email from student WHERE SID=#{ID}")
    String getEmail(String ID);
}
