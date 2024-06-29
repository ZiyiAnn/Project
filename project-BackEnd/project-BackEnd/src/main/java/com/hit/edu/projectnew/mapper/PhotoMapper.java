package com.hit.edu.projectnew.mapper;

import com.hit.edu.projectnew.pojo.photo;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

public interface PhotoMapper {

  @Insert("INSERT INTO photo (CID, fileName, photoData) VALUES (#{CID}, #{fileName}, #{photoData})")
  void savePhoto(photo photo);

  @Select("SELECT * FROM photo WHERE CID = #{CID}")
  photo getPhotoById(Integer CID);
}
