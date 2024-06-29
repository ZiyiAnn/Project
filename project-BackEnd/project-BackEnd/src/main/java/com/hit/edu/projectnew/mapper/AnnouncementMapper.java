package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.announcement;
import com.hit.edu.projectnew.pojo.classroom;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface AnnouncementMapper {
  @Select("SELECT * FROM announcement")
  List<announcement> getAllAnno();
  @Insert("INSERT INTO announcement (annoContent) VALUES (#{annoContent})")
  void addAnno(String annoContent);

  @Delete("DELETE FROM announcement WHERE ID = #{ID}")
  void deleteAnno(int ID);
}
