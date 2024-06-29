package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.dto.User;
import com.hit.edu.projectnew.pojo.administrator;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.UpdateProvider;
import org.apache.ibatis.jdbc.SQL;

public interface AdministratorMapper {
    @Select("SELECT * FROM administrator WHERE AID = #{aid}")
    administrator findAdminById(String aid);
    @Update("UPDATE administrator SET code = #{newPassword} WHERE AID = #{id}")
    void updatePassword(@Param("id") String id, @Param("newPassword") String newPassword);
    @Select("SELECT email from administrator WHERE AID=#{ID}")
    String getEmail(String ID);
    @Select("SELECT COUNT(*) FROM administrator WHERE AID = #{AID}")
    int countByAccountId(String AID);
    @Select("SELECT AID AS ID, name, gender, telephone, email FROM administrator WHERE AID = #{AID}")
    User getAdminById(String AID);

    @UpdateProvider(type = AdministratorMapper.AdminSqlBuilder.class, method = "buildUpdateAdmin")
    void updateAdmin(@Param("user") User user);
    class AdminSqlBuilder {
        public String buildUpdateAdmin(final User user) {
            return new SQL() {{
                UPDATE("administrator");
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
                WHERE("AID = #{user.ID}");
            }}.toString();
        }
    }
}
