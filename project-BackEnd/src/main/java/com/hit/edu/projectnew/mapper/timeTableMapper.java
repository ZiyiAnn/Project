package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.timeTable;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface timeTableMapper {
    @Select("SELECT * from timeTable")
    List<timeTable> getAllTimeTable();
}
