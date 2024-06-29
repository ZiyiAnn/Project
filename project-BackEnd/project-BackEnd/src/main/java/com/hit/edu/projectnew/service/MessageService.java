package com.hit.edu.projectnew.service;

import com.hit.edu.projectnew.pojo.checklist;
import com.hit.edu.projectnew.pojo.message;

import java.util.List;

public interface MessageService {
  public void addMessage(message message) throws Exception;
  public void updateMessageStatus(Integer ID);
  public List<message> getAllMessage();
  public List<message> getYesMessage();
  public List<message> getNoMessage();
}
