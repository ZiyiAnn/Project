package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.administrator;
import org.apache.ibatis.annotations.Select;

public interface AdministratorMapper {
    @Select("SELECT * FROM administrator WHERE aid = #{aid}")
    administrator findAdminById(Integer aid);
}
