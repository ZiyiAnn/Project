package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.announcement;
import com.hit.edu.projectnew.pojo.classroom;

import java.util.List;

public interface AnnouncementService {
  List<announcement> getAllAnno();
  public void addAnno(String annoContent);

  public void deleteAnno(Integer ID);
}
