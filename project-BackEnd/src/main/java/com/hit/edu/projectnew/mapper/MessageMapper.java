package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.classroom;
import com.hit.edu.projectnew.pojo.message;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MessageMapper {
  @Select("SELECT * from message")
  List<message> getAllMessage();
  @Select("SELECT * from message WHERE status=1")
  List<message> getYesMessage();
  @Select("SELECT * from message WHERE status=0")
  List<message> getNoMessage();

  @Insert("INSERT INTO message (content, sender, receiver, dateTime, status) VALUES (#{content},#{sender},#{receiver},#{dateTime}, #{status})")
  void addMessage(message message);
  @Update("UPDATE message SET status=1 WHERE ID=#{ID}")
  void updateMessage(Integer ID);

}
