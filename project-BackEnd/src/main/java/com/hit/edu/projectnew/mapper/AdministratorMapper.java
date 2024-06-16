package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.administrator;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface AdministratorMapper {
    @Select("SELECT * FROM administrator WHERE AID = #{aid}")
    administrator findAdminById(String aid);
    @Update("UPDATE administrator SET code = #{newPassword} WHERE AID = #{id}")
    void updatePassword(@Param("id") int id, @Param("newPassword") String newPassword);
    @Select("SELECT email from administrator WHERE AID=#{ID}")
    String getEmail(String ID);
}
