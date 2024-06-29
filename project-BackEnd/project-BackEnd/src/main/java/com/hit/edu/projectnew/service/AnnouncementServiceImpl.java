package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.mapper.AnnouncementMapper;
import com.hit.edu.projectnew.pojo.announcement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnnouncementServiceImpl implements AnnouncementService{
  @Autowired
  private AnnouncementMapper announcementMapper;
  @Override
  public List<announcement> getAllAnno() {
    return announcementMapper.getAllAnno();
  }

  @Override
  public void addAnno(String annoContent) throws Exception {
    if (annoContent.length() > 65535) {
      throw new Exception("Content cannot exceed 65535 characters");
    }else{
      announcementMapper.addAnno(annoContent);
    }
  }

  @Override
  public void deleteAnno(Integer ID) {
    announcementMapper.deleteAnno(ID);
  }
}
